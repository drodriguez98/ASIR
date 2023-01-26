SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE TABLE `clases` (
  `codigo` char(3) NOT NULL,
  `grupo` varchar(20) NOT NULL,
  `nombre_tutor` varchar(40) DEFAULT NULL,
  `puntuacion` int(10) UNSIGNED DEFAULT NULL,
  `capitan` char(7) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `clases` (`codigo`, `grupo`, `nombre_tutor`, `puntuacion`, `capitan`) VALUES
('E1A', '1 ESO A', 'FEDERICO PEREZ', 6, 'E1A016'),
('E1B', '1 ESO B', 'TERESA CANO', 2, 'E1B016'),
('E2A', '2 ESO A', 'JAVIER GONZALEZ', 0, 'E2A655'),
('E2B', '2 ESO B', 'PATRICIA SANCHEZ', 4, 'E2B696');

CREATE TABLE `jugadores` (
  `codalumno` char(7) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `apellido` varchar(20) NOT NULL,
  `tantos_marcados` smallint(5) UNSIGNED DEFAULT 0,
  `puesto` tinyint(3) UNSIGNED NOT NULL,
  `clase` char(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `jugadores` (`codalumno`, `nombre`, `apellido`, `tantos_marcados`, `puesto`, `clase`) VALUES
('E1A016', 'ALBUS', 'DEKA', 16, 4, 'E1A'),
('E1A603', 'ENRIQUE', 'ALFARERO', 16, 2, 'E1A'),
('E1A666', 'OLGA', 'SCOTT', 16, 3, 'E1A'),
('E1A689', 'JOHNNY', 'BERTO', 16, 5, 'E1A'),
('E1A776', 'MELVIN', 'SQUIRRELS', 20, 1, 'E1A'),
('E1A777', 'ALEPH', 'ONSO', 16, 3, 'E1A'),
('E1A888', 'PAUVAR', 'ELA', 16, 1, 'E1A'),
('E1B016', 'SEVERIUS', 'STUKA', 16, 4, 'E1B'),
('E1B603', 'DRACO', 'MALFOY', 16, 1, 'E1B'),
('E1B666', 'ALF', 'MELMAC', 16, 3, 'E1B'),
('E1B689', 'LORDDARTH', 'VADER', 16, 1, 'E1B'),
('E1B776', 'MELVIN', 'MCFLY', 20, 2, 'E1B'),
('E1B777', 'RUCH', 'WORTH', 16, 3, 'E1B'),
('E1B996', 'NAZARIUS', 'FLINT', 16, 1, 'E1B'),
('E2A606', 'ANNA', 'KARENINA', 16, 1, 'E2A'),
('E2A655', 'MORGANA', 'PENDRAGON', 16, 1, 'E2A'),
('E2A666', 'MEPHISTO', 'ROZCO', 16, 3, 'E2A'),
('E2A676', 'MELQUIADES', 'BUHO', 20, 2, 'E2A'),
('E2A686', 'GIOVANNI', 'BERTUCCIO', 16, 5, 'E2A'),
('E2A696', 'AL', 'DEGEA', 16, 4, 'E2A'),
('E2A766', 'MERLIN', 'WIZARD', 16, 3, 'E2A'),
('E2B606', 'OSKAR', 'KRUM', 16, 1, 'E2B'),
('E2B626', 'PHIL', 'LIP', 16, 3, 'E2B'),
('E2B636', 'LINUS', 'STROMBERG', 16, 1, 'E2B'),
('E2B666', 'EMMET', 'BROWN', 16, 3, 'E2B'),
('E2B676', 'PAUL', 'FONTOFTHE', 20, 2, 'E2B'),
('E2B686', 'ANGEL', 'BIGTABLES', 16, 5, 'E2B'),
('E2B696', 'TITTO', 'LOPEZ', 16, 4, 'E2B');

CREATE TABLE `puestos` (
  `codigo` tinyint(3) UNSIGNED NOT NULL,
  `nombre` varchar(10) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `puestos` (`codigo`, `nombre`, `descripcion`) VALUES
(1, 'BASE', NULL),
(2, 'ALERO', NULL),
(3, 'ALA-PIVOT', NULL),
(4, 'PIVOT', NULL),
(5, 'ESCOLTA', NULL);

ALTER TABLE `clases`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `capitan` (`capitan`);
  
ALTER TABLE `jugadores`
  ADD PRIMARY KEY (`codalumno`),
  ADD KEY `clase` (`clase`),
  ADD KEY `puesto` (`puesto`);

ALTER TABLE `puestos`
  ADD PRIMARY KEY (`codigo`);

ALTER TABLE `puestos`
  MODIFY `codigo` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `clases`
  ADD CONSTRAINT `clases_ibfk_1` FOREIGN KEY (`capitan`) REFERENCES `jugadores` (`codalumno`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `jugadores`
  ADD CONSTRAINT `jugadores_ibfk_1` FOREIGN KEY (`clase`) REFERENCES `clases` (`codigo`) ON UPDATE CASCADE,
  ADD CONSTRAINT `jugadores_ibfk_2` FOREIGN KEY (`puesto`) REFERENCES `puestos` (`codigo`) ON UPDATE CASCADE;
COMMIT;
