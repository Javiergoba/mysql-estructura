

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema -- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

drop database if exists pizzeria;

CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`pizzeria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizzeria` (
  `id_pizzeria` INT NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `locallidad` VARCHAR(45) NOT NULL,
  `cp` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_pizzeria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido` VARCHAR(50) NOT NULL,
  `direccion` VARCHAR(50) NOT NULL,
  `cp` INT(6) NOT NULL,
  `localidad` VARCHAR(150) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `telef` INT(9) NOT NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`hamburguesa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`hamburguesa` (
  `id_hamburguesas` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `cantidad` VARCHAR(45) NULL,
  `descripcion` VARCHAR(150) NULL,
  `pvp` DOUBLE NULL,
  `imagen` BLOB NULL,
  PRIMARY KEY (`id_hamburguesas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizzas` (
  `id_pizza` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `cantidad` VARCHAR(45) NULL,
  `descripcion` VARCHAR(150) NULL,
  `pvp` DOUBLE NULL,
  `imagen` BLOB NULL,
  PRIMARY KEY (`id_pizza`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`bebida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`bebida` (
  `id_bebida` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `cantidad` VARCHAR(45) NULL,
  `descripcion` VARCHAR(150) NULL,
  `pvp` DOUBLE NULL,
  `imagen` BLOB NULL,
  PRIMARY KEY (`id_bebida`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`cliente_has_detalle_ped`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`cliente_has_detalle_ped` (
  `id_pedido` DATETIME NOT NULL,
  `cliente_id` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `pvp` DOUBLE NOT NULL,
  `pizzeria_id` INT NOT NULL,
  INDEX `fk_cliente_has_detalle_ped_cliente1_idx` (`cliente_id` ASC) VISIBLE,
  PRIMARY KEY (`id_pedido`),
  INDEX `fk_cliente_has_detalle_ped_pizzeria1_idx` (`pizzeria_id` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_has_detalle_ped_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `pizzeria`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_has_detalle_ped_pizzeria1`
    FOREIGN KEY (`pizzeria_id`)
    REFERENCES `pizzeria`.`pizzeria` (`id_pizzeria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleado` (
  `id_empleado` INT(4) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `dni` VARCHAR(9) NOT NULL,
  `telfono` INT(9) NOT NULL,
  `puesto` ENUM('cocinero', 'repartidor') NOT NULL,
  `pedido_tienda` DATETIME NOT NULL,
  `pizzeria_emp` INT NOT NULL,
  PRIMARY KEY (`id_empleado`),
  UNIQUE INDEX `dni_UNIQUE` (`dni` ASC) VISIBLE,
  INDEX `fk_empleado_cliente_has_detalle_ped1_idx` (`pedido_tienda` ASC) VISIBLE,
  INDEX `fk_empleado_pizzeria1_idx` (`pizzeria_emp` ASC) VISIBLE,
  CONSTRAINT `fk_empleado_cliente_has_detalle_ped1`
    FOREIGN KEY (`pedido_tienda`)
    REFERENCES `pizzeria`.`cliente_has_detalle_ped` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleado_pizzeria1`
    FOREIGN KEY (`pizzeria_emp`)
    REFERENCES `pizzeria`.`pizzeria` (`id_pizzeria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`categoria` (
  `pizza` INT NOT NULL,
  `hamburguesa` INT NOT NULL,
  `bebida` INT NOT NULL,
  `pedido_id` DATETIME NOT NULL,
  INDEX `fk_categoria_cliente_has_detalle_ped1_idx` (`pedido_id` ASC) VISIBLE,
  INDEX `pizza_idx` (`pizza` ASC) VISIBLE,
  INDEX `hamburguesa_idx` (`hamburguesa` ASC) VISIBLE,
  INDEX `bebida_idx` (`bebida` ASC) VISIBLE,
  CONSTRAINT `pizza`
    FOREIGN KEY (`pizza`)
    REFERENCES `pizzeria`.`pizzas` (`id_pizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `hamburguesa`
    FOREIGN KEY (`hamburguesa`)
    REFERENCES `pizzeria`.`hamburguesa` (`id_hamburguesas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `bebida`
    FOREIGN KEY (`bebida`)
    REFERENCES `pizzeria`.`bebida` (`id_bebida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_categoria_cliente_has_detalle_ped1`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `pizzeria`.`cliente_has_detalle_ped` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`pizzeria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizzeria` (
  `id_pizzeria` INT NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `locallidad` VARCHAR(45) NOT NULL,
  `cp` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `pizzeriacol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_pizzeria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido` VARCHAR(50) NOT NULL,
  `direccion` VARCHAR(50) NOT NULL,
  `cp` INT(6) NOT NULL,
  `localidad` VARCHAR(150) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `telef` INT(9) NOT NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`hamburguesa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`hamburguesa` (
  `id_hamburguesas` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `cantidad` VARCHAR(45) NULL,
  `descripcion` VARCHAR(150) NULL,
  `pvp` DOUBLE NULL,
  `imagen` BLOB NULL,
  PRIMARY KEY (`id_hamburguesas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizzas` (
  `id_pizza` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `cantidad` VARCHAR(45) NULL,
  `descripcion` VARCHAR(150) NULL,
  `pvp` DOUBLE NULL,
  `imagen` BLOB NULL,
  PRIMARY KEY (`id_pizza`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`bebida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`bebida` (
  `id_bebida` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `cantidad` VARCHAR(45) NULL,
  `descripcion` VARCHAR(150) NULL,
  `pvp` DOUBLE NULL,
  `imagen` BLOB NULL,
  PRIMARY KEY (`id_bebida`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`cliente_has_detalle_ped`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`cliente_has_detalle_ped` (
  `id_pedido` DATETIME NOT NULL,
  `cliente_id` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `pvp` DOUBLE NOT NULL,
  `pizzeria_id` INT NOT NULL,
  INDEX `fk_cliente_has_detalle_ped_cliente1_idx` (`cliente_id` ASC) VISIBLE,
  PRIMARY KEY (`id_pedido`),
  INDEX `fk_cliente_has_detalle_ped_pizzeria1_idx` (`pizzeria_id` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_has_detalle_ped_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `pizzeria`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_has_detalle_ped_pizzeria1`
    FOREIGN KEY (`pizzeria_id`)
    REFERENCES `pizzeria`.`pizzeria` (`id_pizzeria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleado` (
  `id_empleado` INT(4) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `dni` VARCHAR(9) NOT NULL,
  `telfono` INT(9) NOT NULL,
  `puesto` ENUM('cocinero', 'repartidor') NOT NULL,
  `pedido_tienda` DATETIME NOT NULL,
  `pizzeria_emp` INT NOT NULL,
  PRIMARY KEY (`id_empleado`),
  UNIQUE INDEX `dni_UNIQUE` (`dni` ASC) VISIBLE,
  INDEX `fk_empleado_cliente_has_detalle_ped1_idx` (`pedido_tienda` ASC) VISIBLE,
  INDEX `fk_empleado_pizzeria1_idx` (`pizzeria_emp` ASC) VISIBLE,
  CONSTRAINT `fk_empleado_cliente_has_detalle_ped1`
    FOREIGN KEY (`pedido_tienda`)
    REFERENCES `pizzeria`.`cliente_has_detalle_ped` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleado_pizzeria1`
    FOREIGN KEY (`pizzeria_emp`)
    REFERENCES `pizzeria`.`pizzeria` (`id_pizzeria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`categoria` (
  `pizza` INT NOT NULL,
  `hamburguesa` INT NOT NULL,
  `bebida` INT NOT NULL,
  `pedido_id` DATETIME NOT NULL,
  INDEX `fk_categoria_cliente_has_detalle_ped1_idx` (`pedido_id` ASC) VISIBLE,
  INDEX `pizza_idx` (`pizza` ASC) VISIBLE,
  INDEX `hamburguesa_idx` (`hamburguesa` ASC) VISIBLE,
  INDEX `bebida_idx` (`bebida` ASC) VISIBLE,
  CONSTRAINT `pizza`
    FOREIGN KEY (`pizza`)
    REFERENCES `pizzeria`.`pizzas` (`id_pizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `hamburguesa`
    FOREIGN KEY (`hamburguesa`)
    REFERENCES `pizzeria`.`hamburguesa` (`id_hamburguesas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `bebida`
    FOREIGN KEY (`bebida`)
    REFERENCES `pizzeria`.`bebida` (`id_bebida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_categoria_cliente_has_detalle_ped1`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `pizzeria`.`cliente_has_detalle_ped` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- pizzeria
insert into pizzeria (direccion, codigo_postal, localidad, ciudad) values

	('Calle de Provença, 123', '08029', 'Barcelona', 'Barcelona'),
	('Avenida de Diagonal, 456', '08036', 'Barcelona', 'Barcelona'),
	('Calle de Balmes, 789', '08013', 'Barcelona', 'Barcelona'),
	('Calle de Urgell, 234', '08011', 'Barcelona', 'Barcelona'),
	('Plaza de Cataluña, 1', '08002', 'Barcelona', 'Barcelona');

-- clientes

insert into clientes (nombre, apellidos , direccion, cp , localidad , provincia, telf)values

	('Jordi' , 'Tello' ,'catalunya 76 3-2', 08110, 'montcada' ,'barcelona', 933112354) ,
	('Lucía', 'Martínez', 'Calle del Arco, 12', '28004', 'Madrid', 'Madrid', '912345678'),
	('Daniel', 'García', 'Calle Mayor, 34', '46001', 'Valencia', 'Valencia', '961234567'),
	('Ainhoa', 'Sánchez', 'Avenida de la Luna, 8', '29008', 'Málaga', 'Málaga', '952345678'),
	('Hugo', 'García', 'Calle de la Paloma, 23', '41001', 'Sevilla', 'Sevilla', '955678901'),
	('Sara', 'Hernández García', 'Calle del Sol, 23', '46001', 'Valencia', 'Valencia', '960123456'),
    ('José', 'García', 'Carrer de la Mercè', '08002', 'Barcelona', 'Barcelona', '612345678'),
	('Guillermo', 'Gutiérrez',' Carrer de Provença', 08003,' Barcelona',' Barcelona', '612345679'),
	('José', 'Rodríguez', 'Carrer de la Marina', 08004, 'Barcelona', 'Barcelona', '612345680'),
	('Carlos', 'Ramos',' Carrer de la Ronda de Dalt', 08005, 'Barcelona', 'Barcelona', '612345681'),
	('María', 'Pérez', 'Carrer de Pau Casals', 08007, 'Barcelona', 'Barcelona', '612345682'),
	('Javier', 'Sánchez',' Carrer dels Angels', 08009,' Barcelona', 'Barcelona', '612345683'),
	('Ana', 'López',' Carrer de la Llacuna', 08010, 'Barcelona', 'Barcelona', '612345684'),
	('Nuria', 'Martín', 'Carrer de la Pau', 08011, 'Barcelona', 'Barcelona', '612345685'),
	('David', 'Gómez',' Carrer de la Granada', 08012, 'Barcelona',' Barcelona',' 612345686'),
	('Raúl', 'Rivero',' Carrer de les Acàcies', 08013, 'Barcelona',' Barcelona', '612345687');

    
-- empleados
INSERT INTO empleados (nombre, apellido, nif, telefono)VALUES

  ('Ana', 'Martínez Gómez', '12345678Z', '912345678','cocinero'),
  ('Pedro', 'García López', '87654321A', '678901234','repartidor'),
  ('María', 'Hernández García', '56789012B', '654321098','repartidor' ),
  ('Jorge', 'Sánchez Ruiz', '23456789C', '789012345','cocinero'),
  ('Sara', 'Gómez Navarro', '90123456D', '567890123','repartidor');
  
;