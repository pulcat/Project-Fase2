CREATE FUNCTION TOTAL (@FacturaIden int, @OrdenIden int)
Returns INT
as
BEGIN
DECLARE @COST INT;
SET @COST= (dbo.Subtotal(@FacturaIden)-dbo.Descuento(@FacturaIden))+dbo.IVA(@FacturaIden)+dbo.costoEnvio(@OrdenIden)
RETURN @COST
END;
GO