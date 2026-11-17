--- Objetivo: Listar os ingredientes cujo estoque atual está abaixo da média geral de quantidade em estoque de todos os ingredientes cadastrados.
SELECT 
    i.nome AS ingrediente,
    i.quantidade_atual,
    i.unidade_medida,
    f.razao_social AS fornecedor
FROM ingrediente i
INNER JOIN fornecedor f ON i.id_fornecedor = f.id_fornecedor
WHERE i.quantidade_atual < (
    SELECT AVG(quantidade_atual) 
    FROM ingrediente
)
ORDER BY i.quantidade_atual ASC;