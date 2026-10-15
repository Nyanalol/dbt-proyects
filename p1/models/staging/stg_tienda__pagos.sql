SELECT
    id AS pago_id,
    pedido_id,
    importe,
    {{- normalizar('metodo') }} AS metodo
FROM {{ ref('raw_pagos') }}
