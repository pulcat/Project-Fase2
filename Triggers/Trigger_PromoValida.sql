CREATE TRIGGER tr_verificadorpromo
ON FacturaPromo
AFTER INSERT
AS
BEGIN

	DECLARE @TipoCompra varchar(20);
	DECLARE @FechaFinPromo date;
    DECLARE @FechaEmisionFactura date;
    DECLARE @TipoPromocion varchar(20);

	IF NOT EXISTS (SELECT vf.facturaId
		FROM Factura f , Promo p , VentaFisica vf , OrdenOnline oo , inserted i
		WHERE i.facturaId = f.id AND f.id = vf.facturaId)
		SET @TipoCompra='Online';
		ELSE
		SET @TipoCompra='Fisica';

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