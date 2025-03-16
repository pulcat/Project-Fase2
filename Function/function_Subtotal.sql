CREATE FUNCTION Subtotal (@FacturaIden int)
Returns INT
as
BEGIN
DECLARE @COST INT;
SELECT @COST=fd.cantidad*fd.precioPor
From FacturaDetalle fd, Factura fa
WHERE @FacturaIden=fa.id AND fa.id=fd.facturaId
Return @COST
END;
GO