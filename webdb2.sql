-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Lug 19, 2025 alle 00:11
-- Versione del server: 10.4.32-MariaDB
-- Versione PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `webdb2`
--

DELIMITER $$
--
-- Funzioni
--
CREATE DEFINER=`root`@`localhost` FUNCTION `generate_codice` () RETURNS CHAR(10) CHARSET utf8mb4 COLLATE utf8mb4_general_ci DETERMINISTIC BEGIN
    DECLARE chars CHAR(62) DEFAULT 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    DECLARE result CHAR(10) DEFAULT '';
    DECLARE i INT DEFAULT 0;

    WHILE i < 10 DO
        SET result = CONCAT(result, SUBSTRING(chars, FLOOR(1 + RAND() * 62), 1));
        SET i = i + 1;
    END WHILE;

    RETURN result;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `caratteristica`
--

CREATE TABLE `caratteristica` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `version` bigint(20) UNSIGNED NOT NULL DEFAULT 1,
  `categoria_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `caratteristica`
--

INSERT INTO `caratteristica` (`id`, `nome`, `version`, `categoria_id`) VALUES
(9, 'Genere', 1, 11),
(10, 'Numero di pagine ', 1, 11),
(11, 'RAM', 1, 24),
(12, 'Spazio di archiviazione', 1, 24),
(13, 'Pollici display', 1, 25),
(14, 'RAM', 1, 25),
(15, 'Spazio di archiviazione', 1, 25),
(16, 'Tipo di tasti', 1, 29),
(17, 'Wirless', 1, 29),
(18, 'Wirless', 1, 30),
(19, 'DPI desiderati', 1, 30),
(20, 'Dimensione', 1, 34),
(21, 'Marca', 1, 34),
(22, 'Dimensione', 1, 33),
(23, 'Memoria', 1, 33),
(24, 'Megapixel', 1, 17),
(25, 'Capacità', 1, 36),
(26, 'Tipo di porta', 1, 36),
(27, 'Tipo di apertura', 1, 35),
(28, 'Classe energetica', 1, 35),
(29, 'Capacità di carico', 1, 37),
(30, 'Con asciugatrice', 1, 37),
(31, 'Materiale', 1, 21),
(32, 'Dimensione', 1, 21),
(33, 'Colore', 1, 21),
(34, 'Tipologia illuminazione', 1, 22),
(35, 'Tipo di colore', 1, 22),
(36, 'Dimensione', 1, 23);

-- --------------------------------------------------------

--
-- Struttura della tabella `caratteristica_richiesta`
--

CREATE TABLE `caratteristica_richiesta` (
  `id` int(11) NOT NULL,
  `richiesta` int(11) NOT NULL,
  `caratteristica` int(11) NOT NULL,
  `valore` varchar(200) NOT NULL DEFAULT 'undefined',
  `version` bigint(20) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `caratteristica_richiesta`
--

INSERT INTO `caratteristica_richiesta` (`id`, `richiesta`, `caratteristica`, `valore`, `version`) VALUES
(29, 22, 28, 'A+', 1),
(30, 23, 9, 'cult', 1),
(31, 24, 34, 'led', 1),
(32, 24, 35, 'rossi', 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `categoria`
--

CREATE TABLE `categoria` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `version` bigint(20) UNSIGNED NOT NULL DEFAULT 1,
  `padre` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `categoria`
--

INSERT INTO `categoria` (`id`, `nome`, `version`, `padre`) VALUES
(1, 'Elettronica', 1, NULL),
(9, 'Elettrodomestici', 1, NULL),
(10, 'Arredamento & design', 1, NULL),
(11, 'Libri', 1, NULL),
(14, 'Computer e accessori', 1, 1),
(15, 'Telefonia ', 1, 1),
(17, 'Fotografia ', 1, 1),
(18, 'Cucina', 1, 9),
(19, 'Lavanderia', 1, 9),
(21, 'Mobili', 1, 10),
(22, 'Illuminazione', 1, 10),
(23, 'Elementi decorativi', 1, 10),
(24, 'Pc desktop', 1, 14),
(25, 'Pc laptop', 1, 14),
(27, 'Accessori per pc', 1, 14),
(28, 'Monitor', 1, 27),
(29, 'Tastiera', 1, 27),
(30, 'Mouse', 1, 27),
(33, 'Tablet', 1, 15),
(34, 'Smartphone', 1, 15),
(35, 'Frigoriferi', 1, 18),
(36, 'Lavastoviglie', 1, 18),
(37, 'Lavatrice', 1, 19);

-- --------------------------------------------------------

--
-- Struttura della tabella `ordine`
--

CREATE TABLE `ordine` (
  `id` int(11) NOT NULL,
  `data` date DEFAULT NULL,
  `stato` enum('IN_ATTESA','ACCETTATO','RESPINTO_NON_CONFORME','RESPINTO_NON_FUNZIONANTE','RIFIUTATO') NOT NULL,
  `version` bigint(20) UNSIGNED NOT NULL DEFAULT 1,
  `proposta_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `ordine`
--

INSERT INTO `ordine` (`id`, `data`, `stato`, `version`, `proposta_id`) VALUES
(14, '2025-07-17', 'ACCETTATO', 2, 22),
(15, '2025-07-18', 'ACCETTATO', 2, 25),
(16, '2025-07-18', 'RESPINTO_NON_CONFORME', 2, 23);

-- --------------------------------------------------------

--
-- Struttura della tabella `proposta`
--

CREATE TABLE `proposta` (
  `id` int(11) NOT NULL,
  `produttore` varchar(500) NOT NULL,
  `prodotto` varchar(500) NOT NULL,
  `codice` varchar(500) NOT NULL,
  `codice_prodotto` varchar(50) NOT NULL,
  `prezzo` float NOT NULL,
  `URL` text NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `stato` enum('ACCETTATO','RIFIUTATO','IN_ATTESA','ORDINATO') NOT NULL,
  `data` date DEFAULT NULL,
  `motivazione` text DEFAULT NULL,
  `version` bigint(20) UNSIGNED NOT NULL DEFAULT 1,
  `richiesta_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `proposta`
--

INSERT INTO `proposta` (`id`, `produttore`, `prodotto`, `codice`, `codice_prodotto`, `prezzo`, `URL`, `note`, `stato`, `data`, `motivazione`, `version`, `richiesta_id`) VALUES
(22, 'aaaaa', 'aaaa', 'apEXnDYz4E', '24353', 389.99, 'https://a', NULL, 'ORDINATO', '2025-07-17', NULL, 3, 22),
(23, 'feltrinelli', 'libro harry', '3uFJgJNmca', '647363', 9.5, 'https://www.lafeltrinelli.it/harry-potter-pietra-filosofale-nuova-libro-j-k-rowling/e/9788831003384?gad_source=1&gad_campaignid=17340401260&gbraid=0AAAAAD-Pe5xGox0XnyaZ2re_aJqp5SmoF&gclid=CjwKCAjwvuLDBhAOEiwAPtF0VnW_He-9DOAv9668t7a26HBEq3Jn2sfSHfdhRuv6l8F4-l73-jBN3RoCxS8QAvD_BwE', NULL, 'ORDINATO', '2025-07-18', NULL, 3, 23),
(24, 'lav', 'lavatrice toooop', 'o9AFZwp83j', '6276782', 299, 'https://www.google.com/aclk?sa=l&ai=DChsSEwjb-57Pw8aOAxUcl1AGHR2dLyUYACICCAEQKxoCZGc&co=1&ase=2&gclid=CjwKCAjw4efDBhATEiwAaDBpbnRWSFvx6jnW9n3lBsvBFzjGzi-EKgIILj3vTt9zz2eMTXexy5yfpRoCIrIQAvD_BwE&category=acrcp_v1_53&sig=AOD64_0RQ801A1e-6MQAaA32RjimFgk1Lg&ctype=5&q=&nis=4&ved=2ahUKEwjunZrPw8aOAxVNTUEAHcBgO3YQ9aACKAB6BAgKEBQ&adurl=', 'lavatrice molto buona', 'IN_ATTESA', '2025-07-18', NULL, 1, 25),
(25, 'lavatutto', 'lavastoviglie top', 'cwibiaeIQ2', '11111', 265, 'https://www.google.com/aclk?sa=l&ai=DChsSEwjVrrekoMeOAxX1llAGHYngAGIYACICCAEQIxoCZGc&co=1&ase=2&gclid=CjwKCAjw4efDBhATEiwAaDBpbgHbe70mj0BU745RkjVrCqGblqM1MRsaajsCf2XR1szypl1nCQrVuRoCjzoQAvD_BwE&category=acrcp_v1_48&sig=AOD64_3kYYiZdupk3oQC9i9aARtnc_14mQ&ctype=5&q=&nis=4&ved=2ahUKEwiM4LKkoMeOAxVWQUEAHZRCOIIQww8oAnoECAgQDg&adurl=', 'buonissima', 'ORDINATO', '2025-07-18', NULL, 3, 26);

--
-- Trigger `proposta`
--
DELIMITER $$
CREATE TRIGGER `before_insert_proposta` BEFORE INSERT ON `proposta` FOR EACH ROW BEGIN
    IF NEW.codice IS NULL OR NEW.codice = '' THEN
        SET NEW.codice = generate_codice();
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `richiesta`
--

CREATE TABLE `richiesta` (
  `id` int(11) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `stato` enum('IN_ATTESA','PRESA_IN_CARICO','RISOLTA','ORDINATA') NOT NULL,
  `data` date DEFAULT NULL,
  `codice_richiesta` varchar(255) NOT NULL,
  `version` bigint(20) UNSIGNED NOT NULL DEFAULT 1,
  `ordinante` int(11) NOT NULL,
  `tecnico` int(11) DEFAULT NULL,
  `categoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `richiesta`
--

INSERT INTO `richiesta` (`id`, `note`, `stato`, `data`, `codice_richiesta`, `version`, `ordinante`, `tecnico`, `categoria`) VALUES
(22, '', 'RISOLTA', '2025-07-17', 'RlLG7ddAjz', 4, 27, 28, 35),
(23, 'harry potter', 'RISOLTA', '2025-07-18', 'ANFwmv9qZB', 4, 31, 30, 11),
(24, '', 'PRESA_IN_CARICO', '2025-07-18', '3YRNOhAaGP', 2, 31, 38, 22),
(25, '', 'PRESA_IN_CARICO', '2025-07-18', 'gT9DSRi3ya', 2, 27, 28, 37),
(26, '', 'RISOLTA', '2025-07-18', 'Dvo5tz9bOz', 4, 44, 30, 36),
(27, 'comodino', 'PRESA_IN_CARICO', '2025-07-18', 'hkV7ty0wZo', 2, 44, 30, 21);

--
-- Trigger `richiesta`
--
DELIMITER $$
CREATE TRIGGER `before_insert_richiesta` BEFORE INSERT ON `richiesta` FOR EACH ROW BEGIN
    IF NEW.codice_richiesta IS NULL OR NEW.codice_richiesta = '' THEN
        SET NEW.codice_richiesta = generate_codice();
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `utente`
--

CREATE TABLE `utente` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `tipologia_utente` enum('ORDINANTE','TECNICO','AMMINISTRATORE','') NOT NULL,
  `version` bigint(20) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `utente`
--

INSERT INTO `utente` (`id`, `username`, `email`, `password`, `tipologia_utente`, `version`) VALUES
(1, 'admin', 'admin@admin.com', '282db4a4425f50237e7df29d56988825f15dd8b34fa74af54e650ce0fd8897a82dff0b952017a3a88a62f5f1b0e0e467', 'AMMINISTRATORE', 1),
(27, 'federico', 'federico@palmerini.it', '55b7c0f26c04f7101904eabd7ef2c230217ef34c8d768ea9197f98971029f88ec470191e69a2e67ee7697497e2040590', 'ORDINANTE', 1),
(28, 'lorenzo', 'lorenzo@palmerini.it', 'c6420460d73ebb1c1ddc8b247e7b5560fb36339bf8af53e3df440253d940dcf8448c48b90014d3d45167db86d941cdba', 'TECNICO', 1),
(30, 'tecnico', 'tecnico@tecnico.it', '7c9ef82d9f2e3beb5471ea62703e432dd23088f439f6b59f6b2eb5c5ab66ec791626cb6aaeee5a62991f6c0638945a3d', 'TECNICO', 1),
(31, 'ordinante', 'ordinante@ordinante.it', '924831735559725d756eb9303bfef75e996be8dcac8de6bdf55b19b9ddb177332c1ac76c401b60d3c40184f336902388', 'ORDINANTE', 1),
(32, 'stefania', 'stefania@carnessale.it', '9f4ed9cfcec9152a4e9969caf2d845a7ec8cb32523f43bad28e4cfa31d361ab81c25bd8c8e06f726460c2b618f046094', 'ORDINANTE', 1),
(37, 'giuseppe', 'giuseppe@palmerini.it', '36804c2259f84f5dce032f2df4f0acf4edf8879f285d64fded49a555f67d616a6a50f318d97ccf714218e14420aaf570', 'ORDINANTE', 1),
(38, 'daniele', 'daniele@gamil.com', '35ec4cdc0c6925194eb60db614f2d72ada1360763a3f323c7670a3f60426825b6a1f321f1f2aa0badb1187680ab33d8a', 'TECNICO', 1),
(39, 'simona', 'simona@gmai.com', '971f927264dcc069b7bf6a3f6bcb515e420ad9b800c863f779cdec78dda989d6342cc5b9988f5feec73c4c3432422a5a', 'TECNICO', 1),
(44, 'palm', 'federico.palmerini.25@gmail.com', '227933c2186cdaa52cac574c8078b52d9599689677cb5cca663cf818fa78a45679f248ffe2913f04c73e2e9dee312587', 'ORDINANTE', 1);

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `caratteristica`
--
ALTER TABLE `caratteristica`
  ADD PRIMARY KEY (`id`),
  ADD KEY `caratteristica_ibfk_1` (`categoria_id`);

--
-- Indici per le tabelle `caratteristica_richiesta`
--
ALTER TABLE `caratteristica_richiesta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `richiesta` (`richiesta`,`caratteristica`),
  ADD KEY `caratteristica` (`caratteristica`);

--
-- Indici per le tabelle `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome` (`nome`);

--
-- Indici per le tabelle `ordine`
--
ALTER TABLE `ordine`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proposta_id` (`proposta_id`);

--
-- Indici per le tabelle `proposta`
--
ALTER TABLE `proposta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `richiesta_id` (`richiesta_id`);

--
-- Indici per le tabelle `richiesta`
--
ALTER TABLE `richiesta`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codice_richiesta` (`codice_richiesta`),
  ADD KEY `ordinante` (`ordinante`,`tecnico`,`categoria`),
  ADD KEY `categoria` (`categoria`),
  ADD KEY `tecnico` (`tecnico`);

--
-- Indici per le tabelle `utente`
--
ALTER TABLE `utente`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `caratteristica`
--
ALTER TABLE `caratteristica`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT per la tabella `caratteristica_richiesta`
--
ALTER TABLE `caratteristica_richiesta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT per la tabella `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT per la tabella `ordine`
--
ALTER TABLE `ordine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT per la tabella `proposta`
--
ALTER TABLE `proposta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT per la tabella `richiesta`
--
ALTER TABLE `richiesta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT per la tabella `utente`
--
ALTER TABLE `utente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `caratteristica`
--
ALTER TABLE `caratteristica`
  ADD CONSTRAINT `caratteristica_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `caratteristica_richiesta`
--
ALTER TABLE `caratteristica_richiesta`
  ADD CONSTRAINT `caratteristica_richiesta_ibfk_1` FOREIGN KEY (`richiesta`) REFERENCES `richiesta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `caratteristica_richiesta_ibfk_2` FOREIGN KEY (`caratteristica`) REFERENCES `caratteristica` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `ordine`
--
ALTER TABLE `ordine`
  ADD CONSTRAINT `ordine_ibfk_1` FOREIGN KEY (`proposta_id`) REFERENCES `proposta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `proposta`
--
ALTER TABLE `proposta`
  ADD CONSTRAINT `proposta_ibfk_1` FOREIGN KEY (`richiesta_id`) REFERENCES `richiesta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `richiesta`
--
ALTER TABLE `richiesta`
  ADD CONSTRAINT `richiesta_ibfk_1` FOREIGN KEY (`categoria`) REFERENCES `categoria` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `richiesta_ibfk_2` FOREIGN KEY (`ordinante`) REFERENCES `utente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `richiesta_ibfk_3` FOREIGN KEY (`tecnico`) REFERENCES `utente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
