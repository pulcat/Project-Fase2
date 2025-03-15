CREATE PROCEDURE ComprarCarrito @Cliente int
AS
BEGIN
DECLARE @ProductId int
DECLARE @Fecha datetime
DECLARE @Cantidad int
DECLARE @Precio int
DECLARE @MontoTotal int
SET @MontoTotal = 0

INSERT INTO Factura VALUES (GETDATE(), @Cliente, null, null, null, null, 0)
DECLARE @FacturaId int
SET @FacturaId = IDENT_CURRENT('Factura')

INSERT INTO OrdenOnline VALUES (@Cliente, null, GETDATE(), 1, @FacturaId)
DECLARE @OrdenId int
SET @OrdenId = IDENT_CURRENT('OrdenOnline')

INSERT INTO Pago VALUES(@FacturaId, FLOOR(RAND()*10000 +1), 1)

DECLARE cursor_Carrito CURSOR
    FOR SELECT productoId, fechaAgregado, cantidad, precioPor FROM Carrito WHERE clienteId = @Cliente
OPEN cursor_Carrito
    FETCH NEXT FROM cursor_Carrito into @ProductId, @Fecha, @Cantidad, @Precio
		
    WHILE @@FETCH_STATUS=0
	BEGIN
		PRINT 
		   'ProductId: ' + cast(@ProductId as varchar(10)) + 
		' | Fecha: ' + cast(@Fecha as varchar(32)) +
		' | Cantidad: ' + cast(@Cantidad as varchar(10)) +
		' | Precio: ' + cast(@Precio as varchar(10))

		INSERT INTO FacturaDetalle VALUES (@FacturaId, @ProductId, @Cantidad, @Precio)
		INSERT INTO OrdenDetalle VALUES (@OrdenId, @ProductId, @Cantidad, @Precio)
		SET @MontoTotal = @MontoTotal + @Precio

		FETCH NEXT FROM cursor_Carrito into @ProductId, @Fecha, @Cantidad, @Precio
	END;

UPDATE Factura
SET montoTotal = @MontoTotal
WHERE Factura.id = @FacturaId;

CLOSE cursor_Carrito
DEALLOCATE cursor_Carrito
    END;