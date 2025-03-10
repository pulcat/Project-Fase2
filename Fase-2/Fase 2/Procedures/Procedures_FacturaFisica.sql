CREATE PROCEDURE CrearFacturaFisica @Cliente int,  @Empleado int
AS
BEGIN

INSERT INTO Factura VALUES (GETDATE(), @Cliente, NULl, NULL, NULL, NULL, NULL)
DECLARE @FacturaId int
SET @FacturaId = IDENT_CURRENT('Factura')
INSERT INTO VentaFisica VALUES (@FacturaId, 1, @Empleado)

END;