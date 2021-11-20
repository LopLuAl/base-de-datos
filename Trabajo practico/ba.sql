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
CREATE TABLE `Horario_laboral` (
  `Workplace` int(11) NOT NULL,
  `Hora_Entrada` time NOT NULL,
  `Hora_Salida` time NOT NULL,
  PRIMARY KEY (`Workplace`)
);
-- -----------------------------------------------------
-- Table `Nivel-acceso`
-- -----------------------------------------------------
CREATE TABLE `Nivel_acceso` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(11) NOT NULL,
  `NIVEL_ACCESO` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ;
-- -----------------------------------------------------
-- Table `Nivel-acceso-persona`
-- -----------------------------------------------------
CREATE TABLE `Nivel_acceso_persona` (
  `ID_Persona` int(11) NOT NULL,
  `ID_Nivel_acceso` int(11) NOT NULL,
  `Nivel_acceso` int(11) NOT NULL,
  `TAG_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID_Persona`),
  UNIQUE KEY `ID_Persona` (`ID_Persona`),
  KEY `fk_Nivel_acceso` (`Nivel_acceso`)
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
  `Abierta_Cerrada` int(11) NOT NULL,
   PRIMARY KEY (`ID`)
) ;
-- -----------------------------------------------------
-- Table `Puerta-estadistica`
-- -----------------------------------------------------
CREATE TABLE `Puerta_estadistica` (
  `TAG_ID` int(11) NOT NULL ,
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


ALTER TABLE `Nivel_acceso`  ADD CONSTRAINT `fk_puerta_ID_Nivel_acceso` FOREIGN KEY (`ID`) REFERENCES `Puerta` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE `Persona`  ADD CONSTRAINT `fk_Nivel_acceso_persona` FOREIGN KEY (`ID`) REFERENCES `Nivel_acceso_persona` (`ID_Persona`) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE `Puerta_estadistica` ADD CONSTRAINT `fk_puerta_ID_Puerta_estadistica` FOREIGN KEY (`ID`) REFERENCES `Puerta` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE `Workplace`
  ADD CONSTRAINT `fk_persona_ID` FOREIGN KEY (`Oficina`) REFERENCES `Persona` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_workplace` FOREIGN KEY (`ID`) REFERENCES `Horario_laboral` (`Workplace`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_puerta_ID` FOREIGN KEY (`Oficina`) REFERENCES `Puerta` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

INSERT INTO `Horario_laboral` (`Workplace`, `Hora_Entrada`, `Hora_Salida`)
  VALUES (1, '09:00:00', '18:00:00');

INSERT INTO `Puerta` (`ID`, `Abierta_Cerrada`) VALUES (1, 0);
INSERT INTO `Puerta` (`ID`, `Abierta_Cerrada`) VALUES (2, 0);

INSERT INTO `Nivel_acceso` (`ID`, `NOMBRE`, `NIVEL_ACCESO`)
  VALUES (1, 'Gerencia', 3);
INSERT INTO `Nivel_acceso` (`ID`, `NOMBRE`, `NIVEL_ACCESO`)
  VALUES (2, 'Recepccion', 1);

INSERT INTO `Nivel_acceso_persona` (`ID_Persona`, `ID_Nivel_acceso`,
  `Nivel_acceso`, `TAG_ID`) VALUES  (1, 1, 1, 123456);
INSERT INTO `Nivel_acceso_persona` (`ID_Persona`, `ID_Nivel_acceso`,
  `Nivel_acceso`, `TAG_ID`) VALUES (2, 2, 2, 1234567);
INSERT INTO `Nivel_acceso_persona` (`ID_Persona`, `ID_Nivel_acceso`,
  `Nivel_acceso`, `TAG_ID`) VALUES (3, 2, 5, 12345678);

INSERT INTO `Persona` (`ID`, `Nombre`, `Apellido`, `Estado`) VALUES
  (1, 'Pedro', 'Gonzalez', 1);
INSERT INTO `Persona` (`ID`, `Nombre`, `Apellido`, `Estado`) VALUES
  (2, 'Jorge', 'Rodriguez', 1);
INSERT INTO `Persona` (`ID`, `Nombre`, `Apellido`, `Estado`) VALUES
    (3, 'Marco', 'Antonio', 1);
INSERT INTO `Workplace` (`ID`, `Direccion`, `Oficina`, `ID_Empleado`)
  VALUES (1, 1, 1, 0);


COMMIT;
