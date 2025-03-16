CREATE FUNCTION costoEnvio (@OrdenIden int)
Returns INT
as
BEGIN
DECLARE @COST INT;
SELECT @COST=te.costoEnvio
From OrdenOnline oo, TipoEnvio te
WHERE @OrdenIden=oo.id AND oo.tipoEnvioId=te.id
Return @COST
END;
GO