-- trigger HistorialClienteProducto
CREATE TRIGGER trg_insertHistorialClienteProducto
ON Carrito
AFTER INSERT
AS
BEGIN
		INSERT INTO HistorialClienteProducto (clienteId, productoId, fecha, tipoAccion)
		SELECT i.clienteId, i.productoId, i.fechaAgregado , 'Carrito'
		FROM inserted i 
END