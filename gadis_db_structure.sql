SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `did` bigint(20) DEFAULT NULL,
  `sid` bigint(20) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `rank` int(11) NOT NULL DEFAULT 1,
  `previous_rank` int(11) NOT NULL DEFAULT 1,
  `donated` tinyint(1) NOT NULL DEFAULT 0,
  `hours` bigint(20) NOT NULL DEFAULT 0,
  `title` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `slogan` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `honorary` tinyint(1) NOT NULL DEFAULT 0,
  `infractions` decimal(2,1) NOT NULL DEFAULT 0.0,
  `locked` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `active` (
  `id` bigint(20) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `antispam` (
  `id` bigint(20) NOT NULL,
  `ignore` tinyint(1) NOT NULL DEFAULT 0,
  `violations` bigint(20) NOT NULL DEFAULT 0,
  `identical` int(11) NOT NULL DEFAULT 0,
  `fast` int(11) NOT NULL DEFAULT 0,
  `message` longblob DEFAULT NULL,
  `timestamp` int(11) NOT NULL DEFAULT 0,
  `mute_until` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `antispam_ignore` (
  `id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `applications` (
  `id` int(11) NOT NULL,
  `denied` tinyint(1) NOT NULL DEFAULT 0,
  `accepted` tinyint(1) NOT NULL DEFAULT 0,
  `interviewed` tinyint(1) NOT NULL DEFAULT 0,
  `message` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `link` (
  `code` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `metrics` (
  `id` bigint(20) NOT NULL,
  `connect` timestamp NOT NULL DEFAULT current_timestamp(),
  `disconnect` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `modules` (
  `name` varchar(256) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `ranks` (
  `name` varchar(64) NOT NULL,
  `id` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `recommends` (
  `id` int(11) NOT NULL,
  `admin` int(11) NOT NULL,
  `reason` varchar(1000) NOT NULL,
  `positive` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sid` (`sid`),
  ADD UNIQUE KEY `did` (`did`),
  ADD KEY `previous_rank` (`previous_rank`);

ALTER TABLE `active`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `antispam`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `antispam_ignore`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `applications`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `link`
  ADD PRIMARY KEY (`code`),
  ADD UNIQUE KEY `id` (`id`);

ALTER TABLE `metrics`
  ADD UNIQUE KEY `id` (`id`,`connect`,`disconnect`);

ALTER TABLE `modules`
  ADD PRIMARY KEY (`name`);

ALTER TABLE `ranks`
  ADD PRIMARY KEY (`name`);

ALTER TABLE `recommends`
  ADD PRIMARY KEY (`id`,`admin`) USING BTREE,
  ADD KEY `admin` (`admin`),
  ADD KEY `id` (`id`);


ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;


ALTER TABLE `applications`
  ADD CONSTRAINT `ApplicantID` FOREIGN KEY (`id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `recommends`
  ADD CONSTRAINT `RecommenderID` FOREIGN KEY (`admin`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `RecommenedID` FOREIGN KEY (`id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
