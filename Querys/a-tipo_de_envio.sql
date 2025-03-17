SELECT te.nombreEnvio as Tipo_de_envio, t1.Usos,(t1.Usos/(SELECT COUNT (id) FROM TipoEnvio))*100 Proporcion_de_uso , t1.Ganancias, (t1.Ganancias/(SELECT sum(costoEnvio) FROM TipoEnvio))*100 Proporcion_de_Ganancias
From TipoEnvio te, (SELECT te.id as ID, COUNT(te.id) Usos, sum(te.costoEnvio) Ganancias
FROM TipoEnvio te
GROUP BY te.id
) as T1
where te.id=t1.ID