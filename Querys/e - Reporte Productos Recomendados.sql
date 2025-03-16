WITH totalCompras AS (
SELECT Factura.clienteId clienteId, count(*) totalComprado FROM Factura
	join FacturaDetalle ON FacturaDetalle.facturaId = Factura.id
	join Producto ON Producto.id = FacturaDetalle.productoId
	GROUP BY Factura.clienteId
), totalRecomendaciones AS(
SELECT Factura.clienteId, count(*) totalRecomendado
	FROM Factura
	join FacturaDetalle ON FacturaDetalle.facturaId = Factura.id
	join Producto ON Producto.id = FacturaDetalle.productoId
	join ProductoRecomendadoParaCliente ON ProductoRecomendadoParaCliente.productoRecomendadoId = Producto.id
	join totalCompras on totalCompras.clienteId = Factura.clienteId
	WHERE fechaRecomendacion < fechaEmision
	GROUP BY Factura.clienteId	
)
SELECT Cliente.CI, Cliente.nombre, Cliente.sexo, 
		(totalComprado - totalRecomendado) "Nro. Productos no Recomendados",
		totalRecomendado "Nro. Productos Recomendados",
		CAST(totalRecomendado*100.00 / CAST(totalComprado AS float) AS varchar(32)) + '%' "Relación Productos Recomendados" 
FROM Cliente
join totalCompras on totalCompras.clienteId = Cliente.id
join totalRecomendaciones on totalRecomendaciones.clienteId = Cliente.id