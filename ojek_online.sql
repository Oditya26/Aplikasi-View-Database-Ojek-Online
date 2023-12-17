-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 06, 2023 at 10:02 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ojek_online`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetDriverSchedule` (IN `p_driver_name` VARCHAR(50))   BEGIN
    SELECT
        d.name AS driver_name,
        s.schedule_id,
        r.start_location,
        r.end_location,
        s.departure_time,
        s.arrival_time
    FROM
        driver d
    JOIN
        schedule s ON d.driver_id = s.vehicle_id
    JOIN
        route r ON s.route_id = r.route_id
    WHERE
        d.name = p_driver_name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPassengerSchedule` (IN `p_passenger_name` VARCHAR(50))   BEGIN
    SELECT p.name AS passenger_name, p.contact_number, s.schedule_id, r.start_location, r.end_location, s.departure_time, s.arrival_time, b.booking_date, b.status
    FROM passenger p
    JOIN booking b ON p.passenger_id = b.passenger_id
    JOIN schedule s ON b.schedule_id = s.schedule_id
    JOIN route r ON s.route_id = r.route_id
    WHERE p.name = p_passenger_name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetRouteDetails` (IN `i_start` VARCHAR(30), IN `i_end` VARCHAR(30))   BEGIN
    SELECT *
    FROM route r
    WHERE r.start_location = i_start AND r.end_location = i_end;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateBookingStatus` (IN `p_booking_id` VARCHAR(7), IN `p_new_status` VARCHAR(20))   BEGIN
    UPDATE booking
    SET status = p_new_status
    WHERE booking_id = p_booking_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `booking_id` varchar(7) NOT NULL CHECK (`booking_id` regexp 'BKG[0-9][0-9][0-9]'),
  `driver_id` varchar(7) DEFAULT NULL CHECK (`driver_id` regexp 'DRV[0-9][0-9][0-9]'),
  `passenger_id` varchar(7) DEFAULT NULL CHECK (`passenger_id` regexp 'PSG[0-9][0-9][0-9]'),
  `schedule_id` varchar(7) DEFAULT NULL CHECK (`schedule_id` regexp 'SCH[0-9][0-9][0-9]'),
  `booking_date` date NOT NULL,
  `status` varchar(20) DEFAULT NULL CHECK (`status` in ('Confirmed','Pending'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`booking_id`, `driver_id`, `passenger_id`, `schedule_id`, `booking_date`, `status`) VALUES
('BKG001', 'DRV001', 'PSG001', 'SCH001', '2023-10-03', 'Confirmed'),
('BKG002', 'DRV002', 'PSG002', 'SCH002', '2023-09-04', 'Confirmed'),
('BKG003', 'DRV003', 'PSG003', 'SCH003', '2023-11-15', 'Pending'),
('BKG004', 'DRV004', 'PSG004', 'SCH004', '2023-12-01', 'Confirmed'),
('BKG005', 'DRV005', 'PSG005', 'SCH005', '2023-12-01', 'Pending'),
('BKG006', 'DRV006', 'PSG006', 'SCH006', '2023-12-01', 'Confirmed'),
('BKG007', 'DRV007', 'PSG007', 'SCH007', '2023-12-02', 'Pending'),
('BKG008', 'DRV008', 'PSG008', 'SCH008', '2023-12-02', 'Confirmed'),
('BKG009', 'DRV004', 'PSG007', 'SCH004', '2023-11-20', 'Confirmed'),
('BKG010', 'DRV005', 'PSG008', 'SCH005', '2023-11-21', 'Pending'),
('BKG011', 'DRV006', 'PSG009', 'SCH006', '2023-11-22', 'Confirmed'),
('BKG012', 'DRV007', 'PSG010', 'SCH007', '2023-11-23', 'Confirmed'),
('BKG013', 'DRV008', 'PSG011', 'SCH008', '2023-11-24', 'Pending'),
('BKG014', 'DRV009', 'PSG012', 'SCH009', '2023-11-25', 'Confirmed'),
('BKG015', 'DRV010', 'PSG013', 'SCH010', '2023-11-26', 'Confirmed'),
('BKG016', 'DRV011', 'PSG014', 'SCH011', '2023-11-27', 'Pending'),
('BKG017', 'DRV012', 'PSG015', 'SCH012', '2023-11-28', 'Confirmed'),
('BKG018', 'DRV013', 'PSG016', 'SCH013', '2023-11-29', 'Confirmed'),
('BKG019', 'DRV014', 'PSG017', 'SCH014', '2023-11-30', 'Pending'),
('BKG020', 'DRV015', 'PSG018', 'SCH015', '2023-12-01', 'Confirmed'),
('BKG021', 'DRV016', 'PSG019', 'SCH016', '2023-12-02', 'Confirmed'),
('BKG022', 'DRV017', 'PSG020', 'SCH017', '2023-12-03', 'Pending'),
('BKG023', 'DRV004', 'PSG021', 'SCH018', '2023-12-04', 'Confirmed'),
('BKG024', 'DRV005', 'PSG022', 'SCH019', '2023-12-05', 'Confirmed'),
('BKG025', 'DRV006', 'PSG023', 'SCH020', '2023-12-06', 'Pending'),
('BKG026', 'DRV007', 'PSG024', 'SCH021', '2023-12-07', 'Confirmed'),
('BKG027', 'DRV008', 'PSG025', 'SCH022', '2023-12-08', 'Confirmed'),
('BKG028', 'DRV004', 'PSG026', 'SCH023', '2023-12-09', 'Pending'),
('BKG029', 'DRV005', 'PSG027', 'SCH024', '2023-12-10', 'Confirmed'),
('BKG030', 'DRV006', 'PSG028', 'SCH025', '2023-12-11', 'Confirmed'),
('BKG031', 'DRV007', 'PSG029', 'SCH026', '2023-12-12', 'Pending'),
('BKG032', 'DRV008', 'PSG030', 'SCH027', '2023-12-13', 'Confirmed'),
('BKG033', 'DRV009', 'PSG031', 'SCH028', '2023-12-14', 'Confirmed'),
('BKG034', 'DRV010', 'PSG032', 'SCH029', '2023-12-15', 'Pending'),
('BKG035', 'DRV011', 'PSG007', 'SCH030', '2023-12-16', 'Confirmed'),
('BKG036', 'DRV012', 'PSG008', 'SCH031', '2023-12-17', 'Pending'),
('BKG037', 'DRV013', 'PSG009', 'SCH032', '2023-12-18', 'Confirmed'),
('BKG038', 'DRV014', 'PSG010', 'SCH033', '2023-12-19', 'Confirmed'),
('BKG039', 'DRV015', 'PSG011', 'SCH034', '2023-12-20', 'Pending'),
('BKG040', 'DRV016', 'PSG012', 'SCH035', '2023-12-21', 'Confirmed'),
('BKG041', 'DRV017', 'PSG013', 'SCH036', '2023-12-22', 'Confirmed'),
('BKG042', 'DRV004', 'PSG014', 'SCH037', '2023-12-23', 'Pending'),
('BKG043', 'DRV005', 'PSG015', 'SCH038', '2023-12-24', 'Confirmed'),
('BKG044', 'DRV006', 'PSG016', 'SCH039', '2023-12-25', 'Confirmed'),
('BKG045', 'DRV007', 'PSG017', 'SCH040', '2023-12-26', 'Pending'),
('BKG046', 'DRV008', 'PSG018', 'SCH041', '2023-12-27', 'Confirmed'),
('BKG047', 'DRV004', 'PSG019', 'SCH042', '2023-12-28', 'Confirmed'),
('BKG048', 'DRV005', 'PSG020', 'SCH043', '2023-12-29', 'Pending'),
('BKG049', 'DRV006', 'PSG021', 'SCH044', '2023-12-30', 'Confirmed'),
('BKG050', 'DRV007', 'PSG022', 'SCH045', '2023-12-31', 'Confirmed'),
('BKG051', 'DRV008', 'PSG007', 'SCH046', '2024-01-01', 'Pending'),
('BKG052', 'DRV009', 'PSG008', 'SCH047', '2024-01-02', 'Confirmed'),
('BKG053', 'DRV010', 'PSG009', 'SCH048', '2024-01-03', 'Confirmed'),
('BKG054', 'DRV011', 'PSG010', 'SCH049', '2024-01-04', 'Pending'),
('BKG055', 'DRV012', 'PSG011', 'SCH050', '2024-01-05', 'Confirmed'),
('BKG056', 'DRV013', 'PSG012', 'SCH051', '2024-01-06', 'Confirmed'),
('BKG057', 'DRV014', 'PSG013', 'SCH052', '2024-01-07', 'Pending'),
('BKG058', 'DRV015', 'PSG014', 'SCH004', '2024-01-08', 'Confirmed'),
('BKG059', 'DRV016', 'PSG015', 'SCH005', '2024-01-09', 'Confirmed'),
('BKG060', 'DRV017', 'PSG016', 'SCH006', '2024-01-10', 'Pending'),
('BKG061', 'DRV001', 'PSG017', 'SCH007', '2024-01-11', 'Confirmed'),
('BKG062', 'DRV002', 'PSG018', 'SCH008', '2024-01-12', 'Confirmed'),
('BKG063', 'DRV003', 'PSG019', 'SCH004', '2024-01-13', 'Pending'),
('BKG064', 'DRV004', 'PSG020', 'SCH005', '2024-01-14', 'Confirmed'),
('BKG065', 'DRV005', 'PSG021', 'SCH006', '2024-01-15', 'Confirmed'),
('BKG066', 'DRV006', 'PSG022', 'SCH007', '2024-01-16', 'Pending'),
('BKG067', 'DRV007', 'PSG007', 'SCH008', '2024-01-17', 'Confirmed');

-- --------------------------------------------------------

--
-- Stand-in structure for view `confirmed_booking`
-- (See below for the actual view)
--
CREATE TABLE `confirmed_booking` (
`Nama Pengemudi` varchar(50)
,`Nomor Lisensi Pengemudi` varchar(20)
,`Nama Penumpang` varchar(50)
,`Keberangkatan` varchar(50)
,`Tujuan` varchar(50)
,`Status` varchar(20)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `confirmed_bookings`
-- (See below for the actual view)
--
CREATE TABLE `confirmed_bookings` (
`Nama Pengemudi` varchar(50)
,`Nomor Lisensi Pengemudi` varchar(20)
,`Nama Penumpang` varchar(50)
,`Keberangkatan` varchar(50)
,`Tujuan` varchar(50)
,`Status` varchar(20)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `contact_driver`
-- (See below for the actual view)
--
CREATE TABLE `contact_driver` (
`Nama Pengemudi` varchar(50)
,`Kontak Pengemudi` varchar(20)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `contact_passenger`
-- (See below for the actual view)
--
CREATE TABLE `contact_passenger` (
`Nama Penumpang` varchar(50)
,`Kontak Penumpang` varchar(20)
);

-- --------------------------------------------------------

--
-- Table structure for table `driver`
--

CREATE TABLE `driver` (
  `driver_id` varchar(7) NOT NULL CHECK (`driver_id` regexp 'DRV[0-9][0-9][0-9]'),
  `name` varchar(50) NOT NULL,
  `age` int(11) NOT NULL,
  `gender` varchar(10) DEFAULT NULL CHECK (`gender` in ('Female','Male')),
  `contact_number` varchar(20) NOT NULL,
  `license_number` varchar(20) NOT NULL CHECK (`license_number` regexp 'DL-[0-9][0-9][0-9][0-9][0-9]')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `driver`
--

INSERT INTO `driver` (`driver_id`, `name`, `age`, `gender`, `contact_number`, `license_number`) VALUES
('DRV001', 'John Doe', 35, 'Male', '081234567890', 'DL-12345'),
('DRV002', 'Jane Smith', 28, 'Female', '087654321098', 'DL-54321'),
('DRV003', 'David Lee', 40, 'Male', '081111222333', 'DL-99999'),
('DRV004', 'Grace Tan', 29, 'Female', '081234567893', 'DL-67890'),
('DRV005', 'Hadi Wijaya', 32, 'Male', '087654321100', 'DL-13579'),
('DRV006', 'Ika Sari', 25, 'Female', '081111222336', 'DL-24680'),
('DRV007', 'Lina Wijaya', 29, 'Female', '081234567895', 'DL-87654'),
('DRV008', 'Mochammad Yusuf', 32, 'Male', '087654321101', 'DL-24681'),
('DRV009', 'Lia Wijayanti', 28, 'Female', '081234567904', 'DL-56789'),
('DRV010', 'Mochammad Rizki', 32, 'Male', '087654321102', 'DL-98765'),
('DRV011', 'Nia Rachmawati', 29, 'Female', '081111222347', 'DL-54321'),
('DRV012', 'Oscar Pratama', 30, 'Male', '081234567905', 'DL-87654'),
('DRV013', 'Putri Ramadhani', 26, 'Female', '085678901244', 'DL-23456'),
('DRV014', 'Qori Hidayat', 33, 'Male', '081111222348', 'DL-76543'),
('DRV015', 'Rina Susanti', 29, 'Female', '081234567906', 'DL-87654'),
('DRV016', 'Surya Nugroho', 32, 'Male', '087654321103', 'DL-34567'),
('DRV017', 'Tia Amelia', 28, 'Female', '081111222349', 'DL-12345'),
('DRV018', 'Siti Rahayu', 25, 'Female', '081111222338', 'DL-97531');

-- --------------------------------------------------------

--
-- Stand-in structure for view `list_drivers`
-- (See below for the actual view)
--
CREATE TABLE `list_drivers` (
`Nama Pengemudi` varchar(50)
,`Nomor Lisensi Pengemudi` varchar(20)
);

-- --------------------------------------------------------

--
-- Table structure for table `passenger`
--

CREATE TABLE `passenger` (
  `passenger_id` varchar(7) NOT NULL CHECK (`passenger_id` regexp 'PSG[0-9][0-9][0-9]'),
  `name` varchar(50) NOT NULL,
  `age` int(11) NOT NULL,
  `gender` varchar(10) DEFAULT NULL CHECK (`gender` in ('Female','Male')),
  `contact_number` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `passenger`
--

INSERT INTO `passenger` (`passenger_id`, `name`, `age`, `gender`, `contact_number`, `email`) VALUES
('PSG001', 'Alice Lee', 25, 'Female', '081234567891', 'alice@gmail.com'),
('PSG002', 'Bob Smith', 30, 'Male', '087654321099', 'bob@gmail.com'),
('PSG003', 'Cindy Tan', 20, 'Female', '081111222334', 'cindy@gmail.com'),
('PSG004', 'Dian Pratama', 28, 'Male', '081234567892', 'dian@example.com'),
('PSG005', 'Eka Putri', 22, 'Female', '085678901234', 'eka@example.com'),
('PSG006', 'Firman Setiawan', 35, 'Male', '081111222335', 'firman@example.com'),
('PSG007', 'Joko Susilo', 40, 'Male', '081234567894', 'joko@example.com'),
('PSG008', 'Kartika Dewi', 33, 'Female', '085678901235', 'kartika@example.com'),
('PSG009', 'Linda Surya', 27, 'Female', '081234567896', 'linda@example.com'),
('PSG010', 'Maulana Rahman', 32, 'Male', '087654321102', 'maulana@example.com'),
('PSG011', 'Nina Putri', 29, 'Female', '081111222339', 'nina@example.com'),
('PSG012', 'Oscar Gunawan', 34, 'Male', '081234567897', 'oscar@example.com'),
('PSG013', 'Putri Permata', 26, 'Female', '085678901236', 'putri@example.com'),
('PSG014', 'Rahmat Wijaya', 31, 'Male', '087654321103', 'rahmat@example.com'),
('PSG015', 'Siti Mawar', 23, 'Female', '081111222340', 'siti@example.com'),
('PSG016', 'Taufik Hidayat', 35, 'Male', '081234567898', 'taufik@example.com'),
('PSG017', 'Umi Kusuma', 28, 'Female', '085678901237', 'umi@example.com'),
('PSG018', 'Vino Santoso', 33, 'Male', '087654321104', 'vino@example.com'),
('PSG019', 'Wulan Septiani', 30, 'Female', '081111222341', 'wulan@example.com'),
('PSG020', 'Xavier Santoso', 36, 'Male', '081234567899', 'xavier@example.com'),
('PSG021', 'Yani Susanti', 29, 'Female', '085678901238', 'yani@example.com'),
('PSG022', 'Zacky Cahyono', 34, 'Male', '087654321105', 'zacky@example.com'),
('PSG023', 'Andini Hartati', 27, 'Female', '081111222342', 'andini@example.com'),
('PSG024', 'Bayu Wibowo', 32, 'Male', '081234567810', 'bayu@example.com'),
('PSG025', 'Citra Maharani', 25, 'Female', '085678901239', 'citra@example.com'),
('PSG026', 'Dharma Nugraha', 30, 'Male', '087654321106', 'dharma@example.com'),
('PSG027', 'Eva Rachmawati', 28, 'Female', '081111222343', 'eva@example.com'),
('PSG028', 'Fauzi Abdullah', 35, 'Male', '081234567811', 'fauzi@example.com'),
('PSG029', 'Gina Purnama', 31, 'Female', '085678901240', 'gina@example.com'),
('PSG030', 'Hendra Santoso', 29, 'Male', '087654321107', 'hendra@example.com'),
('PSG031', 'Intan Putri', 26, 'Female', '081111222344', 'intan@example.com'),
('PSG032', 'Joko Prasetyo', 33, 'Male', '081234567812', 'joko@example.com');

-- --------------------------------------------------------

--
-- Stand-in structure for view `pending_bookings`
-- (See below for the actual view)
--
CREATE TABLE `pending_bookings` (
`Nama Pengemudi` varchar(50)
,`Nomor Lisensi Pengemudi` varchar(20)
,`Nama Penumpang` varchar(50)
,`Keberangkatan` varchar(50)
,`Tujuan` varchar(50)
,`Status` varchar(20)
);

-- --------------------------------------------------------

--
-- Table structure for table `price`
--

CREATE TABLE `price` (
  `price_id` varchar(7) NOT NULL CHECK (`price_id` regexp 'PRC[0-9][0-9][0-9]'),
  `route_id` varchar(7) DEFAULT NULL CHECK (`route_id` regexp 'RTE[0-9][0-9][0-9]'),
  `vehicle_type` varchar(20) NOT NULL,
  `price_per_km` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `price`
--

INSERT INTO `price` (`price_id`, `route_id`, `vehicle_type`, `price_per_km`) VALUES
('PRC001', 'RTE001', 'Bus', 5000),
('PRC002', 'RTE002', 'Car', 3000),
('PRC003', 'RTE003', 'Motorcycle', 2000),
('PRC004', 'RTE004', 'Car', 4000),
('PRC005', 'RTE005', 'Motorcycle', 2500),
('PRC006', 'RTE006', 'Car', 3500),
('PRC007', 'RTE007', 'Car', 3500),
('PRC008', 'RTE008', 'Motorcycle', 2000),
('PRC009', 'RTE009', 'Car', 3500),
('PRC010', 'RTE010', 'Motorcycle', 1800),
('PRC011', 'RTE011', 'Car', 3200),
('PRC012', 'RTE012', 'Motorcycle', 2000),
('PRC013', 'RTE013', 'Car', 2800),
('PRC014', 'RTE014', 'Motorcycle', 1500),
('PRC015', 'RTE015', 'Car', 3000),
('PRC016', 'RTE016', 'Motorcycle', 1600),
('PRC017', 'RTE017', 'Car', 3400),
('PRC018', 'RTE018', 'Motorcycle', 1900),
('PRC019', 'RTE019', 'Car', 3100),
('PRC020', 'RTE020', 'Motorcycle', 1700),
('PRC021', 'RTE021', 'Car', 3300),
('PRC022', 'RTE022', 'Motorcycle', 2000),
('PRC023', 'RTE023', 'Car', 2900),
('PRC024', 'RTE024', 'Motorcycle', 1600),
('PRC025', 'RTE025', 'Car', 3100),
('PRC026', 'RTE026', 'Motorcycle', 1700),
('PRC027', 'RTE027', 'Car', 3400),
('PRC028', 'RTE028', 'Motorcycle', 1800),
('PRC029', 'RTE029', 'Car', 3000),
('PRC030', 'RTE030', 'Motorcycle', 1900),
('PRC031', 'RTE031', 'Car', 3300),
('PRC032', 'RTE032', 'Motorcycle', 2000),
('PRC033', 'RTE033', 'Car', 2800),
('PRC034', 'RTE034', 'Motorcycle', 1500),
('PRC035', 'RTE035', 'Car', 3200),
('PRC036', 'RTE036', 'Motorcycle', 1800),
('PRC037', 'RTE037', 'Car', 3100),
('PRC038', 'RTE038', 'Motorcycle', 1700),
('PRC039', 'RTE039', 'Car', 3400),
('PRC040', 'RTE040', 'Motorcycle', 1900),
('PRC041', 'RTE041', 'Car', 3300),
('PRC042', 'RTE042', 'Motorcycle', 2000),
('PRC043', 'RTE043', 'Car', 2900),
('PRC044', 'RTE044', 'Motorcycle', 1600),
('PRC045', 'RTE045', 'Car', 3000),
('PRC046', 'RTE046', 'Motorcycle', 1700),
('PRC047', 'RTE047', 'Car', 3400),
('PRC048', 'RTE048', 'Motorcycle', 1800),
('PRC049', 'RTE049', 'Car', 3100),
('PRC050', 'RTE050', 'Motorcycle', 1900),
('PRC051', 'RTE051', 'Car', 3300),
('PRC052', 'RTE052', 'Motorcycle', 2000),
('PRC053', 'RTE053', 'Car', 2800),
('PRC054', 'RTE054', 'Motorcycle', 1500);

-- --------------------------------------------------------

--
-- Table structure for table `route`
--

CREATE TABLE `route` (
  `route_id` varchar(7) NOT NULL CHECK (`route_id` regexp 'RTE[0-9][0-9][0-9]'),
  `start_location` varchar(50) NOT NULL,
  `end_location` varchar(50) NOT NULL,
  `distance` int(11) NOT NULL,
  `estimated_time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `route`
--

INSERT INTO `route` (`route_id`, `start_location`, `end_location`, `distance`, `estimated_time`) VALUES
('RTE001', 'Jakarta', 'Bandung', 150, 3),
('RTE002', 'Surabaya', 'Malang', 100, 2),
('RTE003', 'Medan', 'Banda Aceh', 300, 5),
('RTE004', 'Klojen', 'Sukun', 5, 15),
('RTE005', 'Lowokwaru', 'Blimbing', 7, 20),
('RTE006', 'Dau', 'Karangploso', 12, 30),
('RTE007', 'Singosari', 'Tumpang', 15, 40),
('RTE008', 'Pakis', 'Poncokusumo', 10, 30),
('RTE009', 'Pujon', 'Ngantang', 8, 25),
('RTE010', 'Sumberpucung', 'Pagelaran', 12, 30),
('RTE011', 'Tajinan', 'Tumpang', 10, 28),
('RTE012', 'Jabung', 'Kalipare', 15, 35),
('RTE013', 'Sawojajar', 'Blimbing', 5, 15),
('RTE014', 'Tirtoyudo', 'Tumpang', 18, 40),
('RTE015', 'Karanglo', 'Ngantang', 10, 25),
('RTE016', 'Bantur', 'Pakis', 7, 20),
('RTE017', 'Kasembon', 'Singosari', 14, 35),
('RTE018', 'Dampit', 'Pagelaran', 9, 25),
('RTE019', 'Pakisaji', 'Wagir', 6, 18),
('RTE020', 'Singosari', 'Lawang', 8, 22),
('RTE021', 'Gondanglegi', 'Pakis', 12, 30),
('RTE022', 'Blimbing', 'Klojen', 5, 15),
('RTE023', 'Klojen', 'Lowokwaru', 4, 12),
('RTE024', 'Lowokwaru', 'Sukun', 6, 18),
('RTE025', 'Sukun', 'Dinoyo', 7, 20),
('RTE026', 'Dinoyo', 'Wagir', 10, 25),
('RTE027', 'Wagir', 'Pakisaji', 8, 22),
('RTE028', 'Pakisaji', 'Dampit', 5, 15),
('RTE029', 'Dampit', 'Gondanglegi', 7, 20),
('RTE030', 'Gondanglegi', 'Kasembon', 9, 25),
('RTE031', 'Kasembon', 'Pujon', 10, 28),
('RTE032', 'Pujon', 'Tajinan', 12, 30),
('RTE033', 'Tajinan', 'Jabung', 14, 35),
('RTE034', 'Jabung', 'Tirtoyudo', 15, 38),
('RTE035', 'Tirtoyudo', 'Karanglo', 18, 40),
('RTE036', 'Karanglo', 'Bantur', 10, 25),
('RTE037', 'Bantur', 'Kasembon', 15, 35),
('RTE038', 'Kasembon', 'Dampit', 8, 22),
('RTE039', 'Dampit', 'Pakisaji', 6, 18),
('RTE040', 'Pakisaji', 'Singosari', 5, 15),
('RTE041', 'Singosari', 'Lawang', 7, 20),
('RTE042', 'Lawang', 'Gondanglegi', 9, 25),
('RTE043', 'Gondanglegi', 'Pakis', 10, 28),
('RTE044', 'Pakis', 'Tirtoyudo', 12, 30),
('RTE045', 'Tirtoyudo', 'Pujon', 14, 35),
('RTE046', 'Pujon', 'Jabung', 16, 38),
('RTE047', 'Jabung', 'Tajinan', 18, 40),
('RTE048', 'Tajinan', 'Sumberpucung', 20, 45),
('RTE049', 'Sumberpucung', 'Pakisaji', 22, 50),
('RTE050', 'Pakisaji', 'Tumpang', 25, 55),
('RTE051', 'Tumpang', 'Kalipare', 28, 60),
('RTE052', 'Kalipare', 'Blimbing', 30, 65),
('RTE053', 'Blimbing', 'Tirtoyudo', 32, 70),
('RTE054', 'Tirtoyudo', 'Pujon', 35, 75);

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE `schedule` (
  `schedule_id` varchar(7) NOT NULL CHECK (`schedule_id` regexp 'SCH[0-9][0-9][0-9]'),
  `vehicle_id` varchar(7) DEFAULT NULL CHECK (`vehicle_id` regexp 'VHC[0-9][0-9][0-9]'),
  `route_id` varchar(7) DEFAULT NULL CHECK (`route_id` regexp 'RTE[0-9][0-9][0-9]'),
  `departure_time` time NOT NULL,
  `arrival_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`schedule_id`, `vehicle_id`, `route_id`, `departure_time`, `arrival_time`) VALUES
('SCH001', 'VHC001', 'RTE001', '08:00:00', '11:00:00'),
('SCH002', 'VHC002', 'RTE002', '09:00:00', '11:00:00'),
('SCH003', 'VHC003', 'RTE003', '10:00:00', '15:00:00'),
('SCH004', 'VHC004', 'RTE004', '08:30:00', '09:15:00'),
('SCH005', 'VHC005', 'RTE005', '10:00:00', '10:45:00'),
('SCH006', 'VHC006', 'RTE006', '12:00:00', '13:00:00'),
('SCH007', 'VHC007', 'RTE007', '14:00:00', '15:30:00'),
('SCH008', 'VHC008', 'RTE008', '16:00:00', '16:45:00'),
('SCH009', 'VHC009', 'RTE009', '08:30:00', '09:30:00'),
('SCH010', 'VHC010', 'RTE010', '09:00:00', '11:00:00'),
('SCH011', 'VHC011', 'RTE011', '10:30:00', '12:30:00'),
('SCH012', 'VHC012', 'RTE012', '11:00:00', '13:00:00'),
('SCH013', 'VHC013', 'RTE013', '12:30:00', '14:30:00'),
('SCH014', 'VHC014', 'RTE014', '13:00:00', '15:00:00'),
('SCH015', 'VHC015', 'RTE015', '14:30:00', '16:30:00'),
('SCH016', 'VHC016', 'RTE016', '15:00:00', '17:00:00'),
('SCH017', 'VHC017', 'RTE017', '16:30:00', '18:30:00'),
('SCH018', 'VHC009', 'RTE018', '17:00:00', '19:00:00'),
('SCH019', 'VHC010', 'RTE019', '18:30:00', '20:30:00'),
('SCH020', 'VHC011', 'RTE020', '19:00:00', '21:00:00'),
('SCH021', 'VHC012', 'RTE021', '20:30:00', '22:30:00'),
('SCH022', 'VHC013', 'RTE022', '21:00:00', '23:00:00'),
('SCH023', 'VHC014', 'RTE023', '22:30:00', '00:30:00'),
('SCH024', 'VHC015', 'RTE024', '23:00:00', '01:00:00'),
('SCH025', 'VHC016', 'RTE025', '08:30:00', '10:30:00'),
('SCH026', 'VHC017', 'RTE026', '09:00:00', '11:00:00'),
('SCH027', 'VHC009', 'RTE027', '10:30:00', '12:30:00'),
('SCH028', 'VHC010', 'RTE028', '11:00:00', '13:00:00'),
('SCH029', 'VHC011', 'RTE029', '12:30:00', '14:30:00'),
('SCH030', 'VHC012', 'RTE030', '13:00:00', '15:00:00'),
('SCH031', 'VHC013', 'RTE031', '14:30:00', '16:30:00'),
('SCH032', 'VHC014', 'RTE032', '15:00:00', '17:00:00'),
('SCH033', 'VHC015', 'RTE033', '16:30:00', '18:30:00'),
('SCH034', 'VHC016', 'RTE034', '17:00:00', '19:00:00'),
('SCH035', 'VHC017', 'RTE035', '18:30:00', '20:30:00'),
('SCH036', 'VHC009', 'RTE036', '19:00:00', '21:00:00'),
('SCH037', 'VHC010', 'RTE037', '20:30:00', '22:30:00'),
('SCH038', 'VHC011', 'RTE038', '21:00:00', '23:00:00'),
('SCH039', 'VHC012', 'RTE039', '22:30:00', '00:30:00'),
('SCH040', 'VHC013', 'RTE040', '23:00:00', '01:00:00'),
('SCH041', 'VHC014', 'RTE041', '08:30:00', '10:30:00'),
('SCH042', 'VHC015', 'RTE042', '09:00:00', '11:00:00'),
('SCH043', 'VHC016', 'RTE043', '10:30:00', '12:30:00'),
('SCH044', 'VHC017', 'RTE044', '11:00:00', '13:00:00'),
('SCH045', 'VHC009', 'RTE045', '12:30:00', '14:30:00'),
('SCH046', 'VHC010', 'RTE046', '13:00:00', '15:00:00'),
('SCH047', 'VHC011', 'RTE047', '14:30:00', '16:30:00'),
('SCH048', 'VHC012', 'RTE048', '15:00:00', '17:00:00'),
('SCH049', 'VHC013', 'RTE049', '16:30:00', '18:30:00'),
('SCH050', 'VHC014', 'RTE050', '17:00:00', '19:00:00'),
('SCH051', 'VHC015', 'RTE051', '18:30:00', '20:30:00'),
('SCH052', 'VHC016', 'RTE052', '19:00:00', '21:00:00'),
('SCH053', 'VHC017', 'RTE053', '20:30:00', '22:30:00'),
('SCH054', 'VHC009', 'RTE054', '21:00:00', '23:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle`
--

CREATE TABLE `vehicle` (
  `vehicle_id` varchar(7) NOT NULL CHECK (`vehicle_id` regexp 'VHC[0-9][0-9][0-9]'),
  `vehicle_type` varchar(50) NOT NULL,
  `brand` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `year` year(4) NOT NULL,
  `capacity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vehicle`
--

INSERT INTO `vehicle` (`vehicle_id`, `vehicle_type`, `brand`, `model`, `year`, `capacity`) VALUES
('VHC001', 'Car', 'Volvo', 'S60', '2015', 5),
('VHC002', 'Car', 'Toyota', 'Corolla', '2018', 5),
('VHC003', 'Motorcycle', 'Honda', 'CB150R', '2020', 2),
('VHC004', 'Car', 'Honda', 'Civic', '2019', 4),
('VHC005', 'Motorcycle', 'Yamaha', 'NMAX', '2021', 2),
('VHC006', 'Car', 'Toyota', 'Avanza', '2020', 6),
('VHC007', 'Car', 'Mitsubishi', 'Xpander', '2022', 6),
('VHC008', 'Motorcycle', 'Suzuki', 'GSX-R150', '2021', 2),
('VHC009', 'Car', 'Honda', 'Civic', '2019', 5),
('VHC010', 'Motorcycle', 'Yamaha', 'NMAX', '2021', 2),
('VHC011', 'Car', 'Toyota', 'Camry', '2020', 5),
('VHC012', 'Motorcycle', 'Suzuki', 'GSX-R150', '2022', 2),
('VHC013', 'Car', 'Mitsubishi', 'Outlander', '2018', 7),
('VHC014', 'Motorcycle', 'Kawasaki', 'Ninja 250', '2020', 2),
('VHC015', 'Car', 'Hyundai', 'Elantra', '2022', 5),
('VHC016', 'Motorcycle', 'BMW', 'S1000RR', '2021', 2),
('VHC017', 'Car', 'Ford', 'Focus', '2017', 5);

-- --------------------------------------------------------

--
-- Structure for view `confirmed_booking`
--
DROP TABLE IF EXISTS `confirmed_booking`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `confirmed_booking`  AS SELECT `d`.`name` AS `Nama Pengemudi`, `d`.`license_number` AS `Nomor Lisensi Pengemudi`, `p`.`name` AS `Nama Penumpang`, `r`.`start_location` AS `Keberangkatan`, `r`.`end_location` AS `Tujuan`, `b`.`status` AS `Status` FROM ((((`booking` `b` join `passenger` `p` on(`p`.`passenger_id` = `b`.`passenger_id`)) join `driver` `d` on(`d`.`driver_id` = `b`.`driver_id`)) join `schedule` `s` on(`b`.`schedule_id` = `s`.`schedule_id`)) join `route` `r` on(`r`.`route_id` = `s`.`route_id`)) WHERE `b`.`status` = 'Confirmed' ;

-- --------------------------------------------------------

--
-- Structure for view `confirmed_bookings`
--
DROP TABLE IF EXISTS `confirmed_bookings`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `confirmed_bookings`  AS SELECT `d`.`name` AS `Nama Pengemudi`, `d`.`license_number` AS `Nomor Lisensi Pengemudi`, `p`.`name` AS `Nama Penumpang`, `r`.`start_location` AS `Keberangkatan`, `r`.`end_location` AS `Tujuan`, `b`.`status` AS `Status` FROM ((((`booking` `b` join `passenger` `p` on(`p`.`passenger_id` = `b`.`passenger_id`)) join `driver` `d` on(`d`.`driver_id` = `b`.`driver_id`)) join `schedule` `s` on(`b`.`schedule_id` = `s`.`schedule_id`)) join `route` `r` on(`r`.`route_id` = `s`.`route_id`)) WHERE `b`.`status` = 'Confirmed' ;

-- --------------------------------------------------------

--
-- Structure for view `contact_driver`
--
DROP TABLE IF EXISTS `contact_driver`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `contact_driver`  AS SELECT `driver`.`name` AS `Nama Pengemudi`, `driver`.`contact_number` AS `Kontak Pengemudi` FROM `driver` ;

-- --------------------------------------------------------

--
-- Structure for view `contact_passenger`
--
DROP TABLE IF EXISTS `contact_passenger`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `contact_passenger`  AS SELECT `passenger`.`name` AS `Nama Penumpang`, `passenger`.`contact_number` AS `Kontak Penumpang` FROM `passenger` ;

-- --------------------------------------------------------

--
-- Structure for view `list_drivers`
--
DROP TABLE IF EXISTS `list_drivers`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `list_drivers`  AS SELECT `driver`.`name` AS `Nama Pengemudi`, `driver`.`license_number` AS `Nomor Lisensi Pengemudi` FROM `driver` ;

-- --------------------------------------------------------

--
-- Structure for view `pending_bookings`
--
DROP TABLE IF EXISTS `pending_bookings`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pending_bookings`  AS SELECT `d`.`name` AS `Nama Pengemudi`, `d`.`license_number` AS `Nomor Lisensi Pengemudi`, `p`.`name` AS `Nama Penumpang`, `r`.`start_location` AS `Keberangkatan`, `r`.`end_location` AS `Tujuan`, `b`.`status` AS `Status` FROM ((((`booking` `b` join `passenger` `p` on(`p`.`passenger_id` = `b`.`passenger_id`)) join `driver` `d` on(`d`.`driver_id` = `b`.`driver_id`)) join `schedule` `s` on(`b`.`schedule_id` = `s`.`schedule_id`)) join `route` `r` on(`r`.`route_id` = `s`.`route_id`)) WHERE `b`.`status` = 'Pending' ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `driver_id` (`driver_id`),
  ADD KEY `passenger_id` (`passenger_id`),
  ADD KEY `schedule_id` (`schedule_id`);

--
-- Indexes for table `driver`
--
ALTER TABLE `driver`
  ADD PRIMARY KEY (`driver_id`);

--
-- Indexes for table `passenger`
--
ALTER TABLE `passenger`
  ADD PRIMARY KEY (`passenger_id`);

--
-- Indexes for table `price`
--
ALTER TABLE `price`
  ADD PRIMARY KEY (`price_id`),
  ADD KEY `route_id` (`route_id`);

--
-- Indexes for table `route`
--
ALTER TABLE `route`
  ADD PRIMARY KEY (`route_id`);

--
-- Indexes for table `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`schedule_id`),
  ADD KEY `vehicle_id` (`vehicle_id`),
  ADD KEY `route_id` (`route_id`);

--
-- Indexes for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD PRIMARY KEY (`vehicle_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`driver_id`) REFERENCES `driver` (`driver_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`passenger_id`) REFERENCES `passenger` (`passenger_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `booking_ibfk_3` FOREIGN KEY (`schedule_id`) REFERENCES `schedule` (`schedule_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `price`
--
ALTER TABLE `price`
  ADD CONSTRAINT `price_ibfk_1` FOREIGN KEY (`route_id`) REFERENCES `route` (`route_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`vehicle_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `schedule_ibfk_2` FOREIGN KEY (`route_id`) REFERENCES `route` (`route_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
