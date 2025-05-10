-- 4. Rank Top Genres by Watch Hours
-- Return the top 3 genres based on total watch hours in the last month.

DROP FUNCTION IF EXISTS Rank_Genres_BY_Hours;

DELIMITER $$

CREATE FUNCTION Rank_Genres_BY_Hours() RETURNS VARCHAR(500)
DETERMINISTIC
BEGIN
    DECLARE result VARCHAR(500) DEFAULT '';
    DECLARE r1 VARCHAR(45);
    DECLARE r2 VARCHAR(45);
    DECLARE r3 VARCHAR(45);
    DECLARE h1 DECIMAL(8,2);
    DECLARE h2 DECIMAL(8,2);
    DECLARE h3 DECIMAL(8,2);

    SELECT G.name,
           SUM(COALESCE(M.duration, 0)/60 + COALESCE(S.duration, 0)) INTO r1,h1
    FROM WatchHistory WH
    JOIN MultiMediaDB.Content C on C.idContent = WH.idContent
    JOIN MultiMediaDB.Content_Genre CG on C.idContent = CG.idContent
    JOIN MultiMediaDB.Genre G on CG.idGenre = G.idGenre
    LEFT JOIN MultiMediaDB.`Show` S on C.idContent = S.idContent
    LEFT JOIN MultiMediaDB.Movie M on C.idContent = M.idContent
    WHERE WH.watch_time >= DATE_SUB(CURDATE(),INTERVAL 1 MONTH )
    GROUP BY G.name
    ORDER BY SUM(COALESCE(M.duration, 0)/60 + COALESCE(S.duration, 0)) DESC
    LIMIT 0, 1;

    SELECT G.name,
           SUM(COALESCE(M.duration, 0)/60 + COALESCE(S.duration, 0))INTO r2,h2
    FROM WatchHistory WH
    JOIN MultiMediaDB.Content C on C.idContent = WH.idContent
    JOIN MultiMediaDB.Content_Genre CG on C.idContent = CG.idContent
    JOIN MultiMediaDB.Genre G on CG.idGenre = G.idGenre
    LEFT JOIN MultiMediaDB.`Show` S on C.idContent = S.idContent
    LEFT JOIN MultiMediaDB.Movie M on C.idContent = M.idContent
    WHERE WH.watch_time >= DATE_SUB(CURDATE(),INTERVAL 1 MONTH )
    GROUP BY G.name
    ORDER BY SUM(COALESCE(M.duration, 0)/60 + COALESCE(S.duration, 0)) DESC
    LIMIT 1, 1;

    SELECT G.name,
           SUM(COALESCE(M.duration, 0)/60 + COALESCE(S.duration, 0))INTO r3,h3
    FROM WatchHistory WH
    JOIN MultiMediaDB.Content C on C.idContent = WH.idContent
    JOIN MultiMediaDB.Content_Genre CG on C.idContent = CG.idContent
    JOIN MultiMediaDB.Genre G on CG.idGenre = G.idGenre
    LEFT JOIN MultiMediaDB.`Show` S on C.idContent = S.idContent
    LEFT JOIN MultiMediaDB.Movie M on C.idContent = M.idContent
    WHERE WH.watch_time >= DATE_SUB(CURDATE(),INTERVAL 1 MONTH )
    GROUP BY G.name
    ORDER BY SUM(COALESCE(M.duration, 0)/60 + COALESCE(S.duration, 0)) DESC
    LIMIT 2, 1;

    SET result = CONCAT('1. ',r1,
                        ' 2. ',r2,
                        ' 3. ',r3);
    RETURN result;
END$$

DELIMITER ;


-- WORKS
SELECT Rank_Genres_BY_Hours();


-- # 5. Find Most Frequent Collaborators
-- # Identify the most frequent actor-director pairs who have worked together.

DROP FUNCTION IF EXISTS MOST_FREQUENT_ACTOR_DIRECTOR_PAIR;

DELIMITER $$

CREATE FUNCTION MOST_FREQUENT_ACTOR_DIRECTOR_PAIR() RETURNS VARCHAR(200)
DETERMINISTIC
    BEGIN
        DECLARE actor VARCHAR(200);
        DECLARE director VARCHAR(200);
        DECLARE result VARCHAR(500);

        SELECT A.name, D.name INTO actor, director
        FROM Content_Cast CC
        JOIN Directed_Content DC ON CC.idContent = DC.idContent
        JOIN Actor A ON CC.idActor = A.idActors
        JOIN Director D ON DC.idDirector = D.idDirector
        WHERE A.name <> '' AND D.name <> ''
        GROUP BY A.idActors, D.idDirector
        ORDER BY COUNT(*) DESC
        LIMIT 1;

        SET result = CONCAT(director,' - ', actor);
        RETURN result;
    end $$
DELIMITER ;

-- WORKS
SELECT MOST_FREQUENT_ACTOR_DIRECTOR_PAIR();

-- # 6. Validate Subscription Status
-- # Return whether a user’s subscription is active or expired based on their subscription and transaction history.

DROP FUNCTION IF EXISTS CHECK_SUBSCRIPTION_STATUS;

DELIMITER $$

CREATE FUNCTION CHECK_SUBSCRIPTION_STATUS(iDUser INT) RETURNS VARCHAR(45)
DETERMINISTIC
    BEGIN
        DECLARE end_on DATETIME;
        DECLARE sub_status TINYINT;
        DECLARE last_paid DATETIME;

        SELECT US.end_on, US.status INTO end_on, sub_status
        FROM User_Subscriptions US
        WHERE US.idUser = iDUser
        ORDER BY end_on DESC
        LIMIT 1;

        SELECT T.timestamp INTO last_paid
        FROM Transaction T
        JOIN MultiMediaDB.User_Subscriptions U on U.idUserSub = T.idUserSub
        WHERE U.idUser = iDUser
        ORDER BY T.timestamp DESC
        LIMIT 1;

        IF end_on IS NULL OR sub_status = 0 OR NOW() > last_paid + INTERVAL 1 MONTH
            THEN RETURN ('Expired');
        ELSE RETURN ('Active');
        END IF;

    end $$

DELIMITER ;

-- Works
SELECT CHECK_SUBSCRIPTION_STATUS(3);


