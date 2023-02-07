-- Obter os nomes dos produtos 

select nombre 
from articulos;


-- Obter os nomes e prezos dos produtos

select nombre, precio 
from articulos; 


-- Obter o nome dos produtos que te�an un prezo menor ou igual a 200�

select nombre, precio 
from articulos 
where precio >= 200;


-- Obter os datos dos artigos que te�en un prezo entre 60 e 120� (ambas as d�as incluidas)

select * 
from articulos 
where precio between 60 and 120;


-- Obter o nome e o prezo en pesetas de t�dolos artigos (o prezo en � multiplicado por 166,386)

select nombre, precio*166,386 
from articulos;


-- Obter o prezo medio de t�dolos produtos

select avg (precio) 
from articulos;


-- Obter o prezo medio dos produtos que te�en un 2 no c�digo de fabricante

select avg (precio) 
from articulos 
where fabricante=2;


-- Obter o n�mero de artigos que te�en un prezo maior ou igual a 180�

select count (*) 
from articulos
where precio >= 180;


-- Obter o nome e prezo dos artigos que te�en un prezo maior ou igual a 180� ordenados de maior a menor por prezo e por orde alfab�tica do nome

select nombre, precio 
from articulos 
where precio >=180 
order by precio desc, nombre asc;


-- Obter un listado de artigos incluindo por cada un deles os datos do artigo e do seu fabricante

select a.*, b.* 
from articulos a, fabricantes b 
where a.fabricante=b.codigo;


-- Obter un listado de artigos co seu nome, prezo e nome do fabricante

select a.*, b.nombre 
from articulos a, fabricantes b 
where a.fabricante=b.codigo;


-- Obter o prezo medio dos produtos de cada fabricante amosando s� os c�digos de fabricante.

select a.nombre, b.codigo, avg (precio) as prezo_medio 
from articulos a, fabricantes b 
where a.fabricante=b.codigo;


-- Obter o prezo medio dos produtos de cada fabricante amosando o nome do fabricante


-- Obter os nomes dos fabricantes que ofrezan produtos cun prezo maior ou igual a 150�


-- Obter o nome e  prezo do artigo m�is barato


-- Obter unha lista co nome e prezo dos artigos m�is caros de cada proveedor (incluindo o nome do proveedor na lista)


-- Engadir un novo produto: altofalantes de 70� do fabricante 2


-- Cambiar o nome do produto 8 a "impresora l�ser"


-- Aplicar un desconto do 10% (multiplicar por 0.9) a todos os produtos


-- Aplicar un desconto do 10% (multiplicar por 0.9) a todos os produtos cun prezo maior ou igual a 120�

