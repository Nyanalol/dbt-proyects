


SELECT pedido_id, SUM(importe) AS importe
FROM {{ref('stg_tienda__pagos')}} 
GROUP BY pedido_id