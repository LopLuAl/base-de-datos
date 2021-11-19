
DROP DATABASE IF EXISTS `CONTROL_ACCESO`;
/*******************************************************************************
   Create database
********************************************************************************/
CREATE DATABASE `CONTROL_ACCESO`;
USE `CONTROL_ACCESO`;
SET default_storage_engine = `InnoDB`;
-- -----------------------------------------------------
-- Table `Horario-laboral`
-- -----------------------------------------------------
CREATE TABLE `Horario-laboral` (
  `Workplace` int(11) NOT NULL,
  `Hora-Entrada` time NOT NULL,
  `Hora-Salida` time NOT NULL,
  PRIMARY KEY (`Workplace`)
);
-- -----------------------------------------------------
-- Table `Nivel-acceso`
-- -----------------------------------------------------
CREATE TABLE `Nivel-acceso` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(11) NOT NULL,
  `NIVEL-ACCESO` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ;
-- -----------------------------------------------------
-- Table `Nivel-acceso-persona`
-- -----------------------------------------------------
CREATE TABLE `Nivel-acceso-persona` (
  `ID-Persona` int(11) NOT NULL,
  `ID-Nivel-acceso` int(11) NOT NULL,
  `Nivel-acceso` int(11) NOT NULL,
  `TAG-ID` int(11) NOT NULL,
  PRIMARY KEY (`ID-Persona`),
  UNIQUE KEY `ID-Persona` (`ID-Persona`),
  KEY `fk_Nivel-acceso` (`Nivel-acceso`)
) ;
-- -----------------------------------------------------
-- Table `Persona`
-- -----------------------------------------------------
CREATE TABLE `Persona` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(55) NOT NULL,
  `Apellido` varchar(55) NOT NULL,
  `Estado` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ;
-- -----------------------------------------------------
-- Table `Puerta`
-- -----------------------------------------------------
CREATE TABLE `Puerta` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Abierta-Cerrada` int(11) NOT NULL,
   PRIMARY KEY (`ID`)
) ;
-- -----------------------------------------------------
-- Table `Puerta-estadistica`
-- -----------------------------------------------------
CREATE TABLE `Puerta-estadistica` (
  `TAG ID` int(11) NOT NULL ,
  `Hora` time NOT NULL,
  `Dia` date NOT NULL,
  `Permitido` int(11) NOT NULL,
  `Denegados` int(11) NOT NULL,
  `Entrada` int(11) NOT NULL,
  `Salida` int(11) NOT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`)
) ;
-- -----------------------------------------------------
-- Table `Workplace`
-- -----------------------------------------------------
CREATE TABLE `Workplace` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Direccion` int(11) NOT NULL,
  `Oficina` int(11) NOT NULL,
  `ID_Empleado` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_persona_ID` (`Oficina`)
) ;


ALTER TABLE `Nivel-acceso`  ADD CONSTRAINT `fk_puerta_ID_Nivel-acceso` FOREIGN KEY (`ID`) REFERENCES `Puerta` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE `Persona`  ADD CONSTRAINT `fk_Nivel-acceso-persona` FOREIGN KEY (`ID`) REFERENCES `Nivel-acceso-persona` (`ID-Persona`) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE `Puerta-estadistica` ADD CONSTRAINT `fk_puerta_ID_Puerta-estadistica` FOREIGN KEY (`ID`) REFERENCES `Puerta` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE `Workplace`
  ADD CONSTRAINT `fk_persona_ID` FOREIGN KEY (`Oficina`) REFERENCES `Persona` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_workplace` FOREIGN KEY (`ID`) REFERENCES `Horario-laboral` (`Workplace`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_puerta_ID` FOREIGN KEY (`Oficina`) REFERENCES `Puerta` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

INSERT INTO `Horario-laboral` (`Workplace`, `Hora-Entrada`, `Hora-Salida`)
  VALUES (1, '09:00:00', '18:00:00');

INSERT INTO `Puerta` (`ID`, `Abierta-Cerrada`) VALUES (1, 0);
INSERT INTO `Puerta` (`ID`, `Abierta-Cerrada`) VALUES (2, 0);

INSERT INTO `Nivel-acceso` (`ID`, `NOMBRE`, `NIVEL-ACCESO`)
  VALUES (1, 'Gerencia', 3);
INSERT INTO `Nivel-acceso` (`ID`, `NOMBRE`, `NIVEL-ACCESO`)
  VALUES (2, 'Recepccion', 1);

INSERT INTO `Nivel-acceso-persona` (`ID-Persona`, `ID-Nivel-acceso`,
  `Nivel-acceso`, `TAG-ID`) VALUES  (1, 1, 1, 123456);
INSERT INTO `Nivel-acceso-persona` (`ID-Persona`, `ID-Nivel-acceso`,
  `Nivel-acceso`, `TAG-ID`) VALUES (2, 2, 2, 1234567);

INSERT INTO `Persona` (`ID`, `Nombre`, `Apellido`, `Estado`) VALUES
  (1, 'Pedro', 'Gonzalez', 1);
INSERT INTO `Persona` (`ID`, `Nombre`, `Apellido`, `Estado`) VALUES
  (2, 'Jorge', 'Rodriguez', 1);

INSERT INTO `Workplace` (`ID`, `Direccion`, `Oficina`, `ID_Empleado`)
  VALUES (1, 1, 1, 0);











COMMIT;
