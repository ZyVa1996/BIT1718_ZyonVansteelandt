-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Exam_exercise9
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Exam_exercise9
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Exam_exercise9` ;
USE `Exam_exercise9` ;

-- -----------------------------------------------------
-- Table `Exam_exercise9`.`Chromosomal_position`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Exam_exercise9`.`Chromosomal_position` (
  `ID_chromosomal_position` INT NOT NULL,
  `chromosome` INT NULL,
  `start_of_region` INT NULL,
  `end_of_region` INT NULL,
  PRIMARY KEY (`ID_chromosomal_position`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Exam_exercise9`.`Gene_Mutation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Exam_exercise9`.`Gene_Mutation` (
  `ID` INT NOT NULL,
  `gene_name` VARCHAR(100) NULL,
  `gene_description` TEXT(250) NULL,
  `chromosome_ID` INT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Gene_Mutation_1_idx` (`chromosome_ID` ASC),
  CONSTRAINT `fk_Gene_Mutation_1`
    FOREIGN KEY (`chromosome_ID`)
    REFERENCES `Exam_exercise9`.`Chromosomal_position` (`ID_chromosomal_position`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Exam_exercise9`.`Patiënt_syndrome`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Exam_exercise9`.`Patiënt_syndrome` (
  `id_Syndrome` INT NOT NULL,
  `name_syndrome` VARCHAR(100) NULL,
  `syndrome_description` TEXT(250) NULL,
  `gene_ID` INT NULL,
  PRIMARY KEY (`id_Syndrome`),
  INDEX `fk_Patiënt_syndrome_1_idx` (`gene_ID` ASC),
  CONSTRAINT `fk_Patiënt_syndrome_1`
    FOREIGN KEY (`gene_ID`)
    REFERENCES `Exam_exercise9`.`Gene_Mutation` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Exam_exercise9`.`Patiënt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Exam_exercise9`.`Patiënt` (
  `id_Patiënt` INT NOT NULL,
  `patient_firstname` VARCHAR(45) NULL,
  `patient_lastname` VARCHAR(45) NULL,
  `gender` ENUM('M', 'F') NULL,
  `age` INT NULL,
  `syndrome_id` INT NULL,
  PRIMARY KEY (`id_Patiënt`),
  INDEX `fk_Patiënt_1_idx` (`syndrome_id` ASC),
  CONSTRAINT `fk_Patiënt_1`
    FOREIGN KEY (`syndrome_id`)
    REFERENCES `Exam_exercise9`.`Patiënt_syndrome` (`id_Syndrome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Exam_exercise9`.`CrossTable`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Exam_exercise9`.`CrossTable` (
  `idCrossTable` INT NOT NULL,
  `gene_ID` INT NULL,
  `syndrome_ID` INT NULL,
  PRIMARY KEY (`idCrossTable`),
  INDEX `fk_CrossTable_1_idx` (`syndrome_ID` ASC),
  INDEX `fk_CrossTable_2_idx` (`gene_ID` ASC),
  CONSTRAINT `fk_CrossTable_1`
    FOREIGN KEY (`syndrome_ID`)
    REFERENCES `Exam_exercise9`.`Patiënt_syndrome` (`id_Syndrome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CrossTable_2`
    FOREIGN KEY (`gene_ID`)
    REFERENCES `Exam_exercise9`.`Gene_Mutation` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
