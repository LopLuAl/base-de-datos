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

-- -----------------------------------------------------
-- Table `NIVEL_DE_ACCESO_PERSONA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NIVEL_DE_ACCESO_PERSONAS` (
	`ID_NIVEL_DE_ACCESO_PERSONA` INT NOT NULL,
	`ID_PERSONA` INT NOT NULL,
	`ID_NIVEL_DE_ACCESO` INT NOT NULL,
	`NIVEL_DE_ACCESO` INT NOT NULL ,
	`TAG_ID` INT  NOT NULL,
	CONSTRAINT `PK_NIVEL_DE_ACCESO_PERSONA` PRIMARY KEY (`ID_NIVEL_DE_ACCESO_PERSONA`)
	);

-- -----------------------------------------------------
-- Table `PERSONA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PERSONA` (
	`IDPERSONA` INT  NOT NULL,
	`NIVEL_DE_ACCESO_P` INT  NOT NULL,
	`NOMBRE` VARCHAR(45) ,
	`ESTADO` VARCHAR(45),
	`IDWORKPLACE` INT  NOT NULL,
	 CONSTRAINT `PK_PERSONA`PRIMARY KEY (`IDPERSONA`)
	 );



   -- -----------------------------------------------------
   -- CREATE INDEX
   -- -----------------------------------------------------

   CREATE INDEX `IFK_ID_NIVEL_DE_ACCESO_PERSONA` ON `NIVEL_DE_ACCESO_PERSONAS`   ( `ID_NIVEL_DE_ACCESO_PERSONA`);

   ALTER TABLE PERSONA
   ADD CONSTRAINT `FK_NIVEL_DE_ACCESO_PERSONAS`
   FOREIGN KEY (`NIVEL_DE_ACCESO_P`) REFERENCES `NIVEL_DE_ACCESO_PERSONAS` (`NIVEL_DE_ACCESO`) ON DELETE NO ACTION ON UPDATE NO ACTION;



   --ALTER TABLE Orders
   --ADD CONSTRAINT FK_PersonOrder
   --FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);
