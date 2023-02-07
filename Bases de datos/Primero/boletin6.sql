-- Ex 5. Obter os nomes das pezas subministradas polo proveedor co código HAL

select a.nombre from piezas a, suministra b 
where a.codigo=b.codigopieza and b.idproveedor='HAL';


-- Ex 6. Obter os nomes dos proveedores que subministran as pezas máis caras, indicando o nome da peza e o prezo ao que se subministra

select distinct c.nombre, a.nombre as pieza, b.precio 
from proveedores c, suministra b, piezas a 
where a.codigo=b.codigopieza and c.id=b.idproveedor and b.precio in (select max(precio) from suministra where codigopieza=a.codigo);