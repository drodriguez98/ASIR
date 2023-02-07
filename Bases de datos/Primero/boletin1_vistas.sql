create view mas_vendidos as
select a.id, a.nome as produto 
from produtos a, detalle_pedido b
where a.id=b.id_produto group by a.id, a.nome order by sum(cantidade) desc;

create view produto_cliente as
select a.nome as cliente, c.nome as produto
from clientes a, pedidos  b, produtos c, detalle_pedido d
where a.id=b.id_cliente and b.id=d.id_pedido and c.id=d.id_produto 
group by a.nome, c.nome;

