--- Objetivo: Listar todos os fornecedores que possuem pelo menos um ingrediente cadastrado com estoque atual igual ou inferior ao estoque mínimo exigido.
SELECT 
    f.razao_social,
    f.contato_responsavel,
    f.telefone
FROM fornecedor f
WHERE EXISTS (
    SELECT 1 
    FROM ingrediente i 
    WHERE i.id_fornecedor = f.id_fornecedor 
      AND i.quantidade_atual <= i.estoque_minimo
)
ORDER BY f.razao_social ASC;