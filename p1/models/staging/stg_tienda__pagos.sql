WITH
pagos AS (
    SELECT
        id,
        pedido_id,
        importe,
        metodo
    FROM {{ ref('raw_pagos') }}
),

stg_tienda__pagos AS (

    SELECT

        id AS pago_id,
        pedido_id,
        importe,
        {{- normalizar('metodo') }} AS metodo
    FROM pagos
)

SELECT * FROM stg_tienda__pagos
