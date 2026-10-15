SELECT
    id AS pedido_id,
    cliente_id,
    fecha AS fecha_pedido,
    {{- normalizar('estado') }} AS estado
FROM {{ ref('raw_pedidos') }}
