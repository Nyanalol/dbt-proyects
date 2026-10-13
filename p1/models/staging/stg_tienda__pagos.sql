SELECT
    id AS pago_id,
    pedido_id,
    importe,
    lower(trim(metodo)) AS metodo
FROM {{ ref('raw_pagos') }}
