-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 12, 2015 at 08:03 AM
-- Server version: 5.6.27-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `psytrancr`
--

-- --------------------------------------------------------

--
-- Table structure for table `artists`
--

CREATE TABLE IF NOT EXISTS `artists` (
  `artist` varchar(60) NOT NULL,
  `artist_link` varchar(120) NOT NULL,
  `artist_img` text NOT NULL,
  `event_id` int(11) NOT NULL,
  UNIQUE KEY `artist` (`artist`),
  KEY `event_id` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `artists`
--

INSERT INTO `artists` (`artist`, `artist_link`, `artist_img`, `event_id`) VALUES
('Chromatone (USA)', 'https://soundcloud.com/chromatone_psy', '/static/img/sprung/chromatone.jpg', 2),
('E-Clip (SRB)', 'https://soundcloud.com/e-clip', '/static/img/sprung/e-clip.jpg', 2),
('Earthling (ESP)', 'https://soundcloud.com/earthling', '/static/img/sprung/earthling.jpg', 2),
('Earthspace (BRA)', 'https://soundcloud.com/earthspacelive', '/static/img/earthdance/earthspace.jpg', 3),
('Everblast (USA, ESP)', 'https://soundcloud.com/everblast', '/static/img/sprung/everblast.jpg', 2),
('K.I.M. (UK)', 'https://soundcloud.com/joakimfogelmark', '/static/img/sprung/kim.jpg', 2),
('Lifeforms (ISR)', 'http://soundcloud.com/lifeformsmusic', '/static/img/earthdance/lifeforms.jpg', 3),
('Vini Vici (ISR)', 'https://soundcloud.com/vinivicimusic', '/static/img/gaianDream/vinivici.jpg', 4),
('Virtual Light (CAN)', 'https://soundcloud.com/virtual-light', '/static/img/earthdance/virtuallight.jpg', 3);

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE IF NOT EXISTS `events` (
  `event_id` int(11) NOT NULL,
  `event_name` varchar(120) NOT NULL,
  `img_url` varchar(60) NOT NULL,
  `cover_url` varchar(120) NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `venue` varchar(60) NOT NULL,
  `about` text NOT NULL,
  PRIMARY KEY (`event_id`),
  UNIQUE KEY `event_id` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`event_id`, `event_name`, `img_url`, `cover_url`, `startDate`, `endDate`, `venue`, `about`) VALUES
(2, 'Sprung', '/static/img/sprung/party2.jpg', '/static/img/sprung/sprung_cover.png', '2015-09-05', '2015-09-06', 'All Starr Arena Silwerstroom Resort', 'A celebration of spring, a weekend of enchantment, brighten your hearts, journey into possibilities. An event of playful abandon for all urban rebels and merry pranksters - Get On The Bus - Always Further .'),
(3, 'Earthdance', '/static/img/earthdance/party3.jpg', '/static/img/earthdance/earthdance_cover.jpg', '2015-09-19', '2015-09-20', 'Nekkies Resort Worcester', 'As part of the global Earthdance family we have grown Earthdance Cape Town into one of the most forward thinking, musically exciting, and socially uplifting events Cape Town see’s each year.'),
(4, 'Gaian Dream', '/static/img/gaianDream/party4.png', '/static/img/gaianDream/gaianDream_cover.png', '2015-10-16', '2015-10-18', 'The Wood Between the Worlds', 'To celebrate 5 years of (Gaian) Dreaming we have decided to add another night onto this festival - giving you a full weekend of the best psytrance from around the world!\n\nFind the peace to free your mind. Find the balance in nature''s garden. Come together as one. Our history is a Gaian Dream.'),
(5, 'Vortex Open Source', '/static/img/vortex/party5.jpg', '/static/img/vortex/vortex_cover.jpg', '2015-12-03', '2015-12-07', 'Riviersonderend (Endless River), Cape Town', 'Summer is here, bringing a NEW season of fresh Beginnings & Adventures A New Season of Peace, Love, Unity and Respect. Feel the grass beneath your feet, breathe the fresh clear air, feel the sun upon your skin, hear the tears of joy & laughter, let the deep rumble of the bass match the rhythm of your heart, let the music carry your soul. Open your mind& soul to embrace the beauty that is the Circle of Dreams. So many words to describe it but only those who experience it, will truly understand.'),
(6, 'Village: The Gathering', '/static/img/village/party6.jpg', '/static/img/village/village_cover.png', '2015-08-10', '2015-08-11', 'Guinevere Guest Farm, Tulbach, Western Cape', 'The Village family extends a warm welcome to the NEW Land of Wandering Dreams.As winter passes & another sun kissed South African summer creeps ever closer, we beckon your rejuvenated energy, broad smiles & the thump of tribal dance as we unite under the African sky once more. This is set to be a family gathering like never before. We gather to celebrate friends, family & the essence of GEES! ');

-- --------------------------------------------------------

--
-- Table structure for table `links`
--

CREATE TABLE IF NOT EXISTS `links` (
  `event_id` int(11) NOT NULL,
  `facebook` varchar(120) NOT NULL,
  `tickets` text NOT NULL,
  `video` text NOT NULL,
  UNIQUE KEY `event_id_2` (`event_id`),
  KEY `event_id` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `links`
--

INSERT INTO `links` (`event_id`, `facebook`, `tickets`, `video`) VALUES
(2, 'https://www.facebook.com/events/838719146217246/', 'http://www.quicket.co.za/events/10636-alien-safari-sprung-2015#/', 'https://www.youtube.com/embed/cwh0JnFb0Sk'),
(3, 'https://www.facebook.com/earthdanceCapeTown?fref=ts', 'http://www.quicket.co.za/events/10734-earthdance-cape-town-2015/#/', 'https://www.youtube.com/embed/Avp4HU447Es'),
(4, 'https://www.facebook.com/events/1034944653184525/', 'https://www.quicket.co.za/events/11326-organik-gaian-dream-2015/#/', 'https://www.youtube.com/embed/B6A8REtikYM'),
(5, 'https://www.facebook.com/events/699045023573986/', 'https://www.quicket.co.za/events/9870-vortex-open-source-03-07-december-2015/#/', 'https://www.youtube.com/embed/fvaosOIlUNo'),
(6, 'https://www.facebook.com/events/409257319264105/', 'thevillage.tickets@gmail.com', 'https://www.youtube.com/embed/D6h-ehFGkh0');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `username` varchar(20) NOT NULL,
  `email` varchar(60) NOT NULL,
  `password` varchar(60) NOT NULL,
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`username`, `email`, `password`) VALUES
('aya', 'abqwabi@gmail.com', '$2a$10$wq6N1mGF75LTVUtDrExB2uOehVZsFq8Qrs487KQS6b1kiBodTEzO6'),
('obiwan', 'taariq@projectcodex.co', '$2a$10$pBopcov5QoT74gFvRNasR.Vv4UzvewDvdwQO37vrwMXSevTEtAmfG');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
