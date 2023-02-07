-- 1. Mostrar os datos dos empregados que pertenzan ao mesmo departamento que GIL

select * from emple where dept_no in (select dept_no from emple where apellido='GIL');

-- 2. Mostrar os datos dos empregados que teñan o mesmo oficio que 'CERDEIRA'. O resultado debe ir ordenado por apelido.



-- 3. Mostrar os empregados (nome, oficio, salario e data de alta) que desempeñen o mesmo oficio que 'JIMÉNEZ' ou que teñan un salario maior ou igual que 'FERNÁNDEZ'.



-- 4. Mostrar en pantalla o apelido, oficio e salario dos empregados do departamento de 'FERNÁNDEZ' que teñan o seu mesmo salario.



-- 5. Mostrar os datos dos empregados que teñan un salario maior que 'GIL' e que pertenzan ao departamento número 10.



-- 6. Mostrar os apelidos, oficios e localizacións dos departamentos de cada un dos empregados.



-- 7. Seleccionar o apelido, o oficio e a localidade dos departamentos onde traballan os ANALISTAS.



-- 8. Seleccionar o apelido, o oficio e salario dos empregados que traballan en Madrid.



-- 9. Seleccionar o apelido, salario e localidade onde traballan dos empregados que teñan un salario entre 200000 e 300000.



-- 10. Mostrar o apelido, salario e nome do departamento dos empregados que teñan o mesmo oficio que 'GIL'.



-- 11. Mostrar o apelido, salario e nome do departamento dos empregados que teñan o mesmo oficio que 'GIL' e que non teñan comisión.



-- 12. Mostrar os datos dos empregados que traballan no departamento de contabilidade, ordenados por apelidos.



-- 13.Apelido dos empregados que traballan en Sevilla e cuxo oficio sexa analista ou empregado.



-- 14.Calcula o salario medio de todos os empregados.



-- 15.Cal é o máximo salario dos empregados do departamento 10?



-- 16.Calcula o salario mínimo dos empregados do departamento 'VENDAS'.



-- 17.Calcula a media do salario dos empregados do departamento de 'CONTABILIDADE'.



-- 18.Mostrar os datos dos empregados cuxo salario sexa maior que a media de todos os salarios.



-- 19.Cantos empregados hai no departamento número 10?



-- 20.Cantos empregados hai no departamento de 'VENDAS'?



-- 21.Calcula o número de empregados que hai que non teñen comisión.



-- 22.Seleccionar o apelido do empregado que ten máximo salario.



-- 23.Mostrar os apelidos do empregado que ten o salario máis baixo.



-- 24.Mostrar os datos do empregado que ten o salario máis alto no departamento de 'VENDAS'.



-- 25.A partir da táboa EMPLE visualizar cantos apelidos dos empregados empezan pola letra 'A'.



-- 26.Dada a táboa EMPLE, obter o soldo medio, o número de comisións non nulas, o máximo soldo e o soldo mínimo dos empregados do departamento 30

