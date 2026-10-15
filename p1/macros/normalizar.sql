{% macro normalizar(column) %}
    trim(lower({{ column }}))
{%- endmacro %}