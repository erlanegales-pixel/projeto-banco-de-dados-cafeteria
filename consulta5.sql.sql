--- Objetivo: Utilizar uma CTE para calcular o ticket médio geral dos pedidos concluídos e listar os pedidos que ficaram acima dessa média, junto com o nome do atendente.
WITH media_geral AS (
    SELECT AVG(valor_total) AS ticket_medio
    FROM pedido
    WHERE status_pedido = 'CONCLUIDO'
)
SELECT 
    p.id_pedido,
    f.nome AS atendente,
    p.data_pedido,
    p.valor_total,
    ROUND((SELECT ticket_medio FROM media_geral), 2) AS ticket_medio_cafeteria
FROM pedido p
INNER JOIN funcionario f ON p.id_funcionario = f.id_funcionario
WHERE p.status_pedido = 'CONCLUIDO'
  AND p.valor_total > (SELECT ticket_medio FROM media_geral)
ORDER BY p.valor_total DESC;