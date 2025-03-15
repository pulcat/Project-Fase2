--Usamos la categor�a "Snacks" por convenciencia en vez de "Chucher�as"
SELECT
	Producto.nombre "Nombre",
	Producto.precioPor "Precio Normal",
	(CAST(Producto.precioPor AS float) * 0.9) "Precio con Descuento",
	CASE
		WHEN Inventario.cantidad < 10 THEN '�ltimos Disponibles'
		WHEN Inventario.cantidad < 20 THEN 'Pocos Disponibles'
		ELSE 'Disponible'
	END AS Stock
	FROM Producto
	JOIN Inventario on Inventario.productoId = Producto.id
	WHERE Producto.categoriaId = 6