use MultiMediaDB;

# 10. Remove Expired Subscriptions

# Automatically remove expired subscriptions from the User_Subscription table.
# Notify users of the expiration and removal.
DROP TABLE NOTIFICATIONS;
CREATE TABLE NOTIFICATIONS (
    idNotification INT NOT NULL AUTO_INCREMENT,
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    idUser INT NOT NULL,
    PRIMARY KEY (idNotification),
    FOREIGN KEY (idUser) REFERENCES User(idUser)

);

DROP EVENT IF EXISTS REMOVE_EXPIRED_SUBSCRIPTION;

DELIMITER $$

CREATE EVENT REMOVE_EXPIRED_SUBSCRIPTION
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
BEGIN

    INSERT INTO NOTIFICATIONS(message, idUser)
        SELECT CONCAT('The subscription of ', U.username, ' has expired.' ),U.idUser
            FROM User_Subscriptions
            JOIN MultiMediaDB.User U on U.idUser = User_Subscriptions.idUser
            WHERE NOW() > end_on OR end_on IS NULL OR status = 0;

    DELETE FROM User_Subscriptions
    WHERE NOW() > end_on OR end_on IS NULL OR status = 0;

END $$

DELIMITER ;


SELECT * FROM User_Subscriptions;
SELECT * FROM NOTIFICATIONS;

INSERT INTO User_Subscriptions(idSubscription, end_on, idUser, status) VALUES (2,'2025-04-10',4,1);


-- WORKS BUT NO NOTI


INSERT INTO NOTIFICATIONS(message, idUser)
        SELECT CONCAT('The subscription of ', U.username, 'has expired.' ),U.idUser
            FROM User_Subscriptions
            JOIN MultiMediaDB.User U on U.idUser = User_Subscriptions.idUser
            WHERE NOW() > end_on OR end_on IS NULL OR status = 0;


# 11. Refresh Popular Content Rankings
#
# Update a table storing the top 10 most popular Content for each Genre daily, based on view counts.
DROP TABLE IF EXISTS TOP_1O_POPULAR_CONTENT_TODAY;
CREATE TABLE TOP_1O_POPULAR_CONTENT_TODAY (
    idContent INT NOT NULL,
    name VARCHAR(200) NOT NULL,
    genre VARCHAR(100) NOT NULL,
    total_views INT NOT NULL
);

DROP EVENT IF EXISTS UPDATE_TOP_1O_POPULAR_CONTENT_TODAY;
DELIMITER $$

CREATE EVENT UPDATE_TOP_1O_POPULAR_CONTENT_TODAY
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    -- Step 1: Truncate the target table
    TRUNCATE TABLE TOP_1O_POPULAR_CONTENT_TODAY;

    -- Step 2: Create temp table with view counts per content and genre
    CREATE TEMPORARY TABLE IF NOT EXISTS TempRanked AS
        SELECT
            C.idContent AS idContent,
            C.title AS name,
            G.name AS genre,
            COUNT(WH.idUser) AS total_views
        FROM WatchHistory WH
        JOIN Content C ON C.idContent = WH.idContent
        JOIN Content_Genre CG ON C.idContent = CG.idContent
        JOIN Genre G ON G.idGenre = CG.idGenre
        GROUP BY C.idContent, C.title, G.name;

    -- Step 3: Reset session variables for ranking
    SET @cur_genre := '', @cur_rank := 0;

    -- Step 4: Insert top 10 per genre using manual rank
    INSERT INTO TOP_1O_POPULAR_CONTENT_TODAY (idContent, name, genre, total_views)
    SELECT ranked.idContent, ranked.name, ranked.genre, ranked.total_views
    FROM (
        SELECT
            idContent,
            name,
            genre,
            total_views,
            IF(@cur_genre = genre, @cur_rank := @cur_rank + 1, @cur_rank := 1) AS row_rank,
            @cur_genre := genre
        FROM TempRanked
        ORDER BY genre, total_views DESC
    ) AS ranked
    WHERE ranked.row_rank <= 10;

    -- Step 5: Clean up
    DROP TEMPORARY TABLE IF EXISTS TempRanked;

END $$
DELIMITER ;

-- WORKS
SELECT * FROM TOP_1O_POPULAR_CONTENT_TODAY;




