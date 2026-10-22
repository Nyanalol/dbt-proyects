WITH
clientes AS (
    SELECT * FROM {{ ref('stg_tienda__clientes') }}
),

pedidos AS (
    SELECT * FROM {{ ref('stg_tienda__pedidos') }}
),

-- Los clientes del maestro. Sin segmento -> 'desconocido' (regla de negocio, por eso aquí y no en staging)
clientes_conocidos AS (
    SELECT
        cliente_id,
        nombre,
        COALESCE(segmento, 'desconocido') AS segmento,
        fecha_alta,
        FALSE AS es_desconocido
    FROM clientes
),

-- Miembro desconocido: clientes que aparecen en pedidos pero no en el maestro (999, 1044).
-- Sin estas filas, un INNER JOIN desde fct_pedidos perdería sus ventas.
clientes_desconocidos AS (
    SELECT DISTINCT
        pedidos.cliente_id,
        'desconocido' AS nombre,
        'desconocido' AS segmento,
        CAST(NULL AS DATE) AS fecha_alta,
        TRUE AS es_desconocido
    FROM pedidos
    LEFT JOIN clientes
        ON pedidos.cliente_id = clientes.cliente_id
    WHERE clientes.cliente_id IS NULL
)

SELECT * FROM clientes_conocidos
UNION ALL
SELECT * FROM clientes_desconocidos
