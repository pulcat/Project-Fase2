 --(si el cliente compra o busca m�s de 3 veces 
--un producto en espec�fico, buscar productos 
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
		SELECT i.clienteId, i.productoId, i.fecha , 'Busco m�s de 3 productos'
		FROM inserted i 
	END
END