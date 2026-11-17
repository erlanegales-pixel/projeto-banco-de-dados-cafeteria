-- ============================================================================
-- PROJETO FINAL - CAFETERIA DOCE ENCANTO
-- Arquivo: script_dml.sql (Carga inicial de dados válidos)
-- ============================================================================

-- 1. CATEGORIAS
INSERT INTO categoria (nome, descricao) VALUES
('Bolos', 'Bolos artesanais inteiros ou em fatias generosas'),
('Cafés Quentes', 'Cafés especiais preparados na hora'),
('Cafés Gelados', 'Bebidas refrescantes à base de café'),
('Chás e Infusões', 'Chás naturais quentes ou gelados'),
('Sucos Naturais', 'Sucos feitos com frutas frescas');

-- 2. CLIENTES (Incluindo registros sem email/telefone para testar valores nulos nas consultas)
INSERT INTO cliente (nome, cpf, telefone, email, data_cadastro) VALUES
('Mariana Silva', '111.222.333-44', '(48) 99911-2233', 'mariana.silva@email.com', '2026-10-01'),
('Lucas Oliveira', '222.333.444-55', '(48) 98822-3344', 'lucas.oliveira@email.com', '2026-10-05'),
('Beatriz Santos', '333.444.555-66', NULL, 'bia.santos@email.com', '2026-10-12'),
('Rafael Costa', '444.555.666-77', '(48) 99733-4455', NULL, '2026-10-20'),
('Fernanda Lima', '555.666.777-88', '(48) 99644-5566', 'fernanda.lima@email.com', '2026-11-01'),
('Carlos Mendes', '666.777.888-99', NULL, NULL, '2026-11-05');

-- 3. FUNCIONÁRIOS
INSERT INTO funcionario (nome, cpf, cargo, telefone, data_admissao, ativo) VALUES
('Ana Paula Souza', '777.888.999-00', 'Gerente', '(48) 99100-1122', '2025-03-10', 1),
('João Pedro Alves', '888.999.000-11', 'Atendente', '(48) 99200-2233', '2025-06-15', 1),
('Camila Rocha', '999.000.111-22', 'Confeiteiro', '(48) 99300-3344', '2025-04-01', 1),
('Thiago Martins', '000.111.222-33', 'Barista', '(48) 99400-4455', '2025-08-20', 1),
('Juliana Ferreira', '123.456.789-01', 'Atendente', '(48) 99500-5566', '2026-01-10', 1);

-- 4. FORNECEDORES
INSERT INTO fornecedor (razao_social, cnpj, telefone, email, contato_responsavel) VALUES
('Moinho Sul Alimentos Ltda', '12.345.678/0001-90', '(48) 3222-1000', 'vendas@moinhosul.com.br', 'Roberto Nunes'),
('Torrefação Serra Catarinense', '23.456.789/0001-01', '(48) 3222-2000', 'pedidos@serracafe.com.br', 'Cláudia Ribeiro'),
('Laticínios Vale Verde S/A', '34.567.890/0001-12', '(48) 3222-3000', 'comercial@valeverde.com.br', 'Marcos Tavares'),
('Hortifruti Frescor da Ilha', '45.678.901/0001-23', '(48) 3222-4000', 'contato@frescordailha.com.br', 'Sônia Dias');

-- 5. INGREDIENTES
INSERT INTO ingrediente (nome, unidade_medida, quantidade_atual, estoque_minimo, id_fornecedor) VALUES
('Farinha de Trigo Especial', 'g', 15000.00, 3000.00, 1),
('Chocolate em Pó 50% Cacau', 'g', 5000.00, 1000.00, 1),
('Café Gourmet Torrado em Grãos', 'g', 8000.00, 1500.00, 2),
('Leite Integral', 'ml', 20000.00, 5000.00, 3),
('Leite em Pó Ninho', 'g', 4000.00, 800.00, 3),
('Morango Fresco', 'g', 1500.00, 1000.00, 4),
('Limão Taiti', 'g', 3000.00, 500.00, 4),
('Cenoura Fresca', 'g', 4000.00, 1000.00, 4),
('Polpa de Maracujá', 'g', 0.00, 500.00, 4); -- Estoque zerado para testar indisponibilidade

-- 6. MOVIMENTAÇÕES DE ESTOQUE
INSERT INTO estoque (id_ingrediente, tipo_movimentacao, quantidade, data_movimentacao, observacao) VALUES
(1, 'ENTRADA', 20000.00, '2026-11-01 08:30:00', 'Compra mensal Moinho Sul'),
(2, 'ENTRADA', 6000.00, '2026-11-01 08:35:00', 'Compra mensal Moinho Sul'),
(3, 'ENTRADA', 10000.00, '2026-11-02 09:00:00', 'Entrega semanal Torrefação'),
(4, 'ENTRADA', 25000.00, '2026-11-05 07:45:00', 'Reposição laticínios'),
(1, 'SAIDA', 5000.00, '2026-11-10 14:00:00', 'Produção de bolos da semana'),
(3, 'SAIDA', 2000.00, '2026-11-12 18:00:00', 'Consumo máquina de expresso');

-- 7. PRODUTOS (Cardápio Doce Encanto)
INSERT INTO produto (nome, descricao, preco, disponivel, id_categoria) VALUES
('Fatia Bolo de Chocolate', 'Massa úmida de cacau com cobertura cremosa de brigadeiro', 14.50, 1, 1),
('Fatia Bolo de Cenoura', 'Bolo fofinho de cenoura com calda quente de chocolate', 13.00, 1, 1),
('Fatia Bolo Red Velvet', 'Massa aveludada vermelha com recheio de cream cheese', 16.00, 1, 1),
('Fatia Bolo de Limão', 'Bolo cítrico com cobertura de mousse de limão Taiti', 13.50, 1, 1),
('Fatia Bolo Leite Ninho com Morango', 'Massa branca com creme de Ninho e morangos frescos', 17.50, 1, 1),
('Café Expresso', 'Dose de 50ml de café gourmet extraído na hora', 7.00, 1, 2),
('Cappuccino Cremoso', 'Expresso, leite vaporizado e toque de chocolate em pó', 11.50, 1, 2),
('Chocolate Quente Europeu', 'Chocolate cremoso artesanal', 13.00, 1, 2),
('Iced Coffee Caramelo', 'Café expresso gelado com leite e calda de caramelo', 14.00, 1, 3),
('Chá Gelado de Pêssego', 'Infusão natural refrescante de 300ml', 9.50, 1, 4),
('Suco Natural de Morango', 'Suco batido na hora (300ml)', 12.00, 1, 5),
('Suco Natural de Maracujá', 'Suco natural da fruta (300ml)', 11.00, 0, 5); -- Indisponível por falta de polpa

-- 8. RECEITAS (PRODUTO_INGREDIENTE)
INSERT INTO produto_ingrediente (id_produto, id_ingrediente, quantidade_necessaria) VALUES
(1, 1, 120.00), (1, 2, 50.00),   -- Bolo de Chocolate usa Farinha e Chocolate
(2, 1, 120.00), (2, 8, 100.00),  -- Bolo de Cenoura usa Farinha e Cenoura
(4, 1, 120.00), (4, 7, 60.00),   -- Bolo de Limão usa Farinha e Limão
(5, 1, 120.00), (5, 5, 80.00), (5, 6, 90.00), -- Bolo Ninho com Morango
(6, 3, 18.00),                   -- Café Expresso usa Café em grãos
(7, 3, 18.00), (7, 4, 150.00), (7, 2, 10.00), -- Cappuccino
(11, 6, 150.00);                 -- Suco de Morango

-- 9. PEDIDOS
INSERT INTO pedido (id_cliente, id_funcionario, data_pedido, tipo_consumo, status_pedido, valor_total) VALUES
(1, 2, '2026-11-10 10:15:00', 'LOCAL', 'CONCLUIDO', 26.00),
(2, 2, '2026-11-10 15:30:00', 'RETIRADA', 'CONCLUIDO', 31.50),
(3, 5, '2026-11-11 16:00:00', 'LOCAL', 'CONCLUIDO', 23.00),
(NULL, 2, '2026-11-12 09:20:00', 'RETIRADA', 'CONCLUIDO', 20.00), -- Cliente não identificado no balcão
(1, 5, '2026-11-13 17:45:00', 'LOCAL', 'CONCLUIDO', 43.00),
(4, 2, '2026-11-14 11:10:00', 'LOCAL', 'CONCLUIDO', 25.50),
(5, 5, '2026-11-15 16:20:00', 'RETIRADA', 'PREPARANDO', 33.50);

-- 10. ITENS DOS PEDIDOS
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario, subtotal) VALUES
-- Pedido 1 (Total: 26.00)
(1, 1, 1, 14.50, 14.50),
(1, 7, 1, 11.50, 11.50),
-- Pedido 2 (Total: 31.50)
(2, 5, 1, 17.50, 17.50),
(2, 9, 1, 14.00, 14.00),
-- Pedido 3 (Total: 23.00)
(3, 4, 1, 13.50, 13.50),
(3, 10, 1, 9.50, 9.50),
-- Pedido 4 (Total: 20.00)
(4, 2, 1, 13.00, 13.00),
(4, 6, 1, 7.00, 7.00),
-- Pedido 5 (Total: 43.00)
(5, 3, 2, 16.00, 32.00),
(5, 12, 1, 11.00, 11.00),
-- Pedido 6 (Total: 25.50)
(6, 1, 1, 14.50, 14.50),
(6, 12, 1, 11.00, 11.00),
-- Pedido 7 (Total: 33.50)
(7, 5, 1, 17.50, 17.50),
(7, 3, 1, 16.00, 16.00);

-- 11. PAGAMENTOS
INSERT INTO pagamento (id_pedido, data_pagamento, valor_pago, forma_pagamento) VALUES
(1, '2026-11-10 10:16:00', 26.00, 'PIX'),
(2, '2026-11-10 15:31:00', 31.50, 'CARTAO_CREDITO'),
(3, '2026-11-11 16:02:00', 23.00, 'CARTAO_DEBITO'),
(4, '2026-11-12 09:21:00', 20.00, 'DINHEIRO'),
(5, '2026-11-13 17:46:00', 43.00, 'PIX'),
(6, '2026-11-14 11:12:00', 25.50, 'CARTAO_CREDITO');