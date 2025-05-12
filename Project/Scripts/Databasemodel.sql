-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema MultiMediaDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `MultiMediaDB` ;

-- -----------------------------------------------------
-- Schema MultiMediaDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `MultiMediaDB` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `MultiMediaDB` ;

-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Actor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Actor` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Actor` (
  `idActors` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idActors`))
ENGINE = InnoDB
AUTO_INCREMENT = 36369
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Rating` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Rating` (
  `idRating` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idRating`))
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Content_Release`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Content_Release` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Content_Release` (
  `idRelease` INT NOT NULL AUTO_INCREMENT,
  `release_year` YEAR NOT NULL,
  PRIMARY KEY (`idRelease`))
ENGINE = InnoDB
AUTO_INCREMENT = 2022
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Content` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Content` (
  `idContent` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NOT NULL,
  `type` ENUM('Movie', 'Show') NOT NULL,
  `idRating` INT NULL DEFAULT NULL,
  `idRelease` INT NULL DEFAULT NULL,
  `date_added` DATETIME NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idContent`),
  UNIQUE INDEX `unique_title` (`title` ASC) VISIBLE,
  INDEX `FK_Content_Rating_idx` (`idRating` ASC) VISIBLE,
  INDEX `FK_Content_Release_idx` (`idRelease` ASC) VISIBLE,
  CONSTRAINT `FK_Content_Rating`
    FOREIGN KEY (`idRating`)
    REFERENCES `MultiMediaDB`.`Rating` (`idRating`)
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Content_Release`
    FOREIGN KEY (`idRelease`)
    REFERENCES `MultiMediaDB`.`Content_Release` (`idRelease`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 8802
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Content_Accessibility`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Content_Accessibility` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Content_Accessibility` (
  `idAccessibility` INT NOT NULL AUTO_INCREMENT,
  `feature_name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idAccessibility`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Content_Availability`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Content_Availability` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Content_Availability` (
  `idAvailability` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAvailability`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Content_Cast`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Content_Cast` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Content_Cast` (
  `idContent` INT NOT NULL,
  `idActor` INT NOT NULL,
  PRIMARY KEY (`idContent`, `idActor`),
  INDEX `FK_Cast_Actor_idx` (`idActor` ASC) VISIBLE,
  CONSTRAINT `FK_Cast_Actor`
    FOREIGN KEY (`idActor`)
    REFERENCES `MultiMediaDB`.`Actor` (`idActors`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Cast_Content`
    FOREIGN KEY (`idContent`)
    REFERENCES `MultiMediaDB`.`Content` (`idContent`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Content_Format`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Content_Format` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Content_Format` (
  `idFormat` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idFormat`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Genre` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Genre` (
  `idGenre` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idGenre`))
ENGINE = InnoDB
AUTO_INCREMENT = 43
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Content_Genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Content_Genre` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Content_Genre` (
  `idContent` INT NOT NULL,
  `idGenre` INT NOT NULL,
  PRIMARY KEY (`idContent`, `idGenre`),
  INDEX `FK_ContentGenre_Genre_idx` (`idGenre` ASC) VISIBLE,
  CONSTRAINT `FK_ContentGenre_Content`
    FOREIGN KEY (`idContent`)
    REFERENCES `MultiMediaDB`.`Content` (`idContent`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_ContentGenre_Genre`
    FOREIGN KEY (`idGenre`)
    REFERENCES `MultiMediaDB`.`Genre` (`idGenre`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Country` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Country` (
  `idCountry` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCountry`))
ENGINE = InnoDB
AUTO_INCREMENT = 1090
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`CountryContent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`CountryContent` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`CountryContent` (
  `idCountry` INT NOT NULL,
  `idContent` INT NOT NULL,
  PRIMARY KEY (`idContent`, `idCountry`),
  INDEX `FK_CountryContent_Country_idx` (`idCountry` ASC) VISIBLE,
  INDEX `FK_CountryContent_Content_idx` (`idContent` ASC) VISIBLE,
  CONSTRAINT `FK_CountryContent_Content`
    FOREIGN KEY (`idContent`)
    REFERENCES `MultiMediaDB`.`Content` (`idContent`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_CountryContent_Country`
    FOREIGN KEY (`idCountry`)
    REFERENCES `MultiMediaDB`.`Country` (`idCountry`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Director`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Director` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Director` (
  `idDirector` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idDirector`))
ENGINE = InnoDB
AUTO_INCREMENT = 4990
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Directed_Content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Directed_Content` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Directed_Content` (
  `idContent` INT NOT NULL,
  `idDirector` INT NOT NULL,
  `idDirectedContent` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idDirectedContent`),
  UNIQUE INDEX `uniq_director_content` (`idContent` ASC, `idDirector` ASC) VISIBLE,
  INDEX `FK_DirectedContent_Director_idx` (`idDirector` ASC) VISIBLE,
  CONSTRAINT `FK_DirectedContent_Content`
    FOREIGN KEY (`idContent`)
    REFERENCES `MultiMediaDB`.`Content` (`idContent`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_DirectedContent_Director`
    FOREIGN KEY (`idDirector`)
    REFERENCES `MultiMediaDB`.`Director` (`idDirector`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 9629
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Directed_Content_Request`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Directed_Content_Request` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Directed_Content_Request` (
  `idContent` INT NULL DEFAULT NULL,
  `idDirector` INT NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Director_Assignment_Errors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Director_Assignment_Errors` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Director_Assignment_Errors` (
  `idDirector` INT NOT NULL,
  `idContent` INT NOT NULL,
  `error_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `idDirector` (`idDirector` ASC) VISIBLE,
  INDEX `idContent` (`idContent` ASC) VISIBLE,
  CONSTRAINT `director_assignment_errors_ibfk_1`
    FOREIGN KEY (`idDirector`)
    REFERENCES `MultiMediaDB`.`Director` (`idDirector`)
    ON DELETE CASCADE,
  CONSTRAINT `director_assignment_errors_ibfk_2`
    FOREIGN KEY (`idContent`)
    REFERENCES `MultiMediaDB`.`Content` (`idContent`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Formatted_Content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Formatted_Content` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Formatted_Content` (
  `idContent` INT NOT NULL,
  `idFormat` INT NOT NULL,
  `idAvailability` INT NOT NULL,
  PRIMARY KEY (`idContent`, `idFormat`, `idAvailability`),
  UNIQUE INDEX `idx_content_format` (`idContent` ASC, `idFormat` ASC) VISIBLE,
  INDEX `FK_Content&Format_Format_idx` (`idFormat` ASC) VISIBLE,
  INDEX `FK_FormattedContent_Availability_idx` (`idAvailability` ASC) VISIBLE,
  CONSTRAINT `FK_FormattedContent_Availability`
    FOREIGN KEY (`idAvailability`)
    REFERENCES `MultiMediaDB`.`Content_Availability` (`idAvailability`),
  CONSTRAINT `FK_FormattedContent_Content`
    FOREIGN KEY (`idContent`)
    REFERENCES `MultiMediaDB`.`Content` (`idContent`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_FormattedContent_Format`
    FOREIGN KEY (`idFormat`)
    REFERENCES `MultiMediaDB`.`Content_Format` (`idFormat`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Formatted_Content_Accessibility`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Formatted_Content_Accessibility` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Formatted_Content_Accessibility` (
  `idContent` INT NOT NULL,
  `idFormat` INT NOT NULL,
  `idAccessibility` INT NOT NULL,
  PRIMARY KEY (`idContent`, `idFormat`, `idAccessibility`),
  INDEX `idAccessibility` (`idAccessibility` ASC) VISIBLE,
  CONSTRAINT `formatted_content_accessibility_ibfk_1`
    FOREIGN KEY (`idContent` , `idFormat`)
    REFERENCES `MultiMediaDB`.`Formatted_Content` (`idContent` , `idFormat`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `formatted_content_accessibility_ibfk_2`
    FOREIGN KEY (`idAccessibility`)
    REFERENCES `MultiMediaDB`.`Content_Accessibility` (`idAccessibility`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Movie`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Movie` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Movie` (
  `idContent` INT NOT NULL AUTO_INCREMENT,
  `duration` INT NOT NULL,
  PRIMARY KEY (`idContent`),
  CONSTRAINT `FK_Movie_Content`
    FOREIGN KEY (`idContent`)
    REFERENCES `MultiMediaDB`.`Content` (`idContent`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 8802
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`User` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`User` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `DOB` DATETIME NOT NULL,
  PRIMARY KEY (`idUser`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`NOTIFICATIONS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`NOTIFICATIONS` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`NOTIFICATIONS` (
  `idNotification` INT NOT NULL AUTO_INCREMENT,
  `message` TEXT NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `idUser` INT NOT NULL,
  PRIMARY KEY (`idNotification`),
  INDEX `idUser` (`idUser` ASC) VISIBLE,
  CONSTRAINT `notifications_ibfk_1`
    FOREIGN KEY (`idUser`)
    REFERENCES `MultiMediaDB`.`User` (`idUser`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Payment_Method`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Payment_Method` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Payment_Method` (
  `idMethod` INT NOT NULL,
  `idUser` INT NOT NULL,
  `payment_type` VARCHAR(45) NOT NULL,
  `provider` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMethod`, `idUser`),
  INDEX `FK_PaymentMethod_User_idx` (`idUser` ASC) VISIBLE,
  CONSTRAINT `FK_PaymentMethod_User`
    FOREIGN KEY (`idUser`)
    REFERENCES `MultiMediaDB`.`User` (`idUser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Playlist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Playlist` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Playlist` (
  `idPlaylist` INT NOT NULL AUTO_INCREMENT,
  `idUser` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idPlaylist`),
  INDEX `FK_Playlist_Content_idx` (`idUser` ASC) VISIBLE,
  CONSTRAINT `FK_Playlist_User`
    FOREIGN KEY (`idUser`)
    REFERENCES `MultiMediaDB`.`User` (`idUser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Playlisted_Content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Playlisted_Content` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Playlisted_Content` (
  `idPlaylist` INT NOT NULL,
  `idContent` INT NOT NULL,
  PRIMARY KEY (`idPlaylist`, `idContent`),
  INDEX `FK_PlaylistedContent_Content_idx` (`idContent` ASC) VISIBLE,
  CONSTRAINT `FK_PlaylistedContent_Content`
    FOREIGN KEY (`idContent`)
    REFERENCES `MultiMediaDB`.`Content` (`idContent`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_PlaylistedContent_Playlist`
    FOREIGN KEY (`idPlaylist`)
    REFERENCES `MultiMediaDB`.`Playlist` (`idPlaylist`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Review` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Review` (
  `idReview` INT NOT NULL AUTO_INCREMENT,
  `idUser` INT NOT NULL,
  `idContent` INT NOT NULL,
  `review_text` TEXT NULL DEFAULT NULL,
  `rating_star` INT NOT NULL,
  `time_added` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idReview`),
  INDEX `FK_Review_User_idx` (`idUser` ASC) VISIBLE,
  INDEX `Fk_Review_Content_idx` (`idContent` ASC) VISIBLE,
  CONSTRAINT `Fk_Review_Content`
    FOREIGN KEY (`idContent`)
    REFERENCES `MultiMediaDB`.`Content` (`idContent`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Review_User`
    FOREIGN KEY (`idUser`)
    REFERENCES `MultiMediaDB`.`User` (`idUser`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 28
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Show`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Show` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Show` (
  `idContent` INT NOT NULL AUTO_INCREMENT,
  `duration` INT NOT NULL,
  PRIMARY KEY (`idContent`),
  CONSTRAINT `FK_Show_Content`
    FOREIGN KEY (`idContent`)
    REFERENCES `MultiMediaDB`.`Content` (`idContent`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 8799
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`SubscriptionPlan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`SubscriptionPlan` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`SubscriptionPlan` (
  `idSubscription` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `price` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`idSubscription`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`TOP_1O_POPULAR_CONTENT_TODAY`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`TOP_1O_POPULAR_CONTENT_TODAY` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`TOP_1O_POPULAR_CONTENT_TODAY` (
  `idContent` INT NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `genre` VARCHAR(100) NOT NULL,
  `total_views` INT NOT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Tag` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Tag` (
  `idTag` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTag`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Tagged_Content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Tagged_Content` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Tagged_Content` (
  `idContent` INT NOT NULL,
  `idTag` INT NOT NULL,
  PRIMARY KEY (`idContent`, `idTag`),
  INDEX `Fk_Content&Tag_Tag_idx` (`idTag` ASC) VISIBLE,
  CONSTRAINT `FK_TaggedContent_Content`
    FOREIGN KEY (`idContent`)
    REFERENCES `MultiMediaDB`.`Content` (`idContent`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Fk_TaggedContent_Tag`
    FOREIGN KEY (`idTag`)
    REFERENCES `MultiMediaDB`.`Tag` (`idTag`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Transaction` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Transaction` (
  `idTransaction` INT NOT NULL AUTO_INCREMENT,
  `idUserSub` INT NOT NULL,
  `idMethod` INT NOT NULL,
  `timestamp` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `amount` DECIMAL(8,2) NOT NULL,
  `status` ENUM('success', 'fail') NOT NULL DEFAULT 'success',
  `idUser` INT NOT NULL,
  PRIMARY KEY (`idTransaction`),
  INDEX `FK_Transaction_PaymentMethod_idx` (`idMethod` ASC) VISIBLE,
  INDEX `FK_Transaction_User` (`idUser` ASC) VISIBLE,
  INDEX `FK_Transaction_PaymentMethod_Owner` (`idMethod` ASC, `idUser` ASC) VISIBLE,
  INDEX `Fk_Transaction_UserSub_idx` (`idUserSub` ASC) VISIBLE,
  CONSTRAINT `FK_Transaction_PaymentMethod_Owner`
    FOREIGN KEY (`idMethod` , `idUser`)
    REFERENCES `MultiMediaDB`.`Payment_Method` (`idMethod` , `idUser`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Transaction_User`
    FOREIGN KEY (`idUser`)
    REFERENCES `MultiMediaDB`.`User` (`idUser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Fk_Transaction_UserSub`
    FOREIGN KEY (`idUserSub`)
    REFERENCES `MultiMediaDB`.`user_subscriptions` (`idUserSub`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`User_Subscriptions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`User_Subscriptions` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`User_Subscriptions` (
  `idUserSub` INT NOT NULL AUTO_INCREMENT,
  `idSubscription` INT NOT NULL,
  `end_on` DATETIME NULL DEFAULT NULL,
  `idUser` INT NOT NULL,
  `status` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`idUserSub`),
  INDEX `FK_UserSub_Subscription_idx` (`idSubscription` ASC) VISIBLE,
  INDEX `FK_UserSub_User_idx` (`idUser` ASC) VISIBLE,
  CONSTRAINT `FK_UserSub_Subscription`
    FOREIGN KEY (`idSubscription`)
    REFERENCES `MultiMediaDB`.`SubscriptionPlan` (`idSubscription`)
    ON UPDATE CASCADE,
  CONSTRAINT `FK_UserSub_User`
    FOREIGN KEY (`idUser`)
    REFERENCES `MultiMediaDB`.`User` (`idUser`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 30
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`WatchHistory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`WatchHistory` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`WatchHistory` (
  `idUser` INT NOT NULL,
  `idContent` INT NOT NULL,
  `watch_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idUser`, `idContent`),
  INDEX `FK_WatchHistory_Content_idx` (`idContent` ASC) VISIBLE,
  CONSTRAINT `FK_WatchHistory_Content`
    FOREIGN KEY (`idContent`)
    REFERENCES `MultiMediaDB`.`Content` (`idContent`)
    ON UPDATE CASCADE,
  CONSTRAINT `FK_WatchHistory_User`
    FOREIGN KEY (`idUser`)
    REFERENCES `MultiMediaDB`.`User` (`idUser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Watchlist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Watchlist` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Watchlist` (
  `idUser` INT NOT NULL,
  `idContent` INT NOT NULL,
  `time_added` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idUser`, `idContent`),
  INDEX `Fk_Watchlist_Content_idx` (`idContent` ASC) VISIBLE,
  CONSTRAINT `Fk_Watchlist_Content`
    FOREIGN KEY (`idContent`)
    REFERENCES `MultiMediaDB`.`Content` (`idContent`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Watchlist_User`
    FOREIGN KEY (`idUser`)
    REFERENCES `MultiMediaDB`.`User` (`idUser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Watchlist_Request`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MultiMediaDB`.`Watchlist_Request` ;

CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Watchlist_Request` (
  `idUser` INT NOT NULL,
  `idContent` INT NOT NULL,
  `date_requested` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idUser`, `idContent`),
  INDEX `idContent` (`idContent` ASC) VISIBLE,
  CONSTRAINT `watchlist_request_ibfk_1`
    FOREIGN KEY (`idUser`)
    REFERENCES `MultiMediaDB`.`User` (`idUser`),
  CONSTRAINT `watchlist_request_ibfk_2`
    FOREIGN KEY (`idContent`)
    REFERENCES `MultiMediaDB`.`Content` (`idContent`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `MultiMediaDB` ;

-- -----------------------------------------------------
-- function CHECK_SUBSCRIPTION_STATUS
-- -----------------------------------------------------

USE `MultiMediaDB`;
DROP function IF EXISTS `MultiMediaDB`.`CHECK_SUBSCRIPTION_STATUS`;

DELIMITER $$
USE `MultiMediaDB`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `CHECK_SUBSCRIPTION_STATUS`(iDUser INT) RETURNS varchar(45) CHARSET utf8mb4
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

    end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure LOG_FAILED_PAYMENTS
-- -----------------------------------------------------

USE `MultiMediaDB`;
DROP procedure IF EXISTS `MultiMediaDB`.`LOG_FAILED_PAYMENTS`;

DELIMITER $$
USE `MultiMediaDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `LOG_FAILED_PAYMENTS`()
BEGIN
    INSERT IGNORE INTO Payment_Errors(idTransaction, idUser, error_message)
    SELECT T.idTransaction, U.idUser, CONCAT(U.username,' payment of $', T.amount, ' has failed')
    FROM MultiMediaDB.Transaction T
    JOIN MultiMediaDB.User_Subscriptions US on T.idUserSub = US.idUserSub
    JOIN MultiMediaDB.User U on U.idUser = US.idUser
    WHERE T.status = 'fail';

    INSERT IGNORE INTO NOTIFICATIONS(MESSAGE, IDUSER)
    SELECT PE.error_message,PE.idUser
    FROM Payment_Errors PE
    LEFT JOIN NOTIFICATIONS N ON N.message = PE.error_message AND N.idUser = PE.idUser
    WHERE N.idNotification IS NULL;



end$$

DELIMITER ;

-- -----------------------------------------------------
-- function MOST_FREQUENT_ACTOR_DIRECTOR_PAIR
-- -----------------------------------------------------

USE `MultiMediaDB`;
DROP function IF EXISTS `MultiMediaDB`.`MOST_FREQUENT_ACTOR_DIRECTOR_PAIR`;

DELIMITER $$
USE `MultiMediaDB`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `MOST_FREQUENT_ACTOR_DIRECTOR_PAIR`() RETURNS varchar(200) CHARSET utf8mb4
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
    end$$

DELIMITER ;

-- -----------------------------------------------------
-- function Rank_Genres_BY_Hours
-- -----------------------------------------------------

USE `MultiMediaDB`;
DROP function IF EXISTS `MultiMediaDB`.`Rank_Genres_BY_Hours`;

DELIMITER $$
USE `MultiMediaDB`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `Rank_Genres_BY_Hours`() RETURNS varchar(500) CHARSET utf8mb4
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

-- -----------------------------------------------------
-- procedure SET_UNAVAILABLE_FOR_LOW_VIEW_CONTENT
-- -----------------------------------------------------

USE `MultiMediaDB`;
DROP procedure IF EXISTS `MultiMediaDB`.`SET_UNAVAILABLE_FOR_LOW_VIEW_CONTENT`;

DELIMITER $$
USE `MultiMediaDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SET_UNAVAILABLE_FOR_LOW_VIEW_CONTENT`()
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
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure USER_ACTIVITY_REPORT
-- -----------------------------------------------------

USE `MultiMediaDB`;
DROP procedure IF EXISTS `MultiMediaDB`.`USER_ACTIVITY_REPORT`;

DELIMITER $$
USE `MultiMediaDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `USER_ACTIVITY_REPORT`(IN idUser INT)
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
END$$

DELIMITER ;
USE `MultiMediaDB`;

DELIMITER $$

USE `MultiMediaDB`$$
DROP TRIGGER IF EXISTS `MultiMediaDB`.`TRG_Duplicate_Director` $$
USE `MultiMediaDB`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `MultiMediaDB`.`TRG_Duplicate_Director`
AFTER INSERT ON `MultiMediaDB`.`Directed_Content_Request`
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
END$$


USE `MultiMediaDB`$$
DROP TRIGGER IF EXISTS `MultiMediaDB`.`SET_ARCHIVED` $$
USE `MultiMediaDB`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `MultiMediaDB`.`SET_ARCHIVED`
AFTER INSERT ON `MultiMediaDB`.`Review`
FOR EACH ROW
BEGIN
        DECLARE average_rating DECIMAL(3,2);

        SET average_rating = (SELECT AVG(rating_star) FROM Review
                              WHERE idContent = NEW.idContent);

        IF average_rating < 2
            THEN UPDATE Formatted_Content
                 SET idAvailability = 3
                WHERE idContent = NEW.idContent;
        END IF;

    end$$


USE `MultiMediaDB`$$
DROP TRIGGER IF EXISTS `MultiMediaDB`.`TRG_WATCHLIST_CAP` $$
USE `MultiMediaDB`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `MultiMediaDB`.`TRG_WATCHLIST_CAP`
BEFORE INSERT ON `MultiMediaDB`.`Watchlist_Request`
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
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
