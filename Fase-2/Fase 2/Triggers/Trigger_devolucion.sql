CREATE TRIGGER devolucion
ON FacturaDetalle
AFTER DELETE 
AS
BEGIN
UPDATE Inventario
	Set cantidad = iv.cantidad + d.cantidad
	FROM Producto p, Inventario iv, deleted d
	WHERE d.productoId=p.id and p.id=iv.productoId
END