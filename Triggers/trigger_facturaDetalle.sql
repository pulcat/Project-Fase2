CREATE TRIGGER tr_facturaDetalle
ON OrdenDetalle
AFTER INSERT 
AS 
BEGIN
    -- Insertar en FacturaDetalle copiando los detalles de OrdenDetalle
    INSERT INTO FacturaDetalle (facturaId, productoId, cantidad, precioPor)
    SELECT ordenO.facturaId , ins.productoId, ins.cantidad, ins.precioPor
    FROM inserted ins 
    JOIN OrdenOnline ordenO ON ins.ordenid = ordenO.Id
END;