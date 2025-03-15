CREATE PROCEDURE EvaluatePromo @PromoId int
AS
BEGIN

DECLARE @MontoAntes int
DECLARE @ConteoAntes int
DECLARE @MontoDespues int
DECLARE @ConteoDespues int

--Total en Ventas Antes de la Promo
SELECT @MontoAntes = SUM(Factura.montoTotal) FROM Factura WHERE
DATEDIFF(MONTH, Factura.fechaEmision, (select fechaInicio from Promo where Promo.id = @PromoId)) <= 6 AND
Factura.fechaEmision < (select fechaInicio from Promo where Promo.id = @PromoId)


--Conteo de Vemtas Antes de la Promo
SELECT @ConteoAntes = COUNT(*) FROM Factura WHERE
DATEDIFF(MONTH, Factura.fechaEmision, (select fechaInicio from Promo where Promo.id = @PromoId)) <= 6 AND
Factura.fechaEmision < (select fechaInicio from Promo where Promo.id = @PromoId)


--Total en Ventas Después de la Promo
SELECT @MontoDespues = SUM(Factura.montoTotal) FROM Factura WHERE
Factura.fechaEmision > (select fechaInicio from Promo where Promo.id = @PromoId) AND
Factura.fechaEmision < (select fechaFin from Promo where Promo.id = @PromoId)

--Conteo de Vemtas Después de la Promo
SELECT @ConteoDespues = COUNT(*) FROM Factura WHERE
Factura.fechaEmision > (select fechaInicio from Promo where Promo.id = @PromoId) AND
Factura.fechaEmision < (select fechaFin from Promo where Promo.id = @PromoId)

PRINT 'Monto total de Ventas antes de la promo: ' + cast(@MontoAntes AS VARCHAR(32))
PRINT 'Conteo de Ventas antes de la promo: ' + cast(@ConteoAntes AS VARCHAR(32))
PRINT 'Monto total de Ventas después de la promo: ' + cast(@MontoDespues AS VARCHAR(32))
PRINT 'Conteo de Ventas después de la promo: ' + cast(@ConteoDespues AS VARCHAR(32))
PRINT 'Relación Porcentual entre ambos totales ' + cast(
ROUND(CAST(@MontoDespues AS FLOAT) / CAST(@MontoAntes AS FLOAT) * 100, 2)
AS VARCHAR(32)) + '%'
PRINT 'Relación Porcentual entre el conteo de ambos ' + cast(
ROUND(CAST(@ConteoDespues AS FLOAT) / CAST(@ConteoAntes AS FLOAT) * 100, 2)
AS VARCHAR(32)) + '%'

END