CREATE DATABASE ventas;

USE ventas;

CREATE TABLE vendedores (id INT AUTO_INCREMENT PRIMARY KEY, nombre VARCHAR(30) NOT NULL, email VARCHAR(50), contacto VARCHAR(30));
CREATE TABLE ventas (id INT NOT NULL PRIMARY KEY, fecha DATE NOT NULL, coste id_vendedor int, CONSTRAINT fk_vend FOREIGN KEY (id_vendedor) REFERENCES vendedores(id) ON DELETE CASCADE ON UPDATE CASCADE);

INSERT INTO `vendedores` (`id`, `nombre`, `email`, `contacto`) VALUES (NULL, 'Kamal Hasan', 'kamal@gmail.com', '0191275634'), (NULL, 'Nila Hossain', 'nila@gmail.com', '01855342357'), (NULL, 'Abir Hossain', 'abir@yahoo.com', '01634235698');
INSERT INTO `ventas` (`id`, `fecha`, `coste`, `id_vendedor`) VALUES ('90', '2021-11-09', '800000', '1'),('34', '2020-12-15', '5634555', '3'), ('67', '2021-12-23', '900000', '1'), ('56', '2020-12-31', '6700000', '1');
