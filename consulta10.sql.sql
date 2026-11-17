--- Objetivo: Registrar um novo pedido com dois itens, desfazer a inclusão do segundo item via SAVEPOINT e confirmar o pedido apenas com o primeiro item via COMMIT.
BEGIN TRANSACTION;

-- 1. Cria um novo pedido para a cliente Mariana (id_cliente = 1) atendida por João Pedro (id_funcionario = 2)
INSERT INTO pedido (id_cliente, id_funcionario, tipo_consumo, status_pedido, valor_total)
VALUES (1, 2, 'LOCAL', 'ABERTO', 7.00);

-- Insere o primeiro item: 1 Café Expresso (id_produto = 6, valor 7.00)
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario, subtotal)
VALUES ((SELECT MAX(id_pedido) FROM pedido), 6, 1, 7.00, 7.00);

SAVEPOINT primeiro_item_confirmado;

-- 2. Cliente pediu para adicionar 1 Bolo Red Velvet (id_produto = 3), mas desistiu logo em seguida
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario, subtotal)
VALUES ((SELECT MAX(id_pedido) FROM pedido), 3, 1, 16.00, 16.00);

-- Cancela apenas o segundo item retornando ao savepoint
ROLLBACK TO SAVEPOINT primeiro_item_confirmado;

-- 3. Conclui o pedido apenas com o Café Expresso
UPDATE pedido
SET status_pedido = 'CONCLUIDO'
WHERE id_pedido = (SELECT MAX(id_pedido) FROM pedido);

COMMIT;