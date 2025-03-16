CREATE FUNCTION IVA (@FacturaIden int)
Returns INT
as
BEGIN
DECLARE @COST INT;
DECLARE @EXENTO BIT;
SELECT @COST=((dbo.subtotal(@FacturaIden)-dbo.Descuento(@FacturaIden))/100)*fa.porcentajeIVA, @EXENTO=pp.esExentoIVA
From FacturaDetalle fd, Factura fa, Producto pp
WHERE @FacturaIden=fa.id AND fa.id=fd.facturaId and fd.productoId=pp.id
IF @EXENTO=1
BEGIN
set @COST=0;
END
Return @COST
END;
GO