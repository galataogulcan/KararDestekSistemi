-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1:3306
-- Üretim Zamanı: 03 Şub 2021, 18:52:44
-- Sunucu sürümü: 5.7.31
-- PHP Sürümü: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `2017469021`
--

DELIMITER $$
--
-- Yordamlar
--
DROP PROCEDURE IF EXISTS `projeSoru1`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `projeSoru1` ()  NO SQL
SELECT iller.il_ad as il_adi, bolge.bolge_ad as bolge_Adi, iller.orman_yogunlugu_yuzde as orman_yogunlugu_yuzde FROM iller,bolge WHERE iller.bolge_id=bolge.bolge_id AND iller.orman_yogunlugu_yuzde=(SELECT MAX(iller.orman_yogunlugu_yuzde) FROM iller)$$

DROP PROCEDURE IF EXISTS `projeSoru2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `projeSoru2` ()  NO SQL
SELECT bolge.bolge_ad ,avg(iller.orman_yogunlugu_yuzde) as yogunluk FROM iller,bolge WHERE iller.bolge_id=bolge.bolge_id GROUP BY bolge.bolge_ad$$

DROP PROCEDURE IF EXISTS `projeSoru3`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `projeSoru3` ()  NO SQL
SELECT iller.il_id, iller.orman_yogunlugu_yuzde 
FROM iller$$

DROP PROCEDURE IF EXISTS `projeSoru4`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `projeSoru4` ()  NO SQL
SELECT turler.tur_ad as tur_adlari , COUNT(agac.tur_id) as agac_sayisi
        FROM agac,turler
        WHERE agac.tur_id=turler.tur_id
        GROUP BY turler.tur_id$$

DROP PROCEDURE IF EXISTS `projeSoru5`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `projeSoru5` ()  NO SQL
SELECT iller.il_id,iller.il_ad ,iller.yangin_derece 
FROM iller
ORDER BY iller.yangin_derece$$

DROP PROCEDURE IF EXISTS `projeSoru6`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `projeSoru6` ()  NO SQL
SELECT iller.il_ad as il_adlari,iller.orman_yogunlugu_yuzde as il_orman_yogunlugu_orani
        FROM iller
        ORDER BY iller.orman_yogunlugu_yuzde DESC
        LIMIT 10$$

DROP PROCEDURE IF EXISTS `projeSoru7`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `projeSoru7` ()  NO SQL
SELECT iller.il_ad as il_adlari,iller.orman_yogunlugu_yuzde as il_orman_yogunlugu_orani
        FROM iller
        ORDER BY iller.orman_yogunlugu_yuzde ASC
        LIMIT 10$$

DROP PROCEDURE IF EXISTS `projeSoru8`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `projeSoru8` ()  NO SQL
SELECT iller.il_ad,iller.orman_yogunlugu_yuzde as yuzde,iller.yangin_derece as derece
FROM iller
WHERE iller.orman_yogunlugu_yuzde>50 AND iller.yangin_derece>=2
ORDER BY iller.orman_yogunlugu_yuzde DESC$$

DROP PROCEDURE IF EXISTS `soru1`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `soru1` ()  NO SQL
SELECT iller.il_ad as il_adlari,iller.orman_yogunlugu_yuzde as il_orman_yogunlugu_orani
FROM iller
ORDER BY iller.orman_yogunlugu_yuzde$$

DROP PROCEDURE IF EXISTS `soru10`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `soru10` (IN `il` VARCHAR(50))  NO SQL
SELECT iller.il_ad,bolge.bolge_ad,iller.orman_yogunlugu_yuzde
FROM iller,bolge
WHERE iller.bolge_id=bolge.bolge_id 
AND iller.il_ad LIKE concat('%',il,'%')$$

DROP PROCEDURE IF EXISTS `soru2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `soru2` ()  NO SQL
SELECT iller.il_ad as il_adi, bolge.bolge_ad as bolge_Adi, iller.orman_yogunlugu_yuzde as orman_yogunlugu_yuzde
FROM iller,bolge
WHERE iller.bolge_id=bolge.bolge_id
AND iller.orman_yogunlugu_yuzde=(SELECT MAX(iller.orman_yogunlugu_yuzde) FROM iller)$$

DROP PROCEDURE IF EXISTS `soru3`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `soru3` ()  NO SQL
SELECT turler.tur_ad, COUNT(agac.tur_id) as agac_sayisi
FROM agac,turler
WHERE agac.tur_id=turler.tur_id
GROUP BY turler.tur_id$$

DROP PROCEDURE IF EXISTS `soru4`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `soru4` ()  NO SQL
SELECT turler.tur_ad,COUNT(agac.agac_id) as agac_sayisi
FROM agac,turler
WHERE agac.tur_id=turler.tur_id
GROUP by turler.tur_id
HAVING agac_sayisi>3$$

DROP PROCEDURE IF EXISTS `soru5`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `soru5` ()  NO SQL
SELECT bolge.bolge_ad ,avg(iller.orman_yogunlugu_yuzde) as yogunluk 
FROM iller,bolge 
WHERE iller.bolge_id=bolge.bolge_id 
GROUP BY bolge.bolge_ad
ORDER BY yogunluk DESC$$

DROP PROCEDURE IF EXISTS `soru6`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `soru6` (IN `agac` VARCHAR(50))  NO SQL
SELECT agac.agac_ad,sinif.sinif_ad,turler.tur_ad
FROM agac,turler,sinif
WHERE agac.tur_id=turler.tur_id AND
agac.sinif_id=sinif.sinif_id
AND agac.agac_ad LIKE concat('%',agac,'%')$$

DROP PROCEDURE IF EXISTS `soru7`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `soru7` (IN `bolge` VARCHAR(50))  NO SQL
SELECT bolge.bolge_ad,turler.tur_ad
FROM bolge LEFT JOIN orman_tur ON bolge.bolge_id=orman_tur.bolge_id 
LEFT JOIN turler on turler.tur_id=orman_tur.tur_id
WHERE bolge.bolge_ad LIKE concat('%',bolge,'%')$$

DROP PROCEDURE IF EXISTS `soru8`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `soru8` (IN `sinif` VARCHAR(50))  NO SQL
SELECT sinif.sinif_ad,agac.agac_ad
FROM agac,sinif
WHERE agac.sinif_id=sinif.sinif_id
AND sinif.sinif_ad LIKE concat('%',sinif,'%')$$

DROP PROCEDURE IF EXISTS `soru9`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `soru9` (IN `tur` VARCHAR(50))  NO SQL
SELECT turler.tur_ad,agac.agac_ad
FROM agac,turler
WHERE agac.tur_id=turler.tur_id
AND turler.tur_ad LIKE concat('%',tur,'%')$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `agac`
--

DROP TABLE IF EXISTS `agac`;
CREATE TABLE IF NOT EXISTS `agac` (
  `agac_id` int(11) NOT NULL,
  `agac_ad` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `sinif_id` int(1) DEFAULT NULL,
  `tur_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`agac_id`),
  KEY `sinif_id` (`sinif_id`),
  KEY `tur_id` (`tur_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `agac`
--

INSERT INTO `agac` (`agac_id`, `agac_ad`, `sinif_id`, `tur_id`) VALUES
(1, 'Çınar', 2, 1),
(2, 'Ardıç', 2, 1),
(3, 'Meşe', 2, 1),
(4, 'Göknar', 2, 1),
(5, 'Kayın', 2, 2),
(6, 'Karaçam', 2, 2),
(7, 'Diş Budak', 2, 2),
(8, 'Ladin', 1, 3),
(9, 'Ihlamur', 2, 4),
(10, 'Gürgen', 2, 3),
(11, 'Sarıçam', 1, 3),
(12, 'Kavak', 2, 2),
(13, 'Kestane', 2, 4),
(14, 'Sedir', 1, 2),
(15, 'Servi', 1, 2);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `bolge`
--

DROP TABLE IF EXISTS `bolge`;
CREATE TABLE IF NOT EXISTS `bolge` (
  `bolge_id` int(1) NOT NULL,
  `bolge_ad` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  PRIMARY KEY (`bolge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `bolge`
--

INSERT INTO `bolge` (`bolge_id`, `bolge_ad`) VALUES
(1, 'Marmara Bölgesi'),
(2, 'Ege Bölgesi'),
(3, 'Akdeniz Bölgesi'),
(4, 'Karadeniz Bölgesi'),
(5, 'İç Anadolu Bölgesi'),
(6, 'Doğu Anadolu Bölgesi'),
(7, 'Güneydoğu Anadolu Bölgesi');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `eskiyogunluk`
--

DROP TABLE IF EXISTS `eskiyogunluk`;
CREATE TABLE IF NOT EXISTS `eskiyogunluk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `il_ad` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `eskiYogunluk` int(2) NOT NULL,
  `yeniYogunluk` int(2) NOT NULL,
  `degistirilme` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `eskiyogunluk`
--

INSERT INTO `eskiyogunluk` (`id`, `il_ad`, `eskiYogunluk`, `yeniYogunluk`, `degistirilme`) VALUES
(1, 'Ağrı', 1, 5, '2021-02-03 17:28:02');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `iller`
--

DROP TABLE IF EXISTS `iller`;
CREATE TABLE IF NOT EXISTS `iller` (
  `il_id` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `il_ad` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `bolge_id` int(2) DEFAULT NULL,
  `orman_yogunlugu_yuzde` int(2) NOT NULL,
  `yangin_derece` int(11) NOT NULL,
  PRIMARY KEY (`il_id`),
  KEY `bolge_id` (`bolge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `iller`
--

INSERT INTO `iller` (`il_id`, `il_ad`, `bolge_id`, `orman_yogunlugu_yuzde`, `yangin_derece`) VALUES
('TR.AA', 'Adana', 3, 44, 1),
('TR.AD', 'Adıyaman', 7, 25, 3),
('TR.AF', 'Afyon', 2, 17, 1),
('TR.AG', 'Ağrı', 6, 5, 5),
('TR.AK', 'Aksaray', 5, 2, 4),
('TR.AL', 'Antalya', 3, 55, 1),
('TR.AM', 'Amasya', 4, 39, 2),
('TR.AN', 'Ankara', 5, 15, 2),
('TR.AR', 'Ardahan', 6, 6, 4),
('TR.AV', 'Artvin', 4, 54, 4),
('TR.AY', 'Aydın', 2, 39, 1),
('TR.BB', 'Bayburt', 4, 4, 5),
('TR.BC', 'Bilecik', 1, 55, 1),
('TR.BD', 'Burdur', 3, 48, 2),
('TR.BG', 'Bingöl', 6, 33, 2),
('TR.BK', 'Balıkesir', 1, 47, 1),
('TR.BL', 'Bolu', 4, 64, 3),
('TR.BM', 'Batman', 7, 17, 3),
('TR.BR', 'Bartın', 4, 55, 4),
('TR.BT', 'Bitlis', 6, 21, 4),
('TR.BU', 'Bursa', 1, 45, 1),
('TR.CI', 'Çankırı', 5, 25, 3),
('TR.CK', 'Çanakkale', 1, 53, 1),
('TR.CM', 'Çorum', 4, 33, 3),
('TR.DN', 'Denizli', 2, 47, 1),
('TR.DU', 'Düzce', 4, 50, 3),
('TR.DY', 'Diyarbakır', 6, 23, 3),
('TR.ED', 'Edirne', 1, 23, 2),
('TR.EG', 'Elazığ', 6, 23, 3),
('TR.EM', 'Erzurum', 6, 9, 5),
('TR.EN', 'Erzincan', 6, 15, 4),
('TR.ES', 'Eskişehir', 5, 24, 2),
('TR.GA', 'Gaziantep', 7, 12, 2),
('TR.GI', 'Giresun', 4, 35, 4),
('TR.GU', 'Gümüşhane', 4, 31, 5),
('TR.HK', 'Hakkari', 6, 31, 5),
('TR.HT', 'Hatay', 3, 39, 1),
('TR.IB', 'İstanbul', 1, 44, 1),
('TR.IC', 'İçel', 3, 54, 1),
('TR.IG', 'Iğdır', 6, 1, 5),
('TR.IP', 'Isparta', 3, 45, 2),
('TR.IZ', 'İzmir', 2, 40, 1),
('TR.KA', 'Kars', 6, 4, 5),
('TR.KB', 'Karabük', 4, 71, 2),
('TR.KC', 'Kocaeli', 1, 44, 1),
('TR.KH', 'Kırşehir', 5, 4, 3),
('TR.KI', 'Kilis', 7, 15, 2),
('TR.KK', 'Kırıkkale', 5, 12, 3),
('TR.KL', 'Kırklareli', 1, 40, 2),
('TR.KM', 'Kahramanmaraş', 3, 35, 2),
('TR.KO', 'Konya', 5, 13, 3),
('TR.KR', 'Karaman', 5, 28, 3),
('TR.KS', 'Kastamonu', 4, 65, 3),
('TR.KU', 'Kütahya', 2, 53, 1),
('TR.KY', 'Kayseri', 5, 6, 3),
('TR.MG', 'Muğla', 2, 68, 1),
('TR.ML', 'Malatya', 6, 15, 4),
('TR.MN', 'Manisa', 2, 41, 1),
('TR.MR', 'Mardin', 7, 15, 4),
('TR.MS', 'Muş', 6, 8, 4),
('TR.NG', 'Niğde', 5, 8, 3),
('TR.NV', 'Nevşehir', 5, 1, 5),
('TR.OR', 'Ordu', 4, 33, 4),
('TR.OS', 'Osmaniye', 3, 48, 2),
('TR.RI', 'Rize', 4, 50, 5),
('TR.SI', 'Siirt', 7, 35, 3),
('TR.SK', 'Sakarya', 1, 42, 2),
('TR.SP', 'Sinop', 4, 36, 2),
('TR.SR', 'Şırnak', 6, 36, 3),
('TR.SS', 'Samsun', 4, 38, 4),
('TR.SU', 'Şanlıurfa', 7, 1, 4),
('TR.SV', 'Sivas', 4, 17, 5),
('TR.TB', 'Trabzon', 4, 27, 5),
('TR.TC', 'Tunceli', 6, 37, 4),
('TR.TG', 'Tekirdağ', 1, 41, 2),
('TR.TT', 'Tokat', 4, 37, 3),
('TR.US', 'Uşak', 2, 40, 1),
('TR.VA', 'Van', 6, 1, 5),
('TR.YL', 'Yalova', 1, 59, 1),
('TR.YZ', 'Yozgat', 5, 16, 3),
('TR.ZO', 'Zonguldak', 4, 59, 4);

--
-- Tetikleyiciler `iller`
--
DROP TRIGGER IF EXISTS `yogunluk_guncelleme`;
DELIMITER $$
CREATE TRIGGER `yogunluk_guncelleme` AFTER UPDATE ON `iller` FOR EACH ROW BEGIN
    IF OLD.orman_yogunlugu_yuzde <> new.orman_yogunlugu_yuzde THEN
        INSERT INTO eskiyogunluk(il_ad,eskiYogunluk, yeniYogunluk)
        VALUES(old.il_ad, old.orman_yogunlugu_yuzde, new.orman_yogunlugu_yuzde);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `orman_tur`
--

DROP TABLE IF EXISTS `orman_tur`;
CREATE TABLE IF NOT EXISTS `orman_tur` (
  `bolge_id` int(1) NOT NULL,
  `tur_id` int(11) DEFAULT NULL,
  KEY `il_id` (`bolge_id`),
  KEY `tur_id` (`tur_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `orman_tur`
--

INSERT INTO `orman_tur` (`bolge_id`, `tur_id`) VALUES
(3, 2),
(2, 2),
(4, 2),
(1, 1),
(7, NULL),
(6, NULL),
(5, NULL);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `sinif`
--

DROP TABLE IF EXISTS `sinif`;
CREATE TABLE IF NOT EXISTS `sinif` (
  `sinif_id` int(1) NOT NULL,
  `sinif_ad` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  PRIMARY KEY (`sinif_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `sinif`
--

INSERT INTO `sinif` (`sinif_id`, `sinif_ad`) VALUES
(1, 'İbreli Ağaçlar'),
(2, 'Geniş Yapraklı Ağaçlar');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `turler`
--

DROP TABLE IF EXISTS `turler`;
CREATE TABLE IF NOT EXISTS `turler` (
  `tur_id` int(11) NOT NULL,
  `tur_ad` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  PRIMARY KEY (`tur_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `turler`
--

INSERT INTO `turler` (`tur_id`, `tur_ad`) VALUES
(1, 'Çok Sert Ağaçlar'),
(2, 'Sert Ağaçlar'),
(3, 'Yumuşak Ağaçlar'),
(4, 'Çok Yumuşak Ağaçlar');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `yonetici`
--

DROP TABLE IF EXISTS `yonetici`;
CREATE TABLE IF NOT EXISTS `yonetici` (
  `eposta` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `sifre` varchar(50) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `yonetici`
--

INSERT INTO `yonetici` (`eposta`, `sifre`) VALUES
('yonetici@yonetici.com', '1234');

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `agac`
--
ALTER TABLE `agac`
  ADD CONSTRAINT `agac_ibfk_1` FOREIGN KEY (`sinif_id`) REFERENCES `sinif` (`sinif_id`),
  ADD CONSTRAINT `agac_ibfk_2` FOREIGN KEY (`tur_id`) REFERENCES `turler` (`tur_id`);

--
-- Tablo kısıtlamaları `iller`
--
ALTER TABLE `iller`
  ADD CONSTRAINT `iller_ibfk_1` FOREIGN KEY (`bolge_id`) REFERENCES `bolge` (`bolge_id`);

--
-- Tablo kısıtlamaları `orman_tur`
--
ALTER TABLE `orman_tur`
  ADD CONSTRAINT `bolge_kisiti` FOREIGN KEY (`bolge_id`) REFERENCES `bolge` (`bolge_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tur_kisiti` FOREIGN KEY (`tur_id`) REFERENCES `turler` (`tur_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
