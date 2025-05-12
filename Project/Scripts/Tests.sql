USE MultiMediaDB;

-- UNIT TESTING

-- Triggers

-- 1. TRG_WATCHLIST_CAP

-- UNIT TESTING

-- Clear existing Watchlist entries
DELETE FROM Watchlist WHERE idUser = 1;

-- Insert 50 watchlist entries for idUser = 1
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1001, '2024-01-01 01:00:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1002, '2024-01-01 01:01:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1003, '2024-01-01 01:02:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1004, '2024-01-01 01:03:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1005, '2024-01-01 01:04:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1006, '2024-01-01 01:05:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1007, '2024-01-01 01:06:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1008, '2024-01-01 01:07:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1009, '2024-01-01 01:08:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1010, '2024-01-01 01:09:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1011, '2024-01-01 01:10:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1012, '2024-01-01 01:11:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1013, '2024-01-01 01:12:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1014, '2024-01-01 01:13:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1015, '2024-01-01 01:14:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1016, '2024-01-01 01:15:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1017, '2024-01-01 01:16:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1018, '2024-01-01 01:17:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1019, '2024-01-01 01:18:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1020, '2024-01-01 01:19:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1021, '2024-01-01 01:20:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1022, '2024-01-01 01:21:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1023, '2024-01-01 01:22:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1024, '2024-01-01 01:23:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1025, '2024-01-01 01:24:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1026, '2024-01-01 01:25:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1027, '2024-01-01 01:26:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1028, '2024-01-01 01:27:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1029, '2024-01-01 01:28:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1030, '2024-01-01 01:29:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1031, '2024-01-01 01:30:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1032, '2024-01-01 01:31:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1033, '2024-01-01 01:32:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1034, '2024-01-01 01:33:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1035, '2024-01-01 01:34:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1036, '2024-01-01 01:35:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1037, '2024-01-01 01:36:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1038, '2024-01-01 01:37:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1039, '2024-01-01 01:38:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1040, '2024-01-01 01:39:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1041, '2024-01-01 01:40:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1042, '2024-01-01 01:41:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1043, '2024-01-01 01:42:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1044, '2024-01-01 01:43:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1045, '2024-01-01 01:44:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1046, '2024-01-01 01:45:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1047, '2024-01-01 01:46:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1048, '2024-01-01 01:47:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1049, '2024-01-01 01:48:00');
INSERT INTO Watchlist (idUser, idContent, time_added) VALUES (1, 1050, '2024-01-01 01:49:00');

-- Insert the 51st entry (should trigger oldest removal)
INSERT INTO Watchlist_Request (idUser, idContent) VALUES (1, 1051);

-- Check result: should still be 50 items
SELECT COUNT(*) AS total_items FROM Watchlist WHERE idUser = 1;

-- Integration testing

-- Insert new item
INSERT INTO Watchlist_Request (idUser, idContent) VALUES (1, 1099);

-- Check if it is inserted correctly
SELECT * FROM Watchlist WHERE idUser = 1 AND idContent = 1099;


-- DATA INTEGRITY TEST
INSERT INTO Watchlist_Request (idUser, idContent) VALUES (2, 1099);

-- Check if it is 51 since the user is different
SELECT COUNT(*) FROM Watchlist;

-- Check if it is 50.
SELECT COUNT(*) FROM Watchlist WHERE idUser = 1;


-- 2.SET_ARCHIVED

-- UNIT TESTING
--  idContent is not in the Formatted_Content yet
UPDATE Formatted_Content
SET idAvailability = 1
WHERE idContent = 33;

SELECT idContent, idAvailability FROM Formatted_Content WHERE idContent = 33;

-- Insert a new low rating
INSERT INTO Review(idUser, idContent, rating_star)
VALUES (2, 33, 1);

-- Check if the idContent is set to idAvailability = 3 (Archived)
SELECT idContent, Formatted_Content.idAvailability, CA.status FROM Formatted_Content
JOIN MultiMediaDB.Content_Availability CA on CA.idAvailability = Formatted_Content.idAvailability
WHERE idContent = 33;

-- INTEGRATION TESTING
SELECT idContent, AVG(rating_star) FROM Review GROUP BY idContent;

-- idContent currently have above 2 rating.
INSERT INTO Review(idUser, idContent, rating_star) VALUES (4,1,4);

-- rating remain above 2.
SELECT idContent, AVG(rating_star) FROM Review
WHERE idContent =1
GROUP BY idContent;

-- check content is still available.
SELECT idContent, Formatted_Content.idAvailability, CA.status FROM Formatted_Content
JOIN MultiMediaDB.Content_Availability CA on CA.idAvailability = Formatted_Content.idAvailability
WHERE idContent = 1;


INSERT INTO Review(idUser, idContent, rating_star) VALUES (4,1,1);
INSERT INTO Review(idUser, idContent, rating_star) VALUES (4,1,1);
INSERT INTO Review(idUser, idContent, rating_star) VALUES (4,1,1);
INSERT INTO Review(idUser, idContent, rating_star) VALUES (4,1,1);
INSERT INTO Review(idUser, idContent, rating_star) VALUES (4,1,1);

-- check content is now archived
SELECT idContent, Formatted_Content.idAvailability, CA.status FROM Formatted_Content
JOIN MultiMediaDB.Content_Availability CA on CA.idAvailability = Formatted_Content.idAvailability
WHERE idContent = 1;

-- DATA INTEGRITY TESTING

INSERT INTO Review(idUser, idContent, rating_star) VALUES (4,77,2);

-- check content is now available
SELECT idContent, Formatted_Content.idAvailability, CA.status FROM Formatted_Content
JOIN MultiMediaDB.Content_Availability CA on CA.idAvailability = Formatted_Content.idAvailability
WHERE idContent = 77;

-- 3. Director_Assignment_Errors

-- UNIT TESTING

-- Insert via request table idContent = 1 and idDirector = 3 is unique.
INSERT INTO Directed_Content_Request(idContent, idDirector)
VALUES (1, 3);

-- Check if the pair is correctly inserted
SELECT * FROM Directed_Content
WHERE idContent = 1 AND idDirector = 3;

-- delete to maintain data integrity
DELETE FROM Directed_Content
WHERE idContent = 1 AND idDirector = 3;


-- INTEGRATION TESTING

-- Insert duplicate
INSERT INTO Directed_Content_Request(idContent, idDirector)
VALUES (1, 1);

-- Check that it's still only once in Directed_Content
SELECT COUNT(*) FROM Directed_Content
WHERE idContent = 1 AND idDirector = 1;

-- Check if it was logged as an error with the current timestamp
SELECT * FROM Director_Assignment_Errors
WHERE idContent = 1 AND idDirector = 1;

-- DATA INTEGRITY TESTING

-- CHECK no rows
SELECT idContent, idDirector, COUNT(*) AS cnt
FROM Directed_Content
GROUP BY idContent, idDirector
HAVING cnt > 1;



-- FUNCTIONS

-- 4. Rank_Genres_BY_Hours();

-- UNIT TESTING
-- CHECK output and format
SELECT Rank_Genres_BY_Hours() AS TopGenres;

-- INTEGRATION TESTING

-- Insert new watch activity where Genre = TV Comedies
INSERT IGNORE INTO WatchHistory (idUser, idContent)
VALUES (1, 5),
       (2,5),
       (2,18),
       (3,34),
        (4,34),
        (1,18);

-- CHECK TV Comedies is in Top 3
SELECT Rank_Genres_BY_Hours() AS TopGenres;

-- DATA INTEGRITY TESTING

-- Delete all watch history for the past month
DELETE FROM WatchHistory WHERE watch_time >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

-- Check if it is returns a empty response and not crash
SELECT Rank_Genres_BY_Hours() AS TopGenres;

-- 5. MOST_FREQUENT_ACTOR_DIRECTOR_PAIR
-- idActor = 307 and idDirector = 284is ranked just below the top.
-- UNIT TESTING
-- Check output and format
SELECT MOST_FREQUENT_ACTOR_DIRECTOR_PAIR() AS TopPair;


-- INTEGRATION TESTING
INSERT INTO Content_Cast (idContent, idActor) VALUES (900, 307);
INSERT INTO Directed_Content (idContent, idDirector) VALUES (900, 284);
INSERT INTO Content_Cast (idContent, idActor) VALUES (901, 307);
INSERT INTO Directed_Content (idContent, idDirector) VALUES (901, 284);
INSERT INTO Content_Cast (idContent, idActor) VALUES (902, 307);
INSERT INTO Directed_Content (idContent, idDirector) VALUES (902, 284);

-- Now the TopPair is idActor = 307 and idDirector = 284
SELECT MOST_FREQUENT_ACTOR_DIRECTOR_PAIR() AS TopPair;

-- delete to maintain integrity
DELETE FROM Content_Cast WHERE idContent = 900 AND idActor = 307;
DELETE FROM Content_Cast WHERE idContent = 901 AND idActor = 307;
DELETE FROM Content_Cast WHERE idContent = 902 AND idActor = 307;
DELETE FROM Directed_Content WHERE idContent = 902 AND idDirector = 284;
DELETE FROM Directed_Content WHERE idContent = 900 AND idDirector = 284;
DELETE FROM Directed_Content WHERE idContent = 901 AND idDirector = 284;

-- Check if it changed back the true TopPair
SELECT MOST_FREQUENT_ACTOR_DIRECTOR_PAIR() AS TopPair;

-- DATA INTEGRITY TEST

-- CHECK if the function can handle null or empty data.
UPDATE Actor SET name = '' WHERE idActors = 13;

SELECT MOST_FREQUENT_ACTOR_DIRECTOR_PAIR() AS TopPair;

-- undo the testing
UPDATE Actor SET name = 'Greteli Fincham' WHERE idActors = 13;


-- 6. CHECK_SUBSCRIPTION_STATUS (INCOMPLETE) (fix Payment method)

-- UNIT TESTING

INSERT INTO User (idUser, username, DOB) VALUES (401, 'TestUser', '2000-01-01');

-- Add valid subscription (not expired)
INSERT INTO User_Subscriptions (idUserSub, idSubscription, end_on, idUser, status)
VALUES (1001, 1, DATE_ADD(NOW(), INTERVAL 30 DAY), 401, 1);

-- Add payment within last month
INSERT INTO Payment_Method (idMethod, idUser, payment_type, provider)
VALUES (701, 401, 'Credit Card', 'TestBank');

INSERT INTO Transaction (idTransaction, idUserSub, idMethod, idUser, timestamp, amount, status)
VALUES (801, 1001, 701, 401, NOW() - INTERVAL 5 DAY, 9.99, 'success');

-- CHECK if it returns active
SELECT CHECK_SUBSCRIPTION_STATUS(401) AS result;

-- INTEGRATION TESTING

-- an older subscription of same user
INSERT INTO User_Subscriptions (idUserSub, idSubscription, end_on, idUser, status)
VALUES (1002, 1, '2023-01-01', 401, 1);

-- Add old transaction
INSERT INTO Transaction (idTransaction, idUserSub, idMethod, idUser, timestamp, amount, status)
VALUES (802, 1002, 701, 401, '2023-01-01', 9.99, 'success');

-- Rerun test (should still return Active because newest subscription is valid)
SELECT CHECK_SUBSCRIPTION_STATUS(401) AS result;

-- DATA INTEGRITY TESTING

-- Add user with no subscription
INSERT INTO User (idUser, username, DOB) VALUES (402, 'NoSubUser', '1995-01-01');

-- CHECK return Expired
SELECT CHECK_SUBSCRIPTION_STATUS(402) AS result;










-- 7. USER_ACTIVITY_REPORT

-- UNIT TESTING

-- CHECK output and format
CALL USER_ACTIVITY_REPORT(5);

-- INTEGRATION TESTING

INSERT INTO WatchHistory(idUser, idContent) VALUES (5,33),
                                                (5,22),
                                                (5,77);

INSERT INTO Review(idUser, idContent, rating_star) VALUES (5,22,4),
                                                          (5,77,3);

-- CHECKS that average rating is correct and time spent is increased
CALL USER_ACTIVITY_REPORT(5);

-- DATA INTEGRITY TESTING

-- CHECK returns 0 or nulls when the user doesn't have any activity
CALL USER_ACTIVITY_REPORT(2);



-- 8. SET_UNAVAILABLE_FOR_LOW_VIEW_CONTENT

-- UNIT TESTING

-- A content with 0 view count will be updated to unavailable.
INSERT INTO Formatted_Content (idContent, idAvailability,idFormat) VALUES (2000, 1,4);

CALL SET_UNAVAILABLE_FOR_LOW_VIEW_CONTENT();
SELECT idContent, idAvailability FROM Formatted_Content WHERE idContent = 2000;

-- INTEGRATION TESTING

INSERT INTO Formatted_Content (idContent, idAvailability,idFormat) VALUES (2001, 1,4);

INSERT INTO WatchHistory(idUser, idContent) VALUES (1,2001),(2,2001),(3,2001);

CALL SET_UNAVAILABLE_FOR_LOW_VIEW_CONTENT();

-- CHECK if it remains available
SELECT idContent, idAvailability FROM Formatted_Content WHERE idContent = 2001;


-- DATE INTEGRITY TESTING

INSERT INTO Formatted_Content (idContent, idAvailability,idFormat) VALUES (2002, 3,4);

CALL SET_UNAVAILABLE_FOR_LOW_VIEW_CONTENT();

-- Check content set to unavailable remains unavailable.
SELECT idContent, idAvailability FROM Formatted_Content WHERE idContent = 2002;



-- 9.LOG_FAILED_PAYMENTS

-- Create user
INSERT INTO User (idUser, username, DOB) VALUES (101, 'FailUser', '1990-01-01');

-- Create subscription
INSERT INTO User_Subscriptions (idUserSub, idSubscription, end_on, idUser, status)
VALUES (301, 1, NOW() + INTERVAL 30 DAY, 101, 1);

-- Add payment method
INSERT INTO Payment_Method (idMethod, idUser, payment_type, provider)
VALUES (501, 101, 'Credit Card', 'Visa');


-- UNIT TESTING

-- Insert a failed transaction for user 101
INSERT INTO Transaction (idUserSub, idMethod, idUser, timestamp, amount, status)
VALUES (301, 501, 101, NOW(), 19.99, 'fail');

-- Run the logging procedure
CALL LOG_FAILED_PAYMENTS();

-- Check the payment error was logged
SELECT * FROM Payment_Errors WHERE idUser = 101;
SELECT * FROM NOTIFICATIONS WHERE idUser = 101;

-- INTRGRATION TESTING

-- Insert more failed transactions for same user
INSERT INTO Transaction (idUserSub, idMethod, idUser, timestamp, amount, status)
VALUES
(301, 501, 101, NOW(), 8.99, 'fail'),
(301, 501, 101, NOW(), 9.99, 'fail');

-- First call
CALL LOG_FAILED_PAYMENTS();

-- Call again to test duplicate handling
CALL LOG_FAILED_PAYMENTS();

-- CHECK Only 3 unique payment errors and notifications
SELECT COUNT(*) AS error_count FROM Payment_Errors WHERE idUser = 101;
SELECT COUNT(*) AS notif_count FROM NOTIFICATIONS WHERE idUser = 101;

-- DATA INTEGRITY TEST

-- CHECK for error since idUser doesn't exist.
INSERT INTO Transaction (idUserSub, idMethod, idUser, timestamp, amount, status)
VALUES (401, 601, 9999, NOW(), 12.99, 'fail');


-- 10. REMOVE_EXPIRED_SUBSCRIPTION

-- Setup: create test user and expired subscription
INSERT INTO User (idUser, username, DOB) VALUES (301, 'ExpireUser', '2000-01-01');
INSERT INTO User_Subscriptions (idSubscription, end_on, idUser, status)
VALUES (2, '2024-01-01', 301, 1);


-- UNIT TESTING

-- Manually simulating the event logic
INSERT INTO NOTIFICATIONS(message, idUser)
    SELECT CONCAT('The subscription of ', U.username, ' has expired.' ),U.idUser
    FROM User_Subscriptions
    JOIN MultiMediaDB.User U on U.idUser = User_Subscriptions.idUser
    WHERE NOW() > end_on OR end_on IS NULL OR status = 0;

DELETE FROM User_Subscriptions
WHERE NOW() > end_on OR end_on IS NULL OR status = 0;

-- CHECK that subscription is deleted
SELECT * FROM User_Subscriptions WHERE idUser = 301;

-- Check that notification about the deletion exists.
SELECT * FROM NOTIFICATIONS WHERE idUser = 301;


-- INTEGRATION TESTING

-- Add 2 test users
INSERT INTO User (idUser, username, DOB) VALUES (302, 'ActiveUser', '2000-02-02'), (303, 'NullDateUser', '2000-03-03');

-- Active subscription
INSERT INTO User_Subscriptions (idSubscription, end_on, idUser, status)
VALUES (2, DATE_ADD(NOW(), INTERVAL 30 DAY), 302, 1);

-- Expired subscription with NULL date
INSERT INTO User_Subscriptions (idSubscription, end_on, idUser, status)
VALUES (2, NULL, 303, 1);

-- Run event logic
INSERT INTO NOTIFICATIONS(message, idUser)
    SELECT CONCAT('The subscription of ', U.username, ' has expired.' ),U.idUser
    FROM User_Subscriptions
    JOIN MultiMediaDB.User U on U.idUser = User_Subscriptions.idUser
    WHERE NOW() > end_on OR end_on IS NULL OR status = 0;

DELETE FROM User_Subscriptions
WHERE NOW() > end_on OR end_on IS NULL OR status = 0;

-- Check: user 302 should remain, 303 should be removed
SELECT * FROM User_Subscriptions WHERE idUser IN (302, 303);
SELECT * FROM NOTIFICATIONS WHERE idUser IN (302, 303);


-- DATA INTEGRITY TESTING

-- Insert another valid subscription
INSERT INTO User (idUser, username, DOB) VALUES (304, 'SafeUser', '2001-01-01');
INSERT INTO User_Subscriptions (idSubscription, end_on, idUser, status)
VALUES (2, DATE_ADD(NOW(), INTERVAL 60 DAY), 304, 1);

-- Run event logic again
INSERT INTO NOTIFICATIONS(message, idUser)
    SELECT CONCAT('The subscription of ', U.username, ' has expired.' ),U.idUser
    FROM User_Subscriptions
    JOIN MultiMediaDB.User U on U.idUser = User_Subscriptions.idUser
    WHERE NOW() > end_on OR end_on IS NULL OR status = 0;

DELETE FROM User_Subscriptions
WHERE NOW() > end_on OR end_on IS NULL OR status = 0;

-- CHECK THAT it is not deleted
SELECT * FROM User_Subscriptions WHERE idUser = 304;
SELECT * FROM NOTIFICATIONS WHERE idUser = 304;

-- 11. TOP_1O_POPULAR_CONTENT_TODAY

-- EVENT was changed to run for every 1 minute during the testing.

-- UNIT TESTING

-- Setup test genre and content
INSERT INTO Genre (idGenre, name) VALUES (1001, 'TestGenre');
INSERT INTO Content (idContent, title, type, date_added) VALUES (9001, 'TestMovie', 'Movie', NOW());
INSERT INTO Content_Genre (idContent, idGenre) VALUES (9001, 1001);

-- Simulate 5 views
INSERT INTO WatchHistory (idUser, idContent)
VALUES
    (1, 9001),
    (2, 9001),
    (3,9001),
    (4,9001);


select * FROM WatchHistory;
-- Check the new genre appears in the event
SELECT * FROM TOP_1O_POPULAR_CONTENT_TODAY WHERE genre = 'TestGenre';


-- INTEGRATION TESTING

-- Add second genre and another movie
INSERT INTO Genre (idGenre, name) VALUES (1002, 'OtherGenre');
INSERT INTO Content (idContent, title, type, date_added) VALUES (9002, 'OtherMovie', 'Movie', NOW());
INSERT INTO Content_Genre (idContent, idGenre) VALUES (9002, 1002);

-- Simulate 8 views for OtherMovie
INSERT INTO WatchHistory (idUser, idContent)
VALUES
    (1, 9002),
    (2, 9002),
    (3,9002),
    (4,9002);

-- Check for both genres exist
SELECT * FROM TOP_1O_POPULAR_CONTENT_TODAY WHERE genre IN ('TestGenre', 'OtherGenre');

-- DATA INTEGRITY TESTING

-- Add unviewed content
INSERT INTO Content (idContent, title, type, date_added) VALUES (9003, 'NoViewMovie', 'Movie', NOW());
INSERT INTO Content_Genre (idContent, idGenre) VALUES (9003, 1001);  -- in TestGenre

-- Check it does NOT appear
SELECT * FROM TOP_1O_POPULAR_CONTENT_TODAY WHERE name = 'NoViewMovie';
