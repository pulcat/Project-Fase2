SELECT distinct Producto.nombre "Nombre", Categoria.nombre "Categoria", Marca.nombre "Marca"
FROM Producto
join Categoria on Categoria.id = Producto.categoriaId
join Marca on Marca.id = Producto.marcaId
join ProductoRecomendadoParaCliente on ProductoRecomendadoParaCliente.productoRecomendadoId = Producto.id
join Factura on Factura.clienteId = ProductoRecomendadoParaCliente.clienteId
join Carrito on Carrito.productoId = ProductoRecomendadoParaCliente.productoRecomendadoId
WHERE DATEADD(day, 30, fechaEmision) >= GETDATE() AND ProductoRecomendadoParaCliente.clienteId != Carrito.clienteId