CREATE TRIGGER InsertInventario
ON ProveedorProducto
AFTER INSERT
AS
BEGIN
    -- Verifica si no existe el producto en Inventario
    IF NOT EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Inventario inv ON i.productoId = inv.productoId
    )
    BEGIN 
        -- Inserta el producto en la tabla Inventario
        INSERT INTO Inventario ( productoId, cantidad)
        SELECT  i.productoId, i.cantidad
        FROM inserted i
        WHERE NOT EXISTS (
            SELECT 1
            FROM Inventario inv
            WHERE i.productoId = inv.productoId
        );
    END
	ELSE 
	BEGIN
			--si no existe suma el valor de cantidad 
			UPDATE Inventario
			SET cantidad = inv.cantidad + i.cantidad 
			FROM Inventario inv
			JOIN inserted i ON i.productoId = inv.productoId
	END
END