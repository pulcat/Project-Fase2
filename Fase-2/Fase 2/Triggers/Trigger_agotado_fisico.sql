CREATE TRIGGER agotados_factura
ON FacturaDetalle
AFTER INSERT
AS
BEGIN
 DECLARE @CantidadInventario INT;
 DECLARE @CantidadOrden INT;

SELECT @CantidadInventario=iv.cantidad, @CantidadOrden=i.cantidad
FROM inserted i, Producto p, Inventario iv
Where i.productoId=p.id and p.id=iv.productoId

IF @CantidadInventario = 0
BEGIN
rollback transaction
print('El producto no está disponible por los momentos');
END
ELSE
BEGIN
IF @CantidadInventario<@CantidadOrden
rollback transaction
print('No hay unidades suficientes del producto para esta compra');
END
END