USE MultiMediaDB;
-- 1. Limit Watchlist Capacity
--
-- Enforce a maximum of 50 items in a user's Watchlist.
-- Automatically remove the oldest item if the user adds an item exceeding the limit.

CREATE TABLE Watchlist_Request (
    idUser INT NOT NULL,
    idContent INT NOT NULL,
    date_requested DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (idUser, idContent),
    FOREIGN KEY (idUser) REFERENCES User(idUser),
    FOREIGN KEY (idContent) REFERENCES Content(idContent)
);

DROP TRIGGER IF EXISTS TRG_WATCHLIST_CAP;
DELIMITER $$

CREATE TRIGGER TRG_WATCHLIST_CAP BEFORE INSERT ON Watchlist_Request
FOR EACH ROW
BEGIN
    DECLARE count INT DEFAULT 0;
    DECLARE oldest_id INT;

    -- Count current items in user's watchlist
    SET count = (SELECT COUNT(idContent)
                FROM Watchlist
                WHERE idUser = NEW.idUser);

    -- If already at or above limit, remove oldest item
    IF count >= 50 THEN
        SET oldest_id = (SELECT idContent FROM Watchlist
                        WHERE idUser = NEW.idUser
                        ORDER BY time_added ASC
                        LIMIT 1);

        DELETE FROM Watchlist
        WHERE idUser = NEW.idUser
        AND idContent = oldest_id;
    END IF;

    INSERT INTO Watchlist(idUser, idContent) VALUES (NEW.idUser,NEW.idContent);
END $$

DELIMITER ;

-- WORKS
SELECT * FROM Watchlist;
INSERT INTO Watchlist_Request(idUser, idContent) VALUES (1,200);

DELETE FROM Watchlist WHERE idContent = 66;
# 2. Rating Impact on Content Availability
#
# Automatically set the Content_Availability status to "Archived" if the average rating of a piece of Content falls below 2.0 after a new review is added.


DROP TRIGGER IF EXISTS SET_ARCHIVED;

DELIMITER $$

CREATE TRIGGER SET_ARCHIVED AFTER INSERT ON Review
FOR EACH ROW
    BEGIN
        DECLARE average_rating DECIMAL(3,2);

        SET average_rating = (SELECT AVG(rating_star) FROM Review
                              WHERE idContent = NEW.idContent);

        IF average_rating < 2
            THEN UPDATE Formatted_Content
                 SET idAvailability = 3 -- idAvailability = Archieved
                WHERE idContent = NEW.idContent;
        END IF;

    end $$

DELIMITER ;


# Ensure Unique Director for Content
#
# Prevent duplicate Director entries for the same Content.
# Log any failed attempts to assign a duplicate director into a Director_Assignment_Errors table.
CREATE TABLE Directed_Content_Request (
    idContent INT,
    idDirector INT
);
DROP table Director_Assignment_Errors;

CREATE TABLE Director_Assignment_Errors(
    idDirector INT NOT NULL,
    idContent INT NOT NULL,
    error_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(idDirector) REFERENCES Director(idDirector) ON DELETE CASCADE,
    FOREIGN KEY (idContent) REFERENCES Content(idContent) ON DELETE CASCADE
);

DROP TRIGGER TRG_Duplicate_Director;

DELIMITER $$

CREATE TRIGGER TRG_Duplicate_Director
AFTER INSERT ON Directed_Content_Request
FOR EACH ROW
BEGIN
    DECLARE entry_exists INT;

    SET entry_exists = (SELECT COUNT(*) FROM Directed_Content
                    WHERE idContent = NEW.idContent && idDirector = NEW.idDirector);

    IF entry_exists = 0 THEN
        INSERT INTO Directed_Content(idContent, idDirector) VALUES
        (NEW.idContent,NEW.idDirector);

    ELSE
        INSERT INTO Director_Assignment_Errors(idDirector, idContent) VALUES
        (NEW.idDirector,NEW.idContent);
    END IF;
END $$

DELIMITER ;

SELECT * FROM Directed_Content;
SELECT * FROM Director_Assignment_Errors;
-- works
INSERT INTO Directed_Content_Request(IDCONTENT, IDDIRECTOR) VALUES (1,1);