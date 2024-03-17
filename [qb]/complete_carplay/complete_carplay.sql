USE `qbcoreframework_58e3e5`;

CREATE TABLE `complete_carplay` (
  `carplayID` int NOT NULL AUTO_INCREMENT,
  `carPlate` varchar(255) NOT NULL,
  `headlight` boolean NOT NULL,
  `interior` boolean NOT NULL,
  `windows` boolean NOT NULL,
  `trunk` boolean NOT NULL,
  `door1` boolean NOT NULL,
  `door2` boolean NOT NULL,
  `door3` boolean NOT NULL,
  `door4` boolean NOT NULL,
  `lock` boolean NOT NULL,
  `cruise` boolean NOT NULL,
  `hColor` int NOT NULL DEFAULT 0,
  `savedSongs` longtext,
  PRIMARY KEY (`carplayID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `player_vehicles`
ADD `carplayID` int;