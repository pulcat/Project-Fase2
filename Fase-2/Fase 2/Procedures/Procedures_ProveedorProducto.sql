CREATE PROCEDURE ComprarProductoProveedor @Proveedor int, @Producto int, @Precio int, @Cantidad int
AS
BEGIN
	PRINT 'Proveedor: ' + CAST(@Proveedor AS VARCHAR(10)) + ', Producto: ' + CAST(@Producto AS VARCHAR(10)) + ', Precio: ' + CAST(@Precio AS VARCHAR(10)) + ', Cantidad: ' + CAST(@Cantidad AS VARCHAR(10));
	INSERT INTO dbo.ProveedorProducto
	VALUES(@Proveedor, @Producto, GETDATE(), @Precio, @Cantidad)
END;

