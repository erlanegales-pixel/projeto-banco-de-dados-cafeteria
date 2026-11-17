--- Objetivo: Apurar o faturamento total agrupado por forma de pagamento e tipo de consumo (Local ou Retirada), filtrando apenas combinações que geraram mais de R$ 25,00.
SELECT 
    pag.forma_pagamento,
    ped.tipo_consumo,
    COUNT(ped.id_pedido) AS qtd_pedidos,
    SUM(pag.valor_pago) AS total_arrecadado
FROM pagamento pag
INNER JOIN pedido ped ON pag.id_pedido = ped.id_pedido
GROUP BY pag.forma_pagamento, ped.tipo_consumo
HAVING SUM(pag.valor_pago) > 25.00
ORDER BY total_arrecadado DESC;