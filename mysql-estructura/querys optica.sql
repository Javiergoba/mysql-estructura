SELECT * FROM cliente;
select compra.ticket, id_cliente from detalle_compra compra where id_cliente = 3;
select id_empleado from empleado where empleado.id_empleado = cliente.atendido ;