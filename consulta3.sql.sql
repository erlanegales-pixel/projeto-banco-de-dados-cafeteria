--- Objetivo: Analisar os preços dos produtos por categoria (média, menor e maior preço), exibindo apenas as categorias cujo preço médio dos itens seja superior a R$ 11,00.
SELECT 
    cat.nome AS categoria,
    COUNT(prod.id_produto) AS qtd_produtos,
    ROUND(AVG(prod.preco), 2) AS preco_medio,
    MIN(prod.preco) AS menor_preco,
    MAX(prod.preco) AS maior_preco
FROM categoria cat
INNER JOIN produto prod ON cat.id_categoria = prod.id_categoria
GROUP BY cat.id_categoria, cat.nome
HAVING AVG(prod.preco) > 11.00
ORDER BY preco_medio DESC;