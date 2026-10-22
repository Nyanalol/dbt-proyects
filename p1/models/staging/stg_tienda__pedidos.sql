WITH
pedidos AS (
    SELECT * FROM {{ ref('raw_pedidos') }}
),

stg_tienda__pedidos AS (
    SELECT
        id AS pedido_id,
        cliente_id,
        fecha AS fecha_pedido,
        {{- normalizar('estado') }} AS estado
    FROM pedidos
)

SELECT * FROM stg_tienda__pedidos
