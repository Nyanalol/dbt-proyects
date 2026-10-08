SELECT
    id AS cliente_id,
    nombre,
    segmento,
    fecha_alta
FROM {{ ref('raw_clientes') }}
