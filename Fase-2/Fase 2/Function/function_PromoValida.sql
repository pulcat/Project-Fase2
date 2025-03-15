CREATE FUNCTION promo_valida (@Datepromo date, @DateFactura date, @TipoCompra varchar(20), @TipoPromo varchar(20))
RETURNS bit
as
BEGIN
DECLARE @CONTROL bit;
	IF @DateFactura <= @Datepromo AND (@TipoCompra = @TipoPromo OR @TipoPromo='Ambos')
	SET @CONTROL=1;
	ELSE 
	SET @CONTROL=0;
	RETURN @CONTROL
END;
GO