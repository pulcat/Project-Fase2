-- trigger producto 30%
Create trigger trg_producto_30
ON ProveedorProducto
AFTER INSERT
AS
BEGIN
	UPDATE PRODUCTO
	SET PrecioPor = i.precioPor + (i.precioPor/100)*30
	From inserted i, Producto pv
	Where i.productoId=pv.id
END