CREATE TRIGGER verificador_promo
ON FacturaPromo
AFTER INSERT
AS
BEGIN

	DECLARE @TipoCompra varchar(20);
	DECLARE @FechaFinPromo date;
    DECLARE @FechaEmisionFactura date;
    DECLARE @TipoPromocion varchar(20);

	IF (SELECT vf.facturaId
		FROM Factura f , Promo p , VentaFisica vf , OrdenOnline oo , inserted i
		WHERE i.facturaId = f.id AND f.id = vf.facturaId)=null
		SET @TipoCompra='Online';
		ELSE
		SET @TipoCompra='Física';

	SELECT 
	@FechaFinPromo = p.fechaFin,
	@FechaEmisionFactura = f.fechaEmision,
	@TipoPromocion = p.tipoPromocion
	FROM Factura f, Promo p, VentaFisica vf, OrdenOnline oo, inserted i
	Where i.facturaId=f.id and i.PromoId=p.id;
	IF dbo.promo_valida(@FechaFinPromo, @FechaEmisionFactura, @TipoCompra, @TipoPromocion) = 0
	rollback transaction
	print('Promoción Invalida');

END