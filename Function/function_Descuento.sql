CREATE FUNCTION Descuento (@FacturaIden int)
Returns INT
as
BEGIN
DECLARE @COST INT;
DECLARE @TIPO varchar(20)
SELECT @COST=pp.valorDescuento, @TIPO=pp.tipoDescuento
From FacturaPromo fp, Factura fa, Promo pp
WHERE @FacturaIden=fa.id AND fa.id=fp.facturaId AND pp.id=fp.promoId
if @TIPO='Fijo'
begin
Return @COST
End
Return (dbo.subtotal(@FacturaIden)/100)*@COST
END;
GO