/*******************************************************************************
   Drop database if it exists
********************************************************************************/
set global SQL_MODE="NO_ENGINE_SUBSTITUTION";


DROP DATABASE IF EXISTS `CONTROL_ACCESO`;
/*******************************************************************************
   Create database
********************************************************************************/
CREATE DATABASE `CONTROL_ACCESO`;
USE `CONTROL_ACCESO`;
SET default_storage_engine = `InnoDB`;

-- --------------------------------------------------------

--
-- Table structure for table `Horario-laboral`
--

CREATE TABLE `Horario-laboral` (
  `Workplace` int(11) NOT NULL,
  `Hora-Entrada` int(11) NOT NULL,
  `Hora-Salida` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Nivel-acceso`
--

CREATE TABLE `Nivel-acceso` (
  `ID` int(11) NOT NULL,
  `NOMBRE` int(11) NOT NULL,
  `NIVEL-ACCESO` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Nivel-acceso-persona`
--

CREATE TABLE `Nivel-acceso-persona` (
  `ID-Persona` int(11) NOT NULL,
  `ID-Nivel-acceso` int(11) NOT NULL,
  `Nivel-acceso` int(11) NOT NULL,
  `TAG-ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Persona`
--

CREATE TABLE `Persona` (
  `ID` int(11) NOT NULL,
  `Nombre` varchar(55) NOT NULL,
  `Apellido` varchar(55) NOT NULL,
  `Estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Puerta`
--

CREATE TABLE `Puerta` (
  `ID` int(11) NOT NULL,
  `Abierta-Cerrada` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Puerta-estadistica`
--

CREATE TABLE `Puerta-estadistica` (
  `TAG ID` int(11) NOT NULL,
  `Hora` int(11) NOT NULL,
  `Dia` int(11) NOT NULL,
  `Permitido` int(11) NOT NULL,
  `Denegados` int(11) NOT NULL,
  `Entrada` int(11) NOT NULL,
  `Salida` int(11) NOT NULL,
  `ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Workplace`
--

CREATE TABLE `Workplace` (
  `ID` int(11) NOT NULL,
  `Direccion` int(11) NOT NULL,
  `Oficina` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Horario-laboral`
--
ALTER TABLE `Horario-laboral`
  ADD PRIMARY KEY (`Workplace`);

--
-- Indexes for table `Nivel-acceso`
--
ALTER TABLE `Nivel-acceso`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Nivel-acceso-persona`
--
ALTER TABLE `Nivel-acceso-persona`
  ADD PRIMARY KEY (`ID-Persona`),
  ADD UNIQUE KEY `ID-Persona` (`ID-Persona`);

--
-- Indexes for table `Persona`
--
ALTER TABLE `Persona`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Puerta`
--
ALTER TABLE `Puerta`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Puerta-estadistica`
--
ALTER TABLE `Puerta-estadistica`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Workplace`
--
ALTER TABLE `Workplace`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `7` (`Oficina`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Nivel-acceso`
--
ALTER TABLE `Nivel-acceso`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Persona`
--
ALTER TABLE `Persona`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Puerta`
--
ALTER TABLE `Puerta`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Puerta-estadistica`
--
ALTER TABLE `Puerta-estadistica`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Workplace`
--
ALTER TABLE `Workplace`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Nivel-acceso`
--
ALTER TABLE `Nivel-acceso`
  ADD CONSTRAINT `5` FOREIGN KEY (`ID`) REFERENCES `Puerta` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Persona`
--
ALTER TABLE `Persona`
  ADD CONSTRAINT `1` FOREIGN KEY (`ID`) REFERENCES `Nivel-acceso-persona` (`ID-Persona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `2` FOREIGN KEY (`ID`) REFERENCES `Workplace` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Puerta-estadistica`
--
ALTER TABLE `Puerta-estadistica`
  ADD CONSTRAINT `4` FOREIGN KEY (`ID`) REFERENCES `Puerta` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Workplace`
--
ALTER TABLE `Workplace`
  ADD CONSTRAINT `6` FOREIGN KEY (`ID`) REFERENCES `Horario-laboral` (`Workplace`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `7` FOREIGN KEY (`Oficina`) REFERENCES `Puerta` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;
