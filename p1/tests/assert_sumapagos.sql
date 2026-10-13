{# Test: el importe cobrado del mart cuadra con la suma de los pagos válidos de staging.
   los negativos son devoluciones #}

{{ config(severity='error') }}

WITH pagos_por_pedido AS (
    SELECT
        pedido_id,
        SUM(importe) AS total_pagos
    FROM {{ ref('stg_tienda__pagos') }}
    GROUP BY pedido_id
)

SELECT
    pedidos.pedido_id,
    pedidos.importe_cobrado,
    pagos.total_pagos
FROM {{ ref('fct_pedidos') }} AS pedidos
LEFT JOIN pagos_por_pedido AS pagos
    ON pedidos.pedido_id = pagos.pedido_id
WHERE pedidos.importe_cobrado IS DISTINCT FROM pagos.total_pagos
