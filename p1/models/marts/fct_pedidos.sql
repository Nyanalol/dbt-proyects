SELECT
    pedidos.pedido_id,
    {%- for metodo in var('metodos') %}
    pedidos_con_pagos.importe_{{ metodo }},
    {%- endfor %}
    pedidos_con_pagos.importe AS importe_cobrado,
    pedidos.cliente_id,
    pedidos.fecha_pedido,
    pedidos.estado
FROM {{ ref('stg_tienda__pedidos') }} AS pedidos LEFT JOIN {{ ref('int_pagos_por_pedido') }} AS pedidos_con_pagos
    ON pedidos.pedido_id = pedidos_con_pagos.pedido_id
{#- En dev, solo los últimos meses_dev meses. Va en el mart y no en staging: filtrar
    pedidos en staging deja pagos huérfanos y rompe el relationships de pagos. #}
{%- if target.name == 'dev' %}
WHERE pedidos.fecha_pedido >= {{ dbt.dateadd('month', -var('meses_dev'), 'current_date') }}
{%- endif %}

{# lo que espero ver es una CTE que será el cálculo que hay en int_pagos_por_pedido #}
{# Hay un pedido, el 12, que sale duplicado. Tener en cuenta para más adelante #}

