									-- tablas de ubicación 

IF NOT EXISTS ( --tabla Pais
    SELECT * 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_NAME = 'Pais'
)
BEGIN
    CREATE TABLE Pais (
        id INT IDENTITY(1,1) PRIMARY KEY,	-- Auto-incremental, comienza en 1 y va de 1 en 1 
        nombre NVARCHAR(255) NOT NULL		-- Asegura que 'nombre' no puede ser NULL
    );
END
	
IF NOT EXISTS ( --tabla Estado
    SELECT * 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_NAME = 'Estado'
)
BEGIN
    CREATE TABLE Estado (
        id INT IDENTITY(1,1) PRIMARY KEY,      -- Auto-incremental, comienza en 1 y se incrementa en 1
        nombre NVARCHAR(255) NOT NULL,          -- Asegura que 'nombre' no puede ser NULL
        paisId INT NOT NULL,                     -- Asegura que 'paisID' no puede ser NULL 
        FOREIGN KEY (paisId) REFERENCES Pais(id) -- Clave foránea que referencia a la tabla Pais
    );
END

IF NOT EXISTS ( --tabla Ciudad 
    SELECT * 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_NAME = 'Ciudad'
)
BEGIN
    CREATE TABLE Ciudad (
        id INT IDENTITY(1,1) PRIMARY KEY,    -- Auto-incremental, comienza en 1 y se incrementa en 1
        nombre NVARCHAR(255) NOT NULL,        -- Asegura que 'nombre' no puede ser NULL
        estadoId INT NOT NULL,                 -- Asegura que 'estadoID' no puede ser NULL
        FOREIGN KEY (estadoId) REFERENCES Estado(id)  -- Clave foránea que referencia a la tabla Estado
    );
END

									 --tabla de categorización de productos 

IF NOT EXISTS ( --tabla Marca
    SELECT * 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_NAME = 'Marca'
)
BEGIN
    CREATE TABLE Marca (
        id INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incremental, comienza en 1 y se incrementa en 1
        nombre NVARCHAR(255) NOT NULL ,      -- Asegura que 'nombre' no puede ser NULL
		descripcion NVARCHAR (255)
    );
END

IF NOT EXISTS ( --tabla Categoria
    SELECT * 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_NAME = 'Categoria'
)
BEGIN
    CREATE TABLE Categoria (
        id INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incremental, comienza en 1 y se incrementa en 1
        nombre NVARCHAR(255) NOT NULL ,       -- Asegura que 'nombre' no puede ser NULL
		descripcion NVARCHAR(255)
    );
END

IF NOT EXISTS ( --tabla Producto
	SELECT * 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_NAME = 'Producto')
BEGIN
    CREATE TABLE Producto (
        id INT IDENTITY(1,1) PRIMARY KEY,
        nombre NVARCHAR(255) NOT NULL,
        codigoBarra NVARCHAR(255) NOT NULL,
        descripcion NVARCHAR(255),
        tipoPrecio NVARCHAR(20) CHECK (tipoPrecio IN ('PorUnidad', 'PorPesoKg')),
        precioPor DECIMAL(10, 2),
        esExentoIVA BIT,
        categoriaId INT,			
        marcaId INT,
        FOREIGN KEY (categoriaId) REFERENCES Categoria(id),
        FOREIGN KEY (marcaId) REFERENCES Marca(id)
    );
END

									-- tabla de cliente y su info
IF NOT EXISTS ( --tabla Cliente
	SELECT * 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_NAME = 'Cliente')
BEGIN
    CREATE TABLE Cliente (
        id INT IDENTITY(1,1) PRIMARY KEY,
        CI INT CHECK (CI>= 0) ,
        nombre NVARCHAR(255) NOT NULL,
        apellido NVARCHAR(255),
        correo NVARCHAR(255),
        sexo CHAR(1) CHECK (sexo IN ('M', 'F')),
        fechaNacimiento DATE,
        fechaRegistro DATE
    );
END;

IF NOT EXISTS ( --tabla ClienteDireccion
	SELECT * 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_NAME = 'ClienteDireccion')
BEGIN
    CREATE TABLE ClienteDireccion (
        id INT IDENTITY(1,1) PRIMARY KEY,
        clienteId INT,						
        tipoDireccion NVARCHAR(20) CHECK (tipoDireccion IN ('Facturacion', 'Envio')), 
        dirLinea1 NVARCHAR(255),  
        ciudadId INT,						
        FOREIGN KEY (ciudadId) REFERENCES Ciudad(id),
        FOREIGN KEY (clienteId) REFERENCES Cliente(id)
    );
END;

									--tabla de empleados y sucursales 

IF NOT EXISTS ( -- tabla sucursal
    SELECT * 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_NAME = 'Sucursal'
)
BEGIN
    CREATE TABLE Sucursal (
        id INT IDENTITY(1,1) PRIMARY KEY,     -- Auto-incremental, comienza en 1 y se incrementa en 1
        nombre NVARCHAR(255) NOT NULL,         -- Asegura que 'nombre' no puede ser NULL
        horaAbrir TINYINT CHECK (horaAbrir >= 0 AND horaAbrir <= 23) NOT NULL,  -- Horario de apertura entre 0 y 23
        horaCerrar TINYINT CHECK (horaCerrar >= 0 AND horaCerrar <= 23) NOT NULL, -- Horario de cierre entre 0 y 23
        ciudadID INT NOT NULL,                  -- Asegura que 'ciudadID' no puede ser NULL 
        FOREIGN KEY (ciudadID) REFERENCES Ciudad(id) -- Clave foránea que referencia a la tabla Ciudad
    );
END

IF NOT EXISTS ( -- tabla Cargo 
	SELECT * 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_NAME = 'Cargo')
BEGIN
    CREATE TABLE Cargo (
        id INT IDENTITY(1,1) PRIMARY KEY,
        nombre NVARCHAR(255) NOT NULL,
        descripcion NVARCHAR(255),
        salarioBasePorHora DECIMAL(10, 2) CHECK (salarioBasePorHora >= 0 )
    );
END;

IF NOT EXISTS ( --tabla Empleado
	SELECT  *
    FROM    INFORMATION_SCHEMA.TABLES
    WHERE   TABLE_NAME = 'Empleado' )
BEGIN
    CREATE TABLE Empleado (
        id INT IDENTITY(1,1) PRIMARY KEY,
        CI NVARCHAR(20),				
        nombre NVARCHAR(255) NOT NULL,
        apellido NVARCHAR(255),
        sexo CHAR(1) CHECK (sexo IN ('M', 'F')),
        direccionCorta NVARCHAR(255),
        cargoId INT , 
        empleadoSupervisorId INT,
        sucursalId INT ,
        fechaContrato DATE,
        bonoFijoMensual DECIMAL(10,2),		
        horaInicio INT CHECK (horaInicio >= 0 AND horaInicio <= 23),
        horaFin INT CHECK (horaFin >= 0 AND horaFin <= 23),
        cantidadDiasTrabajoPorSemana INT CHECK (cantidadDiasTrabajoPorSemana >= 1 AND cantidadDiasTrabajoPorSemana <= 7),
        FOREIGN KEY (cargoId) REFERENCES Cargo(id),
        FOREIGN KEY (empleadoSupervisorId) REFERENCES Empleado(id),
        FOREIGN KEY (sucursalId) REFERENCES Sucursal(id)
    );
END;

									--tabla inventario y proveedores 

IF NOT EXISTS ( --tabla proveedor 
    SELECT * 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_NAME = 'Proveedor'
)
BEGIN
    CREATE TABLE Proveedor (
        id INT IDENTITY(1,1) PRIMARY KEY,      -- Auto-incremental, comienza en 1 y se incrementa en 1
        nombre NVARCHAR(255) NOT NULL,          -- Asegura que 'nombre' no puede ser NULL
        RIF NVARCHAR(255) NOT NULL,              -- Asegura que 'RIF' no puede ser NULL
        CHECK (RIF NOT LIKE '-%' ),				-- Asegura que 'RIF' no sea negativo 
        telefono INT CHECK (telefono >= 0) NOT NULL,  -- Asegura que 'telefono' no puede ser negativo
		correo NVARCHAR(255), 
        ciudadId INT NOT NULL,    -- Asegura que 'ciudadID' no puede ser NULL 
        FOREIGN KEY (ciudadId) REFERENCES Ciudad(id) -- Clave foránea que referencia a la tabla Ciudad
    );
END

IF NOT EXISTS ( --tabla Inventario 
	SELECT  *
    FROM    INFORMATION_SCHEMA.TABLES
    WHERE   TABLE_NAME = 'Inventario' )
BEGIN
    CREATE TABLE Inventario (
        id INT IDENTITY(1,1) PRIMARY KEY,
        productoId INT,					
        cantidad INT CHECK (cantidad >= 0),
        FOREIGN KEY (productoId) REFERENCES Producto(id)
    );
END;

IF NOT EXISTS ( --tabla Inventario
	SELECT  *
    FROM    INFORMATION_SCHEMA.TABLES
    WHERE   TABLE_NAME = 'Inventario' )
BEGIN
    CREATE TABLE Inventario (
        id INT IDENTITY(1,1) PRIMARY KEY,
        productoId INT,
        proveedorId INT,
        cantidad INT CHECK (cantidad >= 0),
        FOREIGN KEY (productoId) REFERENCES Producto(id),
        FOREIGN KEY (proveedorId) REFERENCES Proveedor(id)
    );
END;

									--tablas de ventas y faturación

IF NOT EXISTS ( --tabla FormaPago
	SELECT  *
    FROM    INFORMATION_SCHEMA.TABLES
    WHERE   TABLE_NAME = 'FormaPago' )
BEGIN
    CREATE TABLE FormaPago (
        id INT IDENTITY(1,1) PRIMARY KEY,
        nombre NVARCHAR(255) NOT NULL,
        descripcion NVARCHAR(255)
    );
END;

IF NOT EXISTS ( --tabla Factura
	SELECT  *
    FROM    INFORMATION_SCHEMA.TABLES
    WHERE   TABLE_NAME = 'Factura' )
BEGIN
    CREATE TABLE Factura (
        id INT IDENTITY(1,1) PRIMARY KEY,
        fechaEmision DATE,
        clienteId INT,
        subTotal DECIMAL(10,2) CHECK (subTotal >= 0),
        montoDescuentoTotal DECIMAL(10,2) CHECK (montoDescuentoTotal >= 0),
        porcentajeIVA DECIMAL(10,2) CHECK (porcentajeIVA >= 0), 
        montoIVA DECIMAL(10,2) CHECK (montoIVA >= 0),  
        montoTotal DECIMAL(10,2) CHECK (montoTotal >= 0),
        FOREIGN KEY (clienteId) REFERENCES Cliente(id)
    );
END;

IF NOT EXISTS ( --tabla FacturaDetalle
	SELECT  *
    FROM    INFORMATION_SCHEMA.TABLES
    WHERE   TABLE_NAME = 'FacturaDetalle' )
BEGIN
    CREATE TABLE FacturaDetalle (
        id INT IDENTITY(1,1) PRIMARY KEY,
        facturaId INT,
        productoId INT,
        cantidad INT CHECK (cantidad >= 0),
        precioPor DECIMAL(10,2)			
    );
END;

IF NOT EXISTS ( --tabla Pago
	SELECT  *
    FROM    INFORMATION_SCHEMA.TABLES
    WHERE   TABLE_NAME = 'Pago' )
BEGIN
    CREATE TABLE Pago (
        facturaId INT,
        nroTransaccion NVARCHAR(255) NOT NULL,  
        metodoPagoId INT,
        FOREIGN KEY (facturaId) REFERENCES Factura(id),
        FOREIGN KEY (metodoPagoId) REFERENCES FormaPago(id)
    );
END;

IF NOT EXISTS ( --tabla VentaFisica
	SELECT  *
    FROM    INFORMATION_SCHEMA.TABLES
    WHERE   TABLE_NAME = 'VentaFisica' )
BEGIN
    CREATE TABLE VentaFisica (
        facturaId INT,
        sucursalId INT,
        empleadoId INT,
        CONSTRAINT PK_VentaFisica PRIMARY KEY (facturaId, sucursalId, empleadoId),
        FOREIGN KEY (facturaId) REFERENCES Factura(id),
        FOREIGN KEY (sucursalId) REFERENCES Sucursal(id),
        FOREIGN KEY (empleadoId) REFERENCES Empleado(id)
    );
END;

									--tablas de Promociones 

IF NOT EXISTS ( --tabla Promo 
	SELECT * 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_NAME = 'Promo')
BEGIN
    CREATE TABLE Promo ( 
        id INT IDENTITY(1,1) PRIMARY KEY,
        nombre NVARCHAR(255) NOT NULL,
        slogan NVARCHAR(255),
        codigo NVARCHAR(255),
        tipoDescuento NVARCHAR(20) CHECK (tipoDescuento IN ('Porcentaje', 'Fijo')),
        valorDescuento DECIMAL(10, 2) CHECK (valorDescuento >= 0),
        fechaInicio DATE,
        fechaFin DATE,
        tipoPromocion NVARCHAR(20) CHECK (tipoPromocion IN ('Online', 'Fisica', 'Ambos'))
    );
END;

IF NOT EXISTS ( --tabla PromoEspecializada
	SELECT * 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_NAME = 'PromoEspecializada')
BEGIN
    CREATE TABLE PromoEspecializada (
        id INT IDENTITY(1,1) PRIMARY KEY,
        promoId INT,
        productoId INT,
        categoriaId INT,
        marcaId INT,
        FOREIGN KEY (promoId) REFERENCES Promo(id),
        FOREIGN KEY (productoId) REFERENCES Producto(id),
        FOREIGN KEY (categoriaId) REFERENCES Categoria(id),
        FOREIGN KEY (marcaId) REFERENCES Marca(id)
    );
END;

IF NOT EXISTS ( --tabla FacturaPromo 
	SELECT * 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_NAME = 'FacturaPromo')
BEGIN
    CREATE TABLE FacturaPromo (
        id INT IDENTITY(1,1) PRIMARY KEY,
        facturaId INT,
        promoId INT,
        FOREIGN KEY (facturaId) REFERENCES Factura(id),
        FOREIGN KEY (promoId) REFERENCES Promo(id)
    );
END;

										--tablas pedidos online y envio

IF NOT EXISTS ( --tabla tipoEnvio
	SELECT * 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_NAME = 'TipoEnvio')
BEGIN
    CREATE TABLE TipoEnvio (
        id INT IDENTITY(1,1) PRIMARY KEY,
        nombreEnvio NVARCHAR(255) NOT NULL,
        tiempoEstimadoEntrega INT CHECK (tiempoEstimadoEntrega >= 0), -- Almacenado en horas
        costoEnvio DECIMAL(10, 2) CHECK (costoEnvio >= 0)
    );
END; 

IF NOT EXISTS ( --tabla OrdenOnline
	SELECT * 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_NAME = 'OrdenOnline')
BEGIN
    CREATE TABLE OrdenOnline (
        id INT IDENTITY(1,1) PRIMARY KEY,
        clienteId INT,
        nroOrden INT CHECK (nroOrden >= 0),
        fechaCreacion DATETIME,
        tipoEnvioId INT,
        facturaId INT,
        FOREIGN KEY (clienteId) REFERENCES Cliente(id),
        FOREIGN KEY (tipoEnvioId) REFERENCES TipoEnvio(id),
        FOREIGN KEY (facturaId) REFERENCES Factura(id)
    );
END;

IF NOT EXISTS ( --tabla OrdenDetalle
	SELECT * 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_NAME = 'OrdenDetalle')
BEGIN
    CREATE TABLE OrdenDetalle (
        id INT IDENTITY(1,1) PRIMARY KEY,
        ordenId INT,
        productoId INT,
        cantidad INT CHECK (cantidad >= 0),
        precioPor DECIMAL(10, 2),
        FOREIGN KEY (ordenId) REFERENCES OrdenOnline(id),
        FOREIGN KEY (productoId) REFERENCES Producto(id)
    );
END; 

										--tablas de relaciones y actividades del cliente

IF NOT EXISTS ( --tabla ProductoRecomendadoParaProducto
	SELECT * 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_NAME = 'ProductoRecomendadoParaProducto')
BEGIN
    CREATE TABLE ProductoRecomendadoParaProducto (
        productoId INT,
        productoRecomendadoId INT,
        mensaje NVARCHAR(255),
        PRIMARY KEY (productoId, productoRecomendadoId),
        FOREIGN KEY (productoId) REFERENCES Producto(id),
        FOREIGN KEY (productoRecomendadoId) REFERENCES Producto(id)
    );
END; 
 
IF NOT EXISTS ( --tabla ProductoRecomendadoParaCliente
	SELECT * 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_NAME = 'ProductoRecomendadoParaCliente')
BEGIN
    CREATE TABLE ProductoRecomendadoParaCliente (
        clienteId INT,
        productoRecomendadoId INT,
        fechaRecomendacion DATETIME,
        mensaje NVARCHAR(255),
        PRIMARY KEY (clienteId, productoRecomendadoId, fechaRecomendacion),
        FOREIGN KEY (clienteId) REFERENCES Cliente(id),
        FOREIGN KEY (productoRecomendadoId) REFERENCES Producto(id)
    );
END; 

IF NOT EXISTS ( --tabla HistorialClienteProducto
	SELECT * 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_NAME = 'HistorialClienteProducto')
BEGIN
    CREATE TABLE HistorialClienteProducto (
        clienteId INT,
        productoId INT,
        fecha DATETIME,
        tipoAccion NVARCHAR(20) CHECK (tipoAccion IN ('Busqueda', 'Carrito', 'Compra')),
        PRIMARY KEY (clienteId, productoId, fecha),
        FOREIGN KEY (clienteId) REFERENCES Cliente(id),
        FOREIGN KEY (productoId) REFERENCES Producto(id)
    );
END;

IF NOT EXISTS ( --tabla Carrito
	SELECT * 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_NAME = 'Carrito')
BEGIN
    CREATE TABLE Carrito (
        clienteId INT,
        productoId INT,
        fechaAgregado DATETIME,
        cantidad INT CHECK (cantidad >= 0),
        precioPor DECIMAL(10, 2) CHECK (precioPor >= 0),
        PRIMARY KEY (clienteId, productoId),
        FOREIGN KEY (clienteId) REFERENCES Cliente(id),
        FOREIGN KEY (productoId) REFERENCES Producto(id)
    );
END;

--listo :)