WITH
{#- DISTINCT: quita solo filas idénticas en todas las columnas. La integración de cobros
    a veces reenvía un pago tal cual (inc. 2026-10-22: pago 11, pedido 10, 1.952,22 €
    dos veces). Es un arreglo mecánico e indiscutible, por eso va en staging.
    Si llegan dos filas con el mismo id y algo distinto (importe, método...), DISTINCT
    no las junta a propósito: el unique de pago_id las caza y para el pipeline, porque
    eso ya no es un reenvío y hay que decidir cuál vale. #}
pagos AS (
    SELECT DISTINCT
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
