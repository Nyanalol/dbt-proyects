WITH
pedidos AS (
    SELECT * FROM {{ ref('stg_tienda__pedidos') }}
),

-- Grain: un pedido por fila. El origen trae el pedido_id 12 dos veces, con cliente,
-- fecha y estado distintos. Criterio: se queda la fila más reciente (y, a igual
-- fecha, la de cliente_id menor, para que el resultado no dependa de la ejecución).
pedidos_unicos AS (
    SELECT * FROM pedidos
    QUALIFY ROW_NUMBER() OVER (
        PARTITION BY pedido_id
        ORDER BY fecha_pedido DESC, cliente_id
    ) = 1
),

pedidos_con_pagos AS (
    SELECT * FROM {{ ref('int_pagos_por_pedido') }}
),

fct_pedidos AS (
    SELECT
        pedidos.pedido_id,
        {%- for metodo in var('metodos') %}
            pedidos_con_pagos.importe_{{ metodo }},
        {%- endfor %}
        pedidos_con_pagos.importe AS importe_cobrado,
        pedidos.cliente_id,
        pedidos.fecha_pedido,
        pedidos.estado
    FROM pedidos_unicos AS pedidos LEFT JOIN pedidos_con_pagos
        ON pedidos.pedido_id = pedidos_con_pagos.pedido_id
{#- En dev, solo los últimos meses_dev meses. Va en el mart y no en staging: filtrar
    pedidos en staging deja pagos huérfanos y rompe el relationships de pagos. #}
    {%- if target.name == 'dev' %}
        WHERE pedidos.fecha_pedido >= {{ dbt.dateadd('month', -var('meses_dev'), 'current_date') }}
    {%- endif %}
)

SELECT * FROM fct_pedidos
{# lo que espero ver es una CTE que será el cálculo que hay en int_pagos_por_pedido #}
