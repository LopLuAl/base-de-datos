/*******************************************************************************
   Drop database if it exists
********************************************************************************/
DROP DATABASE IF EXISTS `CONTROL_ACCESO`;
/*******************************************************************************
   Create database
********************************************************************************/
CREATE DATABASE `CONTROL_ACCESO`;
USE `CONTROL_ACCESO`;
SET default_storage_engine = `InnoDB`;
-- -----------------------------------------------------
-- Table `WORKPLACE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WORKPLACE` (
	`IDWORKSPACE` INT NOT NULL,
	`DIRECCION` VARCHAR(45),
	`NRO_OFICINA` INT ,
	PRIMARY KEY (`IDWORKSPACE`)
  );

-- -----------------------------------------------------
-- Table `PERSONA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PERSONA` (
	`IDPERSONA` INT NOT NULL,
	`NOMBRE` VARCHAR(45) ,
	`ESTADO` VARCHAR(45),
	`IDWORKSPACE` INT NOT NULL,
	PRIMARY KEY (`IDPERSONA`),
	CONSTRAINT `FK_WORKPLACE`
	FOREIGN KEY (`IDWORKSPACE`)
	REFERENCES `WORKPLACE` (`IDWORKSPACE`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION);
-- -----------------------------------------------------
-- Table `HORARIO-LABORAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HORARIO_LABORAL` (
	`HORA_ENTRADA` INT NULL,
	`HORARIO-SALIDA` INT NULL,
	`IDWORKSPACE` INT NOT NULL,
	CONSTRAINT `FK_HORARIO_LABORAL_WORKPLACE`
	FOREIGN KEY (`IDWORKSPACE`)
	REFERENCES `WORKPLACE` (`IDWORKSPACE`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION);
-- -----------------------------------------------------
-- Table `NIVEL_DE_ACCESO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NIVEL_DE_ACCESO` (
	`ID_NIVEL_DE_ACCESO` INT NOT NULL,
	`NOMBRE_HABITACION` VARCHAR(45) NULL,
	`NIVEL_DE_ACCESO` INT NULL,
	PRIMARY KEY (`ID_NIVEL_DE_ACCESO`));
-- -----------------------------------------------------
-- Table `ESTADISTICA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ESTADISTICA` (
	`ID_ESTADISTICA` INT NOT NULL,
	`TAG ID` INT NULL,
	`HORA` INT NULL,
	`DIA` INT NULL,
	`PERMITIDO/DENEGADO` TINYINT NULL,
	`ENTRADA/SALIDA` TINYINT NULL,
	`ESTADISTICA` TINYINT NULL,
	PRIMARY KEY (`ID_ESTADISTICA`));
-- -----------------------------------------------------
-- Table `PUERTA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PUERTA` (
  `ID_PUERTA` INT NOT NULL,
  `ABIERTA/CERRADA` TINYINT NULL,
  `ID_NIVEL_DE_ACCESO` INT NOT NULL,
  `ID_ESTADISTICA` INT NOT NULL,
  `IDWORKSPACE` INT NOT NULL,
  PRIMARY KEY (`ID_PUERTA`),
  
  CONSTRAINT `FK_PUERTA_NIVEL_DE_ACCESO`
    FOREIGN KEY (`ID_NIVEL_DE_ACCESO`)
    REFERENCES `NIVEL_DE_ACCESO` (`ID_NIVEL_DE_ACCESO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_PUERTA_ESTADISTICA`
    FOREIGN KEY (`ID_ESTADISTICA`)
    REFERENCES `ESTADISTICA` (`ID_ESTADISTICA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_PUERTA_WORKPLACE`
    FOREIGN KEY (`IDWORKSPACE`)
    REFERENCES `WORKPLACE` (`IDWORKSPACE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
-- -----------------------------------------------------
-- CREATE INDEX
-- -----------------------------------------------------   
CREATE INDEX `IFK_IDWORKSPACE`        ON `WORKPLACE` 	( `IDWORKSPACE`);    
CREATE INDEX `IFK_ID_NIVEL_DE_ACCESO` ON `NIVEL_DE_ACCESO`   ( `ID_NIVEL_DE_ACCESO`);
CREATE INDEX `IFK_PUERTA_ESTADISTICA` ON `ESTADISTICA` 	( `ID_ESTADISTICA`) ;
