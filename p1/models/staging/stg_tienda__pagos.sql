SELECT
    id AS pago_id,
    pedido_id,
    metodo,
    importe
FROM {{ ref('raw_pagos') }}
