CREATE TRIGGER tr_factura
ON OrdenOnline 
AFTER INSERT 
AS 
BEGIN	--tabla temporal 
	DECLARE @FacturaIDs TABLE (FacturaID INT);
	
    INSERT INTO Factura (fechaEmision, clienteId)
	--Guardar el ID de las nuevas facturas
    OUTPUT INSERTED.id INTO @FacturaIDs -- 
	
	SELECT ins.fechaCreacion,  ins.clienteId 
    FROM inserted ins;

	--actualiza el campo facturaid para que tenga el mismo id que la factura creada
	UPDATE oo
    SET oo.facturaId = f.FacturaID
    FROM OrdenOnline oo
    JOIN inserted ins ON oo.nroOrden = ins.nroOrden
    JOIN @FacturaIDs f ON f.FacturaID = ( SELECT MAX(FacturaID) 
											FROM @FacturaIDs); 
END ;
