SELECT pedidos.pedido_id, pedidos_con_pagos.importe
FROM {{ ref('stg_tienda__pedidos')}} as pedidos LEFT JOIN {{ ref('int_pagos_por_pedido') }} as pedidos_con_pagos
ON pedidos.pedido_id = pedidos_con_pagos.pedido_id



{# lo que espero ver es una CTE que será el cálculo que hay en int_pagos_por_pedido #}
{# Hay un pedido, el 12, que sale duplicado. Tener en cuenta para más adelante #}