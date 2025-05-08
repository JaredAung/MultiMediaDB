USE MultiMediaDB;
-- 1. Limit Watchlist Capacity
--
-- Enforce a maximum of 50 items in a user's Watchlist.
-- Automatically remove the oldest item if the user adds an item exceeding the limit.

DROP TRIGGER IF EXISTS TRG_WATCHLIST_CAP;
DELIMITER $$

CREATE TRIGGER TRG_WATCHLIST_CAP BEFORE INSERT ON WatchList
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
END $$

DELIMITER ;

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


# . Ensure Unique Director for Content
# Prevent duplicate Director entries for the same Content.
# Log any failed attempts to assign a duplicate director into a Director_Assignment_Errors table.
DROP TRIGGER IF EXISTS TRG_Duplicate_Director;

CREATE TABLE Director_Assignment_Errors(
    idDirector INT NOT NULL,
    idContent INT NOT NULL,
    PRIMARY KEY(idDirector,idContent),
    FOREIGN KEY(idDirector) REFERENCES Director(idDirector) ON DELETE CASCADE,
    FOREIGN KEY (idContent) REFERENCES Content(idContent) ON DELETE CASCADE
);


DELIMITER $$

CREATE TRIGGER TRG_Duplicate_Director
BEFORE INSERT ON Directed_Content
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM Directed_Content
        WHERE idContent = NEW.idContent AND idDirector = NEW.idDirector
    ) THEN
        -- Log the duplicate attempt
        INSERT IGNORE INTO Director_Assignment_Errors(idDirector, idContent)
        VALUES (NEW.idDirector, NEW.idContent);

        -- Prevent insertion by setting a bogus value or NULL (soft-block)
    END IF;
END $$

DELIMITER ;

