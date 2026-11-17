-- ============================================================================
-- PROJETO FINAL - CAFETERIA DOCE ENCANTO
-- Disciplina: CIN 8003 - Bancos de Dados e Aplicações (UFSC)
-- Arquivo: script_ddl.sql (Criação das tabelas e restrições)
-- ============================================================================

PRAGMA foreign_keys = ON;

-- 1. CATEGORIA
CREATE TABLE categoria (
    id_categoria INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(50) NOT NULL UNIQUE,
    descricao TEXT
);

-- 2. CLIENTE
CREATE TABLE cliente (
    id_cliente INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    data_cadastro DATE NOT NULL DEFAULT (DATE('now'))
);

-- 3. FUNCIONARIO
CREATE TABLE funcionario (
    id_funcionario INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    cargo VARCHAR(50) NOT NULL CHECK (cargo IN ('Atendente', 'Barista', 'Confeiteiro', 'Gerente')),
    telefone VARCHAR(20),
    data_admissao DATE NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT 1
);

-- 4. FORNECEDOR
CREATE TABLE fornecedor (
    id_fornecedor INTEGER PRIMARY KEY AUTOINCREMENT,
    razao_social VARCHAR(120) NOT NULL,
    cnpj VARCHAR(18) NOT NULL UNIQUE,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    contato_responsavel VARCHAR(100)
);

-- 5. INGREDIENTE
CREATE TABLE ingrediente (
    id_ingrediente INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    unidade_medida VARCHAR(20) NOT NULL CHECK (unidade_medida IN ('g', 'kg', 'ml', 'L', 'unidade')),
    quantidade_atual DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK (quantidade_atual >= 0),
    estoque_minimo DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK (estoque_minimo >= 0),
    id_fornecedor INTEGER NOT NULL,
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 6. ESTOQUE (Movimentações de Entrada e Saída)
CREATE TABLE estoque (
    id_movimentacao INTEGER PRIMARY KEY AUTOINCREMENT,
    id_ingrediente INTEGER NOT NULL,
    tipo_movimentacao VARCHAR(10) NOT NULL CHECK (tipo_movimentacao IN ('ENTRADA', 'SAIDA')),
    quantidade DECIMAL(10,2) NOT NULL CHECK (quantidade > 0),
    data_movimentacao DATETIME NOT NULL DEFAULT (DATETIME('now')),
    observacao TEXT,
    FOREIGN KEY (id_ingrediente) REFERENCES ingrediente(id_ingrediente)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 7. PRODUTO
CREATE TABLE produto (
    id_produto INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL CHECK (preco > 0),
    disponivel BOOLEAN NOT NULL DEFAULT 1,
    id_categoria INTEGER NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- TABELA ASSOCIATIVA: RECEITA (Relação N:N entre Produto e Ingrediente)
CREATE TABLE produto_ingrediente (
    id_produto INTEGER NOT NULL,
    id_ingrediente INTEGER NOT NULL,
    quantidade_necessaria DECIMAL(10,2) NOT NULL CHECK (quantidade_necessaria > 0),
    PRIMARY KEY (id_produto, id_ingrediente),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_ingrediente) REFERENCES ingrediente(id_ingrediente)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 8. PEDIDO
CREATE TABLE pedido (
    id_pedido INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente INTEGER, -- Pode ser NULL caso seja cliente de balcão não cadastrado
    id_funcionario INTEGER NOT NULL,
    data_pedido DATETIME NOT NULL DEFAULT (DATETIME('now')),
    tipo_consumo VARCHAR(20) NOT NULL CHECK (tipo_consumo IN ('LOCAL', 'RETIRADA')),
    status_pedido VARCHAR(20) NOT NULL DEFAULT 'ABERTO' CHECK (status_pedido IN ('ABERTO', 'PREPARANDO', 'CONCLUIDO', 'CANCELADO')),
    valor_total DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK (valor_total >= 0),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
        ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 9. ITEM DO PEDIDO
CREATE TABLE item_pedido (
    id_item INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pedido INTEGER NOT NULL,
    id_produto INTEGER NOT NULL,
    quantidade INTEGER NOT NULL CHECK (quantidade > 0),
    preco_unitario DECIMAL(10,2) NOT NULL CHECK (preco_unitario > 0),
    subtotal DECIMAL(10,2) NOT NULL CHECK (subtotal > 0),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 10. PAGAMENTO
CREATE TABLE pagamento (
    id_pagamento INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pedido INTEGER NOT NULL,
    data_pagamento DATETIME NOT NULL DEFAULT (DATETIME('now')),
    valor_pago DECIMAL(10,2) NOT NULL CHECK (valor_pago > 0),
    forma_pagamento VARCHAR(30) NOT NULL CHECK (forma_pagamento IN ('PIX', 'CARTAO_CREDITO', 'CARTAO_DEBITO', 'DINHEIRO')),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
        ON UPDATE CASCADE ON DELETE RESTRICT
);