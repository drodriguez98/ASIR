-- Obter os apelidos dos empregados

select apellidos from empleados;


-- Obter os apelidos dos empregados sen repetición 

select distinct apellidos from empleados;


--  Obter os datos de todos os empregados que se apelidan 'López'

select * from empleados where apellidos = 'López';


--  Obter os datos de todos os empregados que se apelidan 'López' ou 'Pérez'

select * from empleados where apellidos = 'López' or apellidos = 'Pérez';


--  Obter os datos de todos os empregados que traballan no departamento 14

select * from empleados where departamento = 14


--  Obter os datos de todos os empregados que traballan no departamento 37 e tamén no 77

select * from empleados where departamento = 37 and departamento = 77;


--  Obter os datos de todos os empregados que teñan a letra 'p' como inicial do seu apelido

select * from empleados where apellidos like 'P%';


--  Obter o presuposto total de todos os departamentos

select sum(presupuesto) as total from departamentos;


--  Obter o número de empregados de cada departamento


--  Obter un listado completo de empregados incluindo por cada un deles todos os datos do empregado e do seu departamento


--  Obter un listado completo de empregados incluindo o nome e apelidos do empregado xunto co nome e presuposto do seu departamento


--  Obter o nome e apelidos dos empregados que traballan en departamentos cun presuposto maior a 60.000€


--  Obter os datos dos departamentos cun presuposto maior ao presuposto medio de todos os departamentos


--  Obter os nomes dos departamentos con máis de dous empregados


--  Engadir unha empregada chamada Esther Vázquez e con dni 77065123Z


--  Aplicar un recorte presupuestario do 10% a todos os departamentos


--  Reasignar aos empregados de investigación (código 77) ao departamento de informática (código 14)


--  Despedir a todos os empregados que traballan no departamento de informática (código 14)


--  Despedir a todos os empregados que traballan no departamento de contabilidade (código 14)


--  Despedir a todos os empregados que traballan en departamentos cun presuposto superior aos 60.000€ (código 14)


--  Despedir a todos os empregados



-- ** SON SOLUCIONES PERDIDAS **

select max(presupuesto) as maximo from departamentos where codigo < 30;

select count(nombre) as conta from departamentos;

select count(distinct apellidos) as conta from empleados;




