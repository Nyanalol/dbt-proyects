WITH
pagos AS (
    SELECT
        pedido_id,
        importe,
        metodo
    FROM {{ ref('stg_tienda__pagos') }}
),

int_pagos_por_pedido AS (
    SELECT
        pedido_id,
        SUM(importe) AS importe,
    {%- for metodo in var('metodos') %}
        SUM(CASE WHEN metodo = '{{ metodo }}' THEN importe END) AS {{ 'importe_' ~ metodo }}
        {{- "," if not loop.last }}
    {%- endfor %}
    FROM pagos
    GROUP BY pedido_id
)

SELECT * FROM int_pagos_por_pedido
