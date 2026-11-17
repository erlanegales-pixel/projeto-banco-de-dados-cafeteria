--- Objetivo: Listar o total gasto e a quantidade de pedidos concluídos por cada cliente identificado, ordenando do maior faturamento para o menor.
SELECT 
    c.nome AS nome_cliente,
    c.cpf,
    COUNT(DISTINCT p.id_pedido) AS total_pedidos,
    SUM(ip.subtotal) AS valor_total_gasto
FROM cliente c
INNER JOIN pedido p ON c.id_cliente = p.id_cliente
INNER JOIN item_pedido ip ON p.id_pedido = ip.id_pedido
WHERE p.status_pedido = 'CONCLUIDO'
GROUP BY c.id_cliente, c.nome, c.cpf
ORDER BY valor_total_gasto DESC;