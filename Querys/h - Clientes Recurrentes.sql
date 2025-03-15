WITH ClientePrimeraCompra AS (
	SELECT
		ClienteId,
        MIN(fechaEmision) AS primeraFecha
	FROM Factura
	GROUP BY clienteId
), ClientesRecurrentes AS (
	SELECT DISTINCT 
		Factura.clienteId id
	FROM Factura
	JOIN ClientePrimeraCompra cpc on cpc.clienteId = Factura.clienteId
	WHERE fechaEmision <= DATEADD(day, 30, primeraFecha) AND fechaEmision > primeraFecha
) SELECT Cliente.* FROM Cliente
JOIN ClientesRecurrentes on ClientesRecurrentes.id = Cliente.id