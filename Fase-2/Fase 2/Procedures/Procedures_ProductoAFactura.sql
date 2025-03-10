CREATE PROCEDURE ProductoAFactura @FacturaId int, @ProductoId int, @Cantidad int, @Precio intAS
BEGIN

INSERT INTO FacturaDetalle VALUES (@FacturaId, @ProductoId, @Cantidad, @Precio)

END;