CREATE TRIGGER trg_ProductoRecomendadoParaCliente_busqueda
ON HistorialClienteProducto
AFTER INSERT
AS
BEGIN
    -- Insertar productos recomendados solo si se alcanzan 3 búsquedas
    INSERT INTO ProductoRecomendadoParaCliente (clienteId, productoRecomendadoId, fechaRecomendacion, mensaje)
    SELECT i.clienteId, i.productoId, GETDATE(), 'Buscó más de 3 veces este producto'
    FROM (
        SELECT clienteId, productoId
        FROM HistorialClienteProducto
        WHERE tipoAccion = 'Busqueda'
        GROUP BY clienteId, productoId
        HAVING COUNT(*) >= 3
    ) AS i
    WHERE EXISTS (
        SELECT 1
        FROM inserted ins
        WHERE ins.clienteId = i.clienteId AND 
		ins.productoId = i.productoId
    );
END;