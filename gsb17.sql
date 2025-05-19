 CREATE DATABASE IF NOT EXISTS MeuBanco;
USE MeuBanco;

CREATE TABLE Clientes (
    ClienteID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Cidade VARCHAR(50)
);

CREATE TABLE Categorias (
    CategoriaID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Descricao VARCHAR(255)
);

CREATE TABLE Produtos (
    ProdutoID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Preco DECIMAL(10,2) NOT NULL,
    CategoriaID INT,
    FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID)
);

CREATE TABLE Pedidos (
    PedidoID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT,
    DataPedido DATE NOT NULL,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

CREATE TABLE ItensPedido (
    ItemID INT AUTO_INCREMENT PRIMARY KEY,
    PedidoID INT,
    ProdutoID INT,
    Quantidade INT NOT NULL,
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID),
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID)
);

INSERT INTO Clientes (Nome, Email, Cidade) VALUES
('José Silva', 'jose.silva@example.com', 'São Paulo'),
('Maria Souza', 'maria.souza@example.com', 'Rio de Janeiro'),
('João Pereira', 'joao.pereira@example.com', 'Belo Horizonte'),
('Ana Oliveira', 'ana.oliveira@example.com', 'Curitiba'),
('Carla Santos', 'carla.santos@example.com', 'Porto Alegre'),
('Pedro Almeida', 'pedro.almeida@example.com', 'Fortaleza'),
('Lucas Costa', 'lucas.costa@example.com', 'Salvador'),
('Mariana Rocha', 'mariana.rocha@example.com', 'Recife'),
('Rafael Lima', 'rafael.lima@example.com', 'Brasília'),
('Fernanda Melo', 'fernanda.melo@example.com', 'Manaus');

INSERT INTO Categorias (Nome, Descricao) VALUES
('Eletrônicos', 'Aparelhos eletrônicos em geral'),
('Livros', 'Livros de diversos gêneros'),
('Roupas', 'Vestuário masculino e feminino'),
('Móveis', 'Móveis para casa e escritório'),
('Beleza', 'Produtos de beleza e cuidado pessoal'),
('Esportes', 'Artigos esportivos'),
('Alimentos', 'Comidas e bebidas'),
('Brinquedos', 'Brinquedos para crianças'),
('Ferramentas', 'Ferramentas manuais e elétricas'),
('Automotivo', 'Peças e acessórios para veículos');

INSERT INTO Produtos (Nome, Preco, CategoriaID) VALUES
('Smartphone XYZ', 1999.90, 1),
('Notebook ABC', 3499.00, 1),
('Livro "Aprendendo SQL"', 79.90, 2),
('Camisa Polo', 89.90, 3),
('Sofá 3 Lugares', 1299.00, 4),
('Shampoo Antiqueda', 24.50, 5),
('Bola de Futebol', 59.90, 6),
('Café Torrado', 29.90, 7),
('Boneca Barbie', 149.90, 8),
('Furadeira Elétrica', 199.90, 9);

INSERT INTO Pedidos (ClienteID, DataPedido) VALUES
(1, '2025-01-10'),
(2, '2025-01-15'),
(3, '2025-02-05'),
(4, '2025-02-20'),
(5, '2025-03-01'),
(6, '2025-03-10'),
(7, '2025-04-01'),
(8, '2025-04-15'),
(9, '2025-05-01'),
(10, '2025-05-10');

INSERT INTO ItensPedido (PedidoID, ProdutoID, Quantidade) VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 1),
(2, 4, 3),
(3, 5, 1),
(3, 7, 2),
(4, 6, 1),
(4, 8, 4),
(5, 9, 1),
(5, 10, 1);

SELECT p.PedidoID, c.Nome, p.DataPedido
FROM Pedidos p
INNER JOIN Clientes c ON p.ClienteID = c.ClienteID
WHERE c.Nome LIKE 'J%';

SELECT pr.Nome AS Produto, ca.Nome AS Categoria
FROM Produtos pr
INNER JOIN Categorias ca ON pr.CategoriaID = ca.CategoriaID
WHERE ca.Nome LIKE '%Liv%';

SELECT ip.PedidoID, pr.Nome, ip.Quantidade
FROM ItensPedido ip
INNER JOIN Produtos pr ON ip.ProdutoID = pr.ProdutoID
WHERE pr.Nome LIKE '%Pro%';

SELECT c.Nome, p.PedidoID, p.DataPedido
FROM Clientes c
INNER JOIN Pedidos p ON c.ClienteID = p.ClienteID
WHERE p.DataPedido LIKE '2025-04%';

SELECT p.PedidoID, c.Nome AS Cliente, pr.Nome AS Produto, ca.Nome AS Categoria
FROM Pedidos p
INNER JOIN Clientes c ON p.ClienteID = c.ClienteID
INNER JOIN ItensPedido ip ON p.PedidoID = ip.PedidoID
INNER JOIN Produtos pr ON ip.ProdutoID = pr.ProdutoID
INNER JOIN Categorias ca ON pr.CategoriaID = ca.CategoriaID
WHERE ca.Nome LIKE '%Eletr%';
