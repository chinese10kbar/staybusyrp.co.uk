DROP TABLE IF EXISTS `bank_process`;

CREATE TABLE `bank_process` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `owner` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_unicode_ci',
    `type` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_unicode_ci',
    `icon` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_unicode_ci',
    `text` TEXT NOT NULL COLLATE 'utf8mb4_unicode_ci',
    `created` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_unicode_ci',
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_unicode_ci' ENGINE = InnoDB AUTO_INCREMENT = 1;

DROP TABLE IF EXISTS `bank_cards`;

CREATE TABLE `bank_cards` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    `cardNumber` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    `ownerName` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    `valid` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    `cardType` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    `active` INT(11) NOT NULL DEFAULT '0',
    `passCode` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 1;

DROP TABLE IF EXISTS `bank_history`;

CREATE TABLE `bank_history` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(50) NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
    `amount` INT(11) NOT NULL DEFAULT '0',
    `type` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `date` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB;