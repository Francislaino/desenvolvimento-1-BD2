CREATE DATABASE SistemaDeVendas;
USE SistemaDeVendas;

CREATE TABLE Clientes (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    telefone VARCHAR(15)
);

CREATE TABLE Produtos (
    produto_id INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100),
    preco DECIMAL(10, 2)
);

CREATE TABLE Pedidos (
    pedido_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    data_pedido DATE,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id)
);

CREATE TABLE ItensPedidos (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    produto_id INT,
    quantidade INT,
    preco_unitario DECIMAL(10, 2),
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(pedido_id),
    FOREIGN KEY (produto_id) REFERENCES Produtos(produto_id)
);

INSERT INTO Clientes (nome, email, telefone) VALUES
('João Silva', 'joao.silva@email.com', '123456789'),
('Maria Oliveira', 'maria.oliveira@email.com', '987654321');

INSERT INTO Produtos (nome_produto, preco) VALUES
('Notebook', 2500.00),
('Mouse', 150.00),
('Teclado', 300.00);
INSERT INTO Pedidos (cliente_id, data_pedido) VALUES
(1, '15-12-2024'),
(2, '16-12-2024');

INSERT INTO ItensPedidos (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 2500.00),
(1, 2, 2, 150.00),
(2, 3, 1, 300.00);

SELECT Pedidos.pedido_id, Clientes.nome AS cliente_nome, Produtos.nome_produto, ItensPedidos.quantidade
FROM Pedidos
INNER JOIN Clientes ON Pedidos.cliente_id = Clientes.cliente_id
INNER JOIN ItensPedidos ON Pedidos.pedido_id = ItensPedidos.pedido_id
INNER JOIN Produtos ON ItensPedidos.produto_id = Produtos.produto_id;

SELECT Pedidos.pedido_id, Clientes.nome AS cliente_nome, Produtos.nome_produto, ItensPedidos.quantidade
FROM Pedidos
LEFT JOIN Clientes ON Pedidos.cliente_id = Clientes.cliente_id
LEFT JOIN ItensPedidos ON Pedidos.pedido_id = ItensPedidos.pedido_id
LEFT JOIN Produtos ON ItensPedidos.produto_id = Produtos.produto_id;

SELECT Produtos.nome_produto, Pedidos.pedido_id, Clientes.nome AS cliente_nome
FROM Produtos
RIGHT JOIN ItensPedidos ON Produtos.produto_id = ItensPedidos.produto_id
RIGHT JOIN Pedidos ON ItensPedidos.pedido_id = Pedidos.pedido_id
RIGHT JOIN Clientes ON Pedidos.cliente_id = Clientes.cliente_id;

SELECT Clientes.nome AS cliente_nome, Pedidos.pedido_id
FROM Clientes
LEFT JOIN Pedidos ON Clientes.cliente_id = Pedidos.cliente_id
UNION
SELECT Clientes.nome AS cliente_nome, Pedidos.pedido_id
FROM Clientes
RIGHT JOIN Pedidos ON Clientes.cliente_id = Pedidos.cliente_id;
