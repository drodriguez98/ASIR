CREATE TABLE `notasexamenes` (`id` int(11) NOT NULL, `idalumno` int(11) NOT NULL, `idmateria` int(11) NOT NULL, `nota1` decimal(10,2) NOT NULL, `nota2` decimal(10,2) NOT NULL, `nota3` decimal(10,2) NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `notasexamenes` ADD PRIMARY KEY (`id`);
INSERT INTO `notasexamenes` (`id`, `idalumno`, `idmateria`, `nota1`, `nota2`, `nota3`) VALUES (1, 1000, 1, '8.00', '9.25', '7.00'), (2, 1001, 1, '6.33', '8.50', '8.00'), (3, 1002, 1, '10.00', '7.50', '8.33'), (4, 1003, 2, '4.50', '2.00', '5.50'), (5, 1004, 1, '3.50', '2.00', '2.00');
