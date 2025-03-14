 --(si el cliente compra o busca más de 3 veces 
--un producto en específico, buscar productos 
--recomendados para ese producto y recomendarlos al cliente).

-- trigger ProductoRecomendadoParaCliente
CREATE TRIGGER trg_ProductoRecomendadoParaCliente
ON HistorialClienteProducto
AFTER INSERT
AS
BEGIN
	IF EXISTS (
	SELECT COUNT( i.productoId )
	FROM inserted i
	WHERE i.tipoAccion = 'Busqueda'
	HAVING COUNT(i.productoId) >= 3
	)
	BEGIN 
		INSERT INTO  ProductoRecomendadoParaCliente (clienteId, productoRecomendadoId, fechaRecomendacion, mensaje)
		SELECT i.clienteId, i.productoId, i.fecha , 'Busco más de 3 productos'
		FROM inserted i 
	END
END