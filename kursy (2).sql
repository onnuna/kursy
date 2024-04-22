SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `systemszkoleniowy` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci;
USE `systemszkoleniowy`;

DELIMITER $$
DROP PROCEDURE IF EXISTS `DodajUczestnika`$$
CREATE DEFINER=`root`@`192.168.30.%` PROCEDURE `DodajUczestnika` (IN `imie` VARCHAR(255), IN `nazwisko` VARCHAR(255), IN `email` VARCHAR(255), IN `numer_telefonu` VARCHAR(15))   BEGIN
    INSERT INTO uczestnicy (Imie, Nazwisko, Email, NumerTelefonu) VALUES (imie, nazwisko, email, numer_telefonu);
END$$

DELIMITER ;

DROP TABLE IF EXISTS `kursy`;
CREATE TABLE IF NOT EXISTS `kursy` (
  `ID` int(11) NOT NULL,
  `NazwaKursu` varchar(255) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `Opis` text COLLATE utf8mb4_polish_ci,
  `Instruktor` varchar(255) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

INSERT DELAYED IGNORE INTO `kursy` (`ID`, `NazwaKursu`, `Opis`, `Instruktor`) VALUES
(1, 'Kurs PHP', 'Podstawy programowania w PHP', 'Jan Kowalski'),
(2, 'Kurs SQL', 'Podstawy języka SQL', 'Anna Nowak'),
(3, 'Kurs JavaScript', 'Podstawy programowania w JavaScript', 'Maria Zalewska'),
(4, 'Kurs Python', 'Podstawy programowania w Python', 'Piotr Nowak');
DROP VIEW IF EXISTS `Kursy_Uczestnicy`;
CREATE TABLE IF NOT EXISTS `Kursy_Uczestnicy` (
`NazwaKursu` varchar(255)
,`Imie` varchar(255)
,`Nazwisko` varchar(255)
);

DROP TABLE IF EXISTS `rejestracjenakurs`;
CREATE TABLE IF NOT EXISTS `rejestracjenakurs` (
  `ID` int(11) NOT NULL,
  `IDKursu` int(11) DEFAULT NULL,
  `IDUczestnika` int(11) DEFAULT NULL,
  `DataRejestracji` date DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDKursu` (`IDKursu`),
  KEY `IDUczestnika` (`IDUczestnika`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

INSERT DELAYED IGNORE INTO `rejestracjenakurs` (`ID`, `IDKursu`, `IDUczestnika`, `DataRejestracji`) VALUES
(1, 1, 1, '2024-03-06'),
(2, 2, 2, '2024-03-07'),
(3, 3, 3, '2024-03-08'),
(4, 4, 4, '2024-03-09');

DROP TABLE IF EXISTS `uczestnicy`;
CREATE TABLE IF NOT EXISTS `uczestnicy` (
  `ID` int(11) NOT NULL,
  `Imie` varchar(255) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `Nazwisko` varchar(255) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `Email` varchar(255) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `NumerTelefonu` varchar(15) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

INSERT DELAYED IGNORE INTO `uczestnicy` (`ID`, `Imie`, `Nazwisko`, `Email`, `NumerTelefonu`) VALUES
(1, 'Adam', 'Nowak', 'adam.nowak@email.com', '123-456-789'),
(2, 'Ewa', 'Kowalska', 'ewa.kowalska@email.com', '987-654-321'),
(3, 'Katarzyna', 'Wójcik', 'katarzyna.wojcik@email.com', '456-789-012'),
(4, 'Michał', 'Lis', 'michal.lis@email.com', '789-012-345');
DROP TRIGGER IF EXISTS `Before_Uczestnicy_Insert`;
DELIMITER $$
CREATE TRIGGER `Before_Uczestnicy_Insert` BEFORE INSERT ON `uczestnicy` FOR EACH ROW BEGIN
    IF CHAR_LENGTH(NEW.NumerTelefonu) != 9 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Numer telefonu musi składać się z 9 cyfr';
    END IF;
END
$$
DELIMITER ;
DROP TABLE IF EXISTS `Kursy_Uczestnicy`;

DROP VIEW IF EXISTS `Kursy_Uczestnicy`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`192.168.30.%` SQL SECURITY DEFINER VIEW `Kursy_Uczestnicy`  AS SELECT `K`.`NazwaKursu` AS `NazwaKursu`, `U`.`Imie` AS `Imie`, `U`.`Nazwisko` AS `Nazwisko` FROM ((`kursy` `K` join `rejestracjenakurs` `R` on((`K`.`ID` = `R`.`IDKursu`))) join `uczestnicy` `U` on((`R`.`IDUczestnika` = `U`.`ID`))) ;


ALTER TABLE `rejestracjenakurs`
  ADD CONSTRAINT `rejestracjenakurs_ibfk_1` FOREIGN KEY (`IDKursu`) REFERENCES `kursy` (`ID`),
  ADD CONSTRAINT `rejestracjenakurs_ibfk_2` FOREIGN KEY (`IDUczestnika`) REFERENCES `uczestnicy` (`ID`);
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
