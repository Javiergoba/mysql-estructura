-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8 ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`empleado` (
  `id_empleado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_empleado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `telefono`int ,
  `email` VARCHAR(45) NULL,
  `f_registro` year not NULL,
  `recomendado` ENUM('red social', 'anuncio', 'cliente') NULL,
  `atendido` INT NOT NULL,
  PRIMARY KEY (`id_cliente`),
  INDEX `atendido_idx` (`atendido` ASC) VISIBLE,
  CONSTRAINT `atendido`
    FOREIGN KEY (`atendido`)
    REFERENCES `optica`.`empleado` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`proveedor` (
  `id_proveedor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `telefon` INT(45) NOT NULL,
  `fax` INT(45) NOT NULL,
  `nif` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_proveedor`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`gafas` (
  `id-gafas` INT NOT NULL AUTO_INCREMENT,
  `gafas_id_proveedor` INT NOT NULL,
  `marca` VARCHAR(45) NOT NULL,
  `graduacion` VARCHAR(45) NOT NULL,
  `montura` ENUM('metalica', 'pasta', 'al aire') NOT NULL,
  `color_montura` VARCHAR(45) NOT NULL,
  `color_cristal` VARCHAR(45) NOT NULL,
  `precio` DOUBLE NOT NULL,
  PRIMARY KEY (`id-gafas`),
  INDEX `gafas_id_proveedor_idx` (`gafas_id_proveedor` ASC) VISIBLE,
  CONSTRAINT `gafas_id_proveedor`
    FOREIGN KEY (`gafas_id_proveedor`)
    REFERENCES `optica`.`proveedor` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `optica`.`Detalle_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Detalle_compra` (
  `ticket` INT NOT NULL AUTO_INCREMENT,
  `id_empleado` INT NOT NULL,
  `id_cliente` INT NOT NULL,
  `id_gafas` INT NOT NULL,
  `fecha_compra`datetime not null,
  INDEX `fk_empleado_has_cliente_cliente1_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `fk_empleado_has_cliente_empleado1_idx` (`id_empleado` ASC) VISIBLE,
  INDEX `id_gafas_idx` (`id_gafas` ASC) VISIBLE,
  PRIMARY KEY (`ticket`),
  CONSTRAINT `fk_empleado_has_cliente_empleado1`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `optica`.`empleado` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleado_has_cliente_cliente1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `optica`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_gafas`
    FOREIGN KEY (`id_gafas`)
    REFERENCES `optica`.`gafas` (`id-gafas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- empleados

insert into empleado values (1,'Juan') ;
insert into empleado values (2,'Sofia');
insert into empleado values (3, 'Erika' );

-- clientes

insert into cliente values (1, 'Antonio', 'calle iglesia 5 ',123456789,'antonio@gmail.com', 1999,'red social', 2);
insert into cliente values (2, 'Lorenzo', 'calle tejon 23 ', 435696801,'lorenzo@gmail.com', 2005,'anuncio', 2);
insert into cliente values (3, 'Pilar', 'calle luna 89 ',648390986,'pilar@gmail.com', 2019 ,'anuncio', 3);
insert into cliente values (4, 'Anna', 'calle eros 18 ',546023567,'anna@gmail.com', 2003,'cliente', 2);
insert into cliente values (5, 'Sonia', 'avd libro 1 ',983566678,'sonia@gmail.com', 2006,'red social', 1);
insert into cliente values (6, 'Segundo', 'calle enrique 76 ',946723488,'segundo@gmail.com', 2013 ,'red social', 1);
insert into cliente values (7, 'Roberto', 'calle estacion 119 ',846677884,'roberto@gmail.com', 2006 ,'red social',3);

-- proveedor

insert into proveedor values (1,'claravision',' calle mayor 23 local c 09879 españa', 987653215,987653225,'54321098k');
insert into proveedor values (2,'solomiro',' calle alfonso x 93 09776 españa', 935456798,935456799,'325547609j');
insert into proveedor values (3,'casiveo',' calle campoamor 8  09118 españa', 876876534,876876554,'985643887l');

-- gafas 

insert into gafas values (1,1 ,'POLAROID' , 'oi +0,25 od +0.20', 'al aire', 'transp' , 119,98 );
insert into gafas values (2, 3 ,'EMPORIO' , 'oi +0,25 od +0.20', 'pasta', 'trans' , 178,86 );
insert into gafas values (3, 1 ,'RAYBAN' , 'AO +0,25 ', 'pasta', 'trans' , 98,98 );
insert into gafas values (4, 3 ,'RAIBAN' , 'oi -0,5 od -0.10', 'metalica', 'trans' , 123,00 );
insert into gafas values (5, 1 ,'DOLCE ' , ' VC ', 'pasta', 'color' , 200,98 );
insert into gafas values (6, 2 ,'PRADA' , 'oi +0,25 od +0.20', 'pasta', 'trans' , 233,30 );
insert into gafas values (7, 1 ,'ARNETTE ' , 'oi +0,25 od +0.20', 'pasta', 'color' , 43,98 );
insert into gafas values (8, 2 ,'TOUS' , 'oi -0,5 od +0.03', 'pasta', 'color' , 119,98 );
insert into gafas values (9, 1 ,'TOUS' , 'solares ', 'metalica', 'color' , 324,00);
insert into gafas values (10,2 ,'GUCCI' , 'oi +0,25 od +0.20', 'al aire', 'color' , 97,98 );
insert into gafas values (11, 1 ,'DOLCE' , 'oi -0,25 od -0.20', 'pasta', 'color' , 123,98 );
insert into gafas values (12, 2 ,'VICTORIO' , 'oi +0,1 od +0.12', 'metalica', 'color' , 122,98 );

-- detalle de compra

insert into detalle_compra values (1,3,6,7,'2001-09-19');
insert into detalle_compra values (2,3,3,2,'2003-01-07');
insert into detalle_compra values (3,3,5,5,'2004-05-11');
insert into detalle_compra values (4,2,3,6,'2004-06-12');
insert into detalle_compra values (5,1,7,11,'2008-04-07');
insert into detalle_compra values (6,2,3,2,'2003-09-27');
insert into detalle_compra values (7,2,6,3,'2003-11-12');
insert into detalle_compra values (8,1,3,2,'2003-12-16');



