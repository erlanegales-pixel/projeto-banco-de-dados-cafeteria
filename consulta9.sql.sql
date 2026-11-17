--- Objetivo: Registrar uma entrada de reposição de Polpa de Maracujá no estoque, testar uma baixa indevida revertendo-a com SAVEPOINT e confirmar a entrada válida com COMMIT.
BEGIN TRANSACTION;

-- 1. Registra a entrada válida de 2000g de Polpa de Maracujá (id_ingrediente = 9)
INSERT INTO estoque (id_ingrediente, tipo_movimentacao, quantidade, observacao)
VALUES (9, 'ENTRADA', 2000.00, 'Reposição emergencial Hortifruti');

UPDATE ingrediente
SET quantidade_atual = quantidade_atual + 2000.00
WHERE id_ingrediente = 9;

-- Cria ponto de salvamento após a entrada válida
SAVEPOINT apos_reposicao_maracuja;

-- 2. Simula uma baixa errada de 5000g
UPDATE ingrediente
SET quantidade_atual = quantidade_atual - 1500.00
WHERE id_ingrediente = 9;

-- Desfaz apenas o erro voltando ao savepoint
ROLLBACK TO SAVEPOINT apos_reposicao_maracuja;

-- 3. Atualiza a disponibilidade do Suco de Maracujá (id_produto = 12) e confirma a transação
UPDATE produto
SET disponivel = 1
WHERE id_produto = 12;

COMMIT;