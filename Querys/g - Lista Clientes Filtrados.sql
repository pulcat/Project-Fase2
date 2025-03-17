use gamma;

WITH BuyCategories AS (
SELECT Cliente.id
FROM Cliente
join OrdenOnline on OrdenOnline.clienteId = Cliente.id
join Factura on Factura.id = OrdenOnline.facturaId
join FacturaDetalle on FacturaDetalle.facturaId = Factura.id
join Producto on Producto.id = FacturaDetalle.productoId
join Categoria on Categoria.id = Producto.categoriaId
WHERE Categoria.nombre = 'Hogar'
GROUP BY Cliente.id
--All their products are from the selected Categories

INTERSECT

SELECT Cliente.id
FROM Cliente
join OrdenOnline on OrdenOnline.clienteId = Cliente.id
join Factura on Factura.id = OrdenOnline.facturaId
join FacturaDetalle on FacturaDetalle.facturaId = Factura.id
join Producto on Producto.id = FacturaDetalle.productoId
join Categoria on Categoria.id = Producto.categoriaId
WHERE Categoria.nombre = 'Electronica'
GROUP BY Cliente.id
--All their products are from the selected Categories

), BuyWithCart AS (
SELECT Cliente.id
--, Categoria.nombre, Factura.fechaEmision
FROM Cliente
join OrdenOnline on OrdenOnline.clienteId = Cliente.id
join Pago on Pago.facturaId = OrdenOnline.facturaId
WHERE Pago.metodoPagoId = 1
)

SELECT Cliente.id
--, Categoria.nombre, Factura.fechaEmision
, COUNT(OrdenOnline.id) "Compras", SUM(Factura.montoTotal) "Total Gastado" 
FROM Cliente
join OrdenOnline on OrdenOnline.clienteId = Cliente.id
join Factura on Factura.id = OrdenOnline.facturaId
join FacturaDetalle on FacturaDetalle.facturaId = Factura.id
join Producto on Producto.id = FacturaDetalle.productoId
join Categoria on Categoria.id = Producto.categoriaId
join BuyCategories on BuyCategories.id = Cliente.id
join BuyWithCart on BuyWithCart.id = Cliente.id
WHERE
	DATEADD(month, 6, Factura.fechaEmision) >= GETDATE()
GROUP BY Cliente.id
HAVING COUNT(OrdenOnline.id) >= 3 AND SUM(Factura.montoTotal) > (SELECT AVG(montoTotal) FROM Factura WHERE DATEADD(month, 6, Factura.fechaEmision) >= GETDATE())



