CREATE TABLE ProveedorProducto (
    id INT IDENTITY(1,1) PRIMARY KEY,
    proveedorId INT NOT NULL,
    productoId INT NOT NULL,
    fechaCompra DATETIME NOT NULL,
    precioPor DECIMAL(10, 2) CHECK (precioPor >= 0),
    cantidad INT CHECK (cantidad >= 0),
    FOREIGN KEY (proveedorId) REFERENCES Proveedor(id),
    FOREIGN KEY (productoId) REFERENCES Producto(id)
);