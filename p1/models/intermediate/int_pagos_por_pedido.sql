SELECT
    pedido_id,
    SUM(importe) AS importe,
    {%- for metodo in var('metodos') %}
    SUM(CASE WHEN metodo = '{{ metodo }}' THEN importe END) AS {{ 'importe_' ~ metodo }}
    {{- "," if not loop.last }}
    {%- endfor %}
FROM {{ ref('stg_tienda__pagos') }}
GROUP BY pedido_id
