-- 1. Mostrar os datos dos empregados que pertenzan ao mesmo departamento que GIL

select * from emple where dept_no in (select dept_no from emple where apellido='GIL');

-- 2. Mostrar os datos dos empregados que te�an o mesmo oficio que 'CERDEIRA'. O resultado debe ir ordenado por apelido.



-- 3. Mostrar os empregados (nome, oficio, salario e data de alta) que desempe�en o mesmo oficio que 'JIM�NEZ' ou que te�an un salario maior ou igual que 'FERN�NDEZ'.



-- 4. Mostrar en pantalla o apelido, oficio e salario dos empregados do departamento de 'FERN�NDEZ' que te�an o seu mesmo salario.



-- 5. Mostrar os datos dos empregados que te�an un salario maior que 'GIL' e que pertenzan ao departamento n�mero 10.



-- 6. Mostrar os apelidos, oficios e localizaci�ns dos departamentos de cada un dos empregados.



-- 7. Seleccionar o apelido, o oficio e a localidade dos departamentos onde traballan os ANALISTAS.



-- 8. Seleccionar o apelido, o oficio e salario dos empregados que traballan en Madrid.



-- 9. Seleccionar o apelido, salario e localidade onde traballan dos empregados que te�an un salario entre 200000 e 300000.



-- 10. Mostrar o apelido, salario e nome do departamento dos empregados que te�an o mesmo oficio que 'GIL'.



-- 11. Mostrar o apelido, salario e nome do departamento dos empregados que te�an o mesmo oficio que 'GIL' e que non te�an comisi�n.



-- 12. Mostrar os datos dos empregados que traballan no departamento de contabilidade, ordenados por apelidos.



-- 13.Apelido dos empregados que traballan en Sevilla e cuxo oficio sexa analista ou empregado.



-- 14.Calcula o salario medio de todos os empregados.



-- 15.Cal � o m�ximo salario dos empregados do departamento 10?



-- 16.Calcula o salario m�nimo dos empregados do departamento 'VENDAS'.



-- 17.Calcula a media do salario dos empregados do departamento de 'CONTABILIDADE'.



-- 18.Mostrar os datos dos empregados cuxo salario sexa maior que a media de todos os salarios.



-- 19.Cantos empregados hai no departamento n�mero 10?



-- 20.Cantos empregados hai no departamento de 'VENDAS'?



-- 21.Calcula o n�mero de empregados que hai que non te�en comisi�n.



-- 22.Seleccionar o apelido do empregado que ten m�ximo salario.



-- 23.Mostrar os apelidos do empregado que ten o salario m�is baixo.



-- 24.Mostrar os datos do empregado que ten o salario m�is alto no departamento de 'VENDAS'.



-- 25.A partir da t�boa EMPLE visualizar cantos apelidos dos empregados empezan pola letra 'A'.



-- 26.Dada a t�boa EMPLE, obter o soldo medio, o n�mero de comisi�ns non nulas, o m�ximo soldo e o soldo m�nimo dos empregados do departamento 30

