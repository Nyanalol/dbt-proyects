SELECT
    id AS cliente_id,
    nombre,
    {{- normalizar('segmento') }} AS segmento,
    fecha_alta
FROM {{ ref('raw_clientes') }}
