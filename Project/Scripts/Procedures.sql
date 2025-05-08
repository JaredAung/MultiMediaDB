USE MultiMediaDB;
# 7. Generate Monthly User Activity Report
#
# Generate a report detailing user activity for the past month, including:
# The number of content items watched
# Average ratings provided
# Hours spent on the platform

DROP PROCEDURE IF EXISTS USER_ACTIVITY_REPORT;

DELIMITER $$

CREATE PROCEDURE USER_ACTIVITY_REPORT(IN idUser INT)
BEGIN

    SELECT COUNT(DISTINCT WH.idContent) AS NUMBER_OF_CONTENT,
           ROUND(SUM(COALESCE(M.duration,0)/60 + COALESCE(S.duration,0)),2) AS TIME_SPENT,
           (SELECT ROUND(AVG(R.rating_star),2)
                FROM Review R
                WHERE R.idUser = idUser
                AND R.time_added >= NOW() - INTERVAL 1 MONTH) AS AVERAGE_RATING
    FROM WatchHistory WH
    JOIN MultiMediaDB.Content C on C.idContent = WH.idContent
    LEFT JOIN MultiMediaDB.Movie M on C.idContent = M.idContent
    LEFT JOIN MultiMediaDB.`Show` S on C.idContent = S.idContent
    WHERE WH.idUser = idUser
    AND WH.watch_time >= NOW() - INTERVAL 1 MONTH;

end $$

DELIMITER ;
-- WORKS
CALL USER_ACTIVITY_REPORT(3);

#
# Process Batch Content Updates
#
# Update the Content_Availability status for multiple Content entries based on a given list of criteria (e.g., release date, view count).

DROP PROCEDURE IF EXISTS SET_UNAVAILABLE_FOR_LOW_VIEW_CONTENT;

DELIMITER $$

CREATE PROCEDURE SET_UNAVAILABLE_FOR_LOW_VIEW_CONTENT()
BEGIN
    UPDATE Formatted_Content FC
    JOIN (
        SELECT C.idContent, COUNT(WH.idUser) AS view_count
        FROM Content C
        LEFT JOIN MultiMediaDB.WatchHistory WH on C.idContent = WH.idContent
        GROUP BY C.idContent
            ) AS view ON FC.idContent = view.idContent
    SET idAvailability = 3
    WHERE view_count <= 1 ;
end $$

DELIMITER ;

-- WORKS
CALL SET_UNAVAILABLE_FOR_LOW_VIEW_CONTENT();

# 9. Handle Failed Payments
# Log failed payment attempts into a Payment_Errors table.
# Send notifications to affected users regarding the failed payments.

