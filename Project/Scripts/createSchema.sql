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

-- -----------------------------------------------------
-- Schema MultiMediaDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `MultiMediaDB` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `MultiMediaDB` ;

-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Country` (
  `idCountry` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCountry`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Rating`
-- -----------------------------------------------------
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
CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Content_Release` (
  `idRelease` INT NOT NULL,
  `release_year` YEAR NOT NULL,
  PRIMARY KEY (`idRelease`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Content` (
  `idContent` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(400) NULL DEFAULT NULL,
  `type` VARCHAR(45) NOT NULL,
  `idCountry` INT NULL DEFAULT NULL,
  `idRating` INT NULL DEFAULT NULL,
  `duration` VARCHAR(45) NOT NULL,
  `idRelease` INT NULL DEFAULT NULL,
  `date_added` DATETIME NOT NULL,
  PRIMARY KEY (`idContent`),
  INDEX `FK_Content_Rating_idx` (`idRating` ASC) VISIBLE,
  INDEX `Fk_Content_Country_idx` (`idCountry` ASC) VISIBLE,
  INDEX `FK_Content_Release_idx` (`idRelease` ASC) VISIBLE,
  CONSTRAINT `Fk_Content_Country`
    FOREIGN KEY (`idCountry`)
    REFERENCES `MultiMediaDB`.`Country` (`idCountry`)
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Content_Rating`
    FOREIGN KEY (`idRating`)
    REFERENCES `MultiMediaDB`.`Rating` (`idRating`)
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Content_Release`
    FOREIGN KEY (`idRelease`)
    REFERENCES `MultiMediaDB`.`Content_Release` (`idRelease`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Content_Accessibility`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Content_Accessibility` (
  `idAccessibility` INT NOT NULL AUTO_INCREMENT,
  `feature_name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idAccessibility`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Accessible_Content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Accessible_Content` (
  `idAccessibility` INT NOT NULL,
  `idContent` INT NOT NULL,
  PRIMARY KEY (`idAccessibility`, `idContent`),
  INDEX `Fk_AccessibleContent_Content_idx` (`idContent` ASC) VISIBLE,
  CONSTRAINT `Fk_AccessibleContent_Content`
    FOREIGN KEY (`idContent`)
    REFERENCES `MultiMediaDB`.`Content` (`idContent`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_AccessibleContent_ContentAccessibility`
    FOREIGN KEY (`idAccessibility`)
    REFERENCES `MultiMediaDB`.`Content_Accessibility` (`idAccessibility`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Actor` (
  `idActors` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `DOB` DATETIME NOT NULL,
  PRIMARY KEY (`idActors`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Content_Availability`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Content_Availability` (
  `idContent` INT NOT NULL,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  `idCountry` INT NOT NULL,
  PRIMARY KEY (`idContent`, `idCountry`),
  INDEX `FK_Availability_Country_idx` (`idCountry` ASC) VISIBLE,
  CONSTRAINT `FK_Availability_Content`
    FOREIGN KEY (`idContent`)
    REFERENCES `MultiMediaDB`.`Content` (`idContent`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Availability_Country`
    FOREIGN KEY (`idCountry`)
    REFERENCES `MultiMediaDB`.`Country` (`idCountry`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Content_Cast`
-- -----------------------------------------------------
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
CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Content_Format` (
  `idFormat` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idFormat`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Genre` (
  `idGenre` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idGenre`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Content_Genre`
-- -----------------------------------------------------
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
-- Table `MultiMediaDB`.`Director`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Director` (
  `idDirector` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `DOB` DATETIME NOT NULL,
  PRIMARY KEY (`idDirector`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Directed_Content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Directed_Content` (
  `idContent` INT NOT NULL,
  `idDirector` INT NOT NULL,
  PRIMARY KEY (`idContent`, `idDirector`),
  INDEX `FK_DIrectedContent_Director_idx` (`idDirector` ASC) VISIBLE,
  CONSTRAINT `FK_DirectedContent_Content`
    FOREIGN KEY (`idContent`)
    REFERENCES `MultiMediaDB`.`Content` (`idContent`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_DIrectedContent_Director`
    FOREIGN KEY (`idDirector`)
    REFERENCES `MultiMediaDB`.`Director` (`idDirector`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Formatted_Content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Formatted_Content` (
  `idContent` INT NOT NULL,
  `idFormat` INT NOT NULL,
  PRIMARY KEY (`idContent`, `idFormat`),
  INDEX `FK_Content&Format_Format_idx` (`idFormat` ASC) VISIBLE,
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
-- Table `MultiMediaDB`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`User` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `DOB` DATETIME NOT NULL,
  PRIMARY KEY (`idUser`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Payment_Method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Payment_Method` (
  `idMethod` INT NOT NULL AUTO_INCREMENT,
  `idUser` INT NOT NULL,
  `payment_type` VARCHAR(45) NOT NULL,
  `provider` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMethod`),
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
CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Review` (
  `idReview` INT NOT NULL AUTO_INCREMENT,
  `idUser` INT NOT NULL,
  `idContent` INT NOT NULL,
  `review_text` TEXT NOT NULL,
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
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`SubscriptionPlan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`SubscriptionPlan` (
  `idSubscription` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `price` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`idSubscription`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Tag`
-- -----------------------------------------------------
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
-- Table `MultiMediaDB`.`User_Subscriptions`
-- -----------------------------------------------------
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
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`Transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Transaction` (
  `idTransaction` INT NOT NULL AUTO_INCREMENT,
  `idUserSub` INT NOT NULL,
  `idMethod` INT NOT NULL,
  PRIMARY KEY (`idTransaction`),
  INDEX `FK_Transaction_PaymentMethod_idx` (`idMethod` ASC) VISIBLE,
  INDEX `Fk_Transaction_UserSub_idx` (`idUserSub` ASC) VISIBLE,
  CONSTRAINT `FK_Transaction_PaymentMethod`
    FOREIGN KEY (`idMethod`)
    REFERENCES `MultiMediaDB`.`Payment_Method` (`idMethod`),
  CONSTRAINT `Fk_Transaction_UserSub`
    FOREIGN KEY (`idUserSub`)
    REFERENCES `MultiMediaDB`.`User_Subscriptions` (`idUserSub`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `MultiMediaDB`.`WatchHistory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`WatchHistory` (
  `idUser` INT NOT NULL,
  `idContent` INT NOT NULL,
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
CREATE TABLE IF NOT EXISTS `MultiMediaDB`.`Watchlist` (
  `idUser` INT NOT NULL,
  `idContent` INT NOT NULL,
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


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
