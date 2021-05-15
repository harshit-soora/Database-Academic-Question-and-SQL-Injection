-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 02, 2020 at 06:59 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `school`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `AID` int(11) NOT NULL,
  `ANAME` varchar(150) NOT NULL,
  `APASS` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`AID`);

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

CREATE TABLE `subject` (
  `SID` int(11) NOT NULL,
  `SNAME` varchar(150) NOT NULL,
  `STEACHER` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for table `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`SID`);

--
-- Dumping data for table `subject`
--

INSERT INTO `subject` (`SID`, `SNAME`, `STEACHER`) VALUES
(17, 'Economics', 'RamDas'),
(18, 'Biology', 'Pankaj Kumar'),
(19, 'EVS', 'Prakash Das'),
(20, 'Chemistry', 'Narendra Kok'),
(21, 'Chemistry', 'Kok'),
(22, 'DBMS', 'Shamik');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`) VALUES
(14, 'harshit', 'soora@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055'),
(15, 'sanju', 'soora.iitkgp@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b'),
(16, 'sanju123', 'soora123@gmail.com', '202cb962ac59075b964b07152d234b70'),
(17, 'ramdutt', 'soora321@gmail.com', '116fb69d6772952c80ad5f02f038393f'),
(18, 'iitkgp', 'iitkgp@ac.in', '9dc294ff36622cb3f41567890aa6d7f6'),
(19, 'anshul', 'anshul@gmail.com', 'd8578edf8458ce06fbc5bb76a58c5ca4'),
(20, 'Choudhary', 'chou@gmail.com', 'eb89f40da6a539dd1b1776e522459763'),
(21, 'admin', 'admin@gmail.com', '21232f297a57a5a743894a0e4a801fc3'),
(22, 'rakesh', 'rakesh@gmail.com', '116fb69d6772952c80ad5f02f038393f');

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `AID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;


--
-- AUTO_INCREMENT for table `subject`
--
ALTER TABLE `subject`
  MODIFY `SID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
