SELECT TOP (10) Producto.nombre "Nombre", cantidad "Cantidad", precioTotal "Precio Total",
	CAST(precioTotal*100.00 / (SELECT CAST(SUM(montoTotal) AS float) FROM Factura) AS varchar(32)) + '%' "Relación Ventas" 
	FROM 
	(
	SELECT
		Producto.id,
		SUM(cantidad) cantidad, 
		CAST(SUM(FacturaDetalle.precioPor) AS float) precioTotal
	FROM FacturaDetalle
	JOIN Producto on Producto.id = FacturaDetalle.productoId
	GROUP BY Producto.id
	) AS T1
	JOIN Producto ON Producto.id = T1.id
	ORDER BY cantidad DESC