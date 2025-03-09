INSERT INTO Promo (nombre, slogan, codigo, tipoDescuento, valorDescuento, fechaInicio, fechaFin, tipoPromocion) VALUES
-- 10 Inserciones tipoPromocion 'Fisica' con tipoDescuento 'Porcentaje'
('Descuento Super', '¡Ahorra hoy, sonríe mañana!', 'FIS20', 'Porcentaje', 20.00, '2023-01-01', '2023-01-31', 'Fisica'),
('Oferta Especial', 'Descuento del 15%', 'FIS15', 'Porcentaje', 15.00, '2023-02-01', '2023-02-28', 'Fisica'),
('Ahorras Más', 'Descuento del 10%', 'FIS10', 'Porcentaje', 10.00, '2023-03-01', '2023-03-31', 'Fisica'),
('Promo Increíble', 'Descuento del 25%', 'FIS25', 'Porcentaje', 25.00, '2023-04-01', '2023-04-30', 'Fisica'),
('Rebaja', 'Descuento del 30%', 'FIS30', 'Porcentaje', 30.00, '2023-05-01', '2023-05-31', 'Fisica'),
('Ahorremos', 'Descuento del 5%', 'FIS5', 'Porcentaje', 5.00, '2023-06-01', '2023-06-30', 'Fisica'),
('Ayuda', 'Descuento del 12%', 'FIS12', 'Porcentaje', 12.00, '2023-07-01', '2023-07-31', 'Fisica'),
('Oferta Flash', 'Descuento del 8%', 'FIS8', 'Porcentaje', 8.00, '2023-08-01', '2023-08-31', 'Fisica'),
('El que no aproveche es toche', 'Descuento del 18%', 'FIS18', 'Porcentaje', 18.00, '2023-09-01', '2023-09-30', 'Fisica'),
('Oferta', 'Descuento del 22%', 'FIS22', 'Porcentaje', 22.00, '2023-10-01', '2023-10-31', 'Fisica'),

-- 10 Inserciones tipoPromocion 'Fisica' con tipoDescuento 'Fijo'
('Ojito', 'Descuento de $20', 'FIS20F', 'Fijo', 20.00, '2023-11-01', '2023-11-30', 'Fisica'),
('Viene DICIEMBRE', 'Descuento de $30', 'FIS30F', 'Fijo', 30.00, '2023-11-01', '2023-11-30', 'Fisica'),
('Winter is Coming', 'Descuento de $50', 'FIS50F', 'Fijo', 50.00, '2023-11-01', '2023-11-30', 'Fisica'),
('DICIEMBRE', 'Descuento de $15', 'FIS15F', 'Fijo', 15.00, '2023-12-01', '2023-12-30', 'Fisica'),
('Feliz Navidad', 'Descuento de $10', 'FIS10F', 'Fijo', 10.00, '2023-12-01', '2023-12-30', 'Fisica'),
('Feliz Año', 'Descuento de $25', 'FIS25F', 'Fijo', 25.00, '2024-01-01', '2024-01-30', 'Fisica'),
('Ofertón', 'Descuento de $40', 'FIS40F', 'Fijo', 40.00, '2024-02-01', '2024-02-29', 'Fisica'),
('Más Barato Imposible', 'Descuento de $60', 'FIS60F', 'Fijo', 60.00, '2024-02-01', '2024-02-29', 'Fisica'),
('Precio de Regalo', 'Descuento de $5', 'FIS5F', 'Fijo', 5.00, '2024-03-01', '2024-03-30', 'Fisica'),
('Camarón que se Duerme se lo Lleva la Corriente', 'Descuento de $45', 'FIS45F', 'Fijo', 45.00, '2024-03-01', '2024-03-30', 'Fisica'),

-- 10 Inserciones tipoPromocion 'Online' con tipoDescuento 'Fijo'
('Playa, Sol y Arena', 'Descuento de $50', 'ONL50', 'Fijo', 50.00, '2023-01-01', '2023-01-31', 'Online'),
('Bienvenido Carnaval', 'Descuento de $30', 'ONL30', 'Fijo', 30.00, '2023-02-01', '2023-02-28', 'Online'),
('Semana Santa', 'Descuento de $20', 'ONL20', 'Fijo', 20.00, '2023-03-01', '2023-03-31', 'Online'),
('Cumpleañero', 'Regalenle al Cumpleañero', 'ONL10', 'Fijo', 10.00, '2023-04-01', '2023-04-30', 'Online'),
('Clases aaa', 'Descuento de $15', 'ONL15', 'Fijo', 15.00, '2023-05-01', '2023-05-31', 'Online'),
('Fin de Clases', 'Descuento de $25', 'ONL25', 'Fijo', 25.00, '2023-06-01', '2023-06-30', 'Online'),
('Vacaciones', 'Descuento de $40', 'ONL40', 'Fijo', 40.00, '2023-07-01', '2023-07-31', 'Online'),
('Playita', 'Descuento de $60', 'ONL60', 'Fijo', 60.00, '2023-08-01', '2023-08-31', 'Online'),
('Vamos', 'Descuento de $45', 'ONL45', 'Fijo', 45.00, '2023-09-01', '2023-09-30', 'Online'),
('Halloween', 'Descuento de $35', 'ONL35', 'Fijo', 35.00, '2023-10-01', '2023-10-31', 'Online'),

-- 10 Inserciones tipoPromocion 'Ambos' con tipoDescuento 'Porcentaje'
('Precio de Regalo', 'Descuento del 20%', 'AMB20', 'Porcentaje', 20.00, '2023-01-01', '2023-01-31', 'Ambos'),
('Ojito que es San Valentín', 'Descuento del 15%', 'AMB15', 'Porcentaje', 15.00, '2023-02-01', '2023-02-28', 'Ambos'),
('Vaya a la Playa en Carnaval', 'Descuento del 30%', 'AMB30', 'Porcentaje', 30.00, '2023-03-01', '2023-03-31', 'Ambos'),
('No se lo Pierda', 'Descuento del 25%', 'AMB25', 'Porcentaje', 25.00, '2023-04-01', '2023-04-30', 'Ambos'),
('Ya Falta Poco para Vacaciones', 'Descuento del 10%', 'AMB10', 'Porcentaje', 10.00, '2023-05-01', '2023-05-31', 'Ambos'),
('El Cumpleañero Gana Este Mes', 'Descuento del 5%', 'AMB5', 'Porcentaje', 5.00, '2023-06-01', '2023-06-30', 'Ambos'),
('Vacaciones, Amen', 'Descuento del 22%', 'AMB22', 'Porcentaje', 22.00, '2023-07-01', '2023-07-31', 'Ambos'),
('Paquete de Ahorro', 'Descuento del 18%', 'AMB18', 'Porcentaje', 18.00, '2023-08-01', '2023-08-31', 'Ambos'),
('Fin de Vacaciones', 'Descuento del 12%', 'AMB12', 'Porcentaje', 12.00, '2023-09-01', '2023-09-30', 'Ambos'),
('Dulce o Truco', 'Descuento del 8%', 'AMB8', 'Porcentaje', 8.00, '2023-10-01', '2023-10-31', 'Ambos');