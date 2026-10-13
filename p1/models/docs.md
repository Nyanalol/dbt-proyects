{% docs importe_cobrado %}
Suma de **todos** los pagos del pedido, devoluciones incluidas: los importes
negativos son devoluciones y restan (decisión del 2026-10-09). No entran los pagos
que apuntan a pedidos inexistentes (38 y 71), porque no se pueden atribuir a
ningún pedido. Un pedido sin pagos queda con importe NULL, no 0.
{% enddocs %}
