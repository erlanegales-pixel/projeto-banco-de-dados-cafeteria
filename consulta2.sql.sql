--- Objetivo: Listar todos os produtos do cardápio e suas categorias, exibindo a quantidade total vendida (substituindo valores nulos por 0 para produtos ainda não vendidos), em ordem alfabética.
SELECT 
    cat.nome AS categoria,
    prod.nome AS produto,
    prod.preco,
    COALESCE(SUM(ip.quantidade), 0) AS unidades_vendidas
FROM produto prod
INNER JOIN categoria cat ON prod.id_categoria = cat.id_categoria
LEFT JOIN item_pedido ip ON prod.id_produto = ip.id_produto
GROUP BY prod.id_produto, cat.nome, prod.nome, prod.preco
ORDER BY prod.nome ASC;