{# Test para verificar la coherencia de fechas. Acepta current_date o alguna fecha entre comillas casteada como date #}

{% test fecha_coherente(model, column_name, fecha_referencia) %}


SELECT * FROM {{ model }}
WHERE {{ column_name }} > {{ fecha_referencia }}

{% endtest %}
