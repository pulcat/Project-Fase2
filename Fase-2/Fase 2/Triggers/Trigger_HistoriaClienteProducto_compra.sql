-- trigger HistorialClienteProducto
CREATE TRIGGER trg_insertHistorialClienteProducto_compra
ON FacturaDetalle
AFTER INSERT
AS
BEGIN
		INSERT INTO HistorialClienteProducto (clienteId, productoId, fecha, tipoAccion)
		SELECT fa.clienteId, i.productoId, fa.fechaEmision , 'Compra'
		FROM inserted i , Factura fa
		WHERE i.facturaId = fa.id
END