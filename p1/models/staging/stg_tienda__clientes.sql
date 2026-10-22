WITH
clientes AS (
    SELECT
        id,
        nombre,
        segmento,
        fecha_alta
    FROM {{ ref('raw_clientes') }}
),

stg_tienda__clientes AS (
    SELECT
        id AS cliente_id,
        nombre,
        {{- normalizar('segmento') }} AS segmento,
        fecha_alta
    FROM clientes
)

SELECT * FROM stg_tienda__clientes
