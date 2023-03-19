CREATE DATABASE SAFE_FOOD_DB;
USE SAFE_FOOD_DB;

CREATE TABLE SafeFood_Usuario (
	IdUsuario CHAR(36) NOT NULL UNIQUE,
	NomeUsuario VARCHAR(30) NOT NULL,
	EmailUsuario VARCHAR(50) NOT NULL UNIQUE,
	SenhaUsuario VARCHAR(20) NOT NULL,
	TelefoneUsuario CHAR(17) NOT NULL,
	DataCadastro VARCHAR(30) NOT NULL,
	ImagemUsuario VARCHAR(100),
	PRIMARY KEY(IdUsuario)
);

CREATE TABLE SafeFood_Estabelecimento (
	IdEstabelecimento CHAR(36) NOT NULL UNIQUE,
	FkUsuario CHAR(36) NOT NULL UNIQUE,
	CnpjEstabelecimento CHAR(14) NOT NULL UNIQUE,
	CepEstabelecimento CHAR(9) NOT NULL,
	RuaEstabelecimento VARCHAR(30) NOT NULL,
	BairroEstabelecimento VARCHAR(30) NOT NULL,
	NumeroLocalEstabelecimento VARCHAR(5) NOT NULL,
	CidadeEstabelecimento VARCHAR(30) NOT NULL,
	DescricaoEstabelecimento VARCHAR(100),
	EstabelecimentoAberto BIT,
	PRIMARY KEY(IdEstabelecimento),
	FOREIGN KEY(FkUsuario) REFERENCES SafeFood_Usuario
);

CREATE TABLE SafeFood_Consumidor(
	IdConsumidor CHAR(36) NOT NULL UNIQUE,
	FkUsuario CHAR(36) NOT NULL UNIQUE,
	PRIMARY KEY (IdConsumidor),
	FOREIGN KEY (FkUsuario) REFERENCES SafeFood_Usuario
);

CREATE TABLE SafeFood_Endereco_Consumidor(
	IdEnderecoConsumidor CHAR(36) NOT NULL UNIQUE,
	FkConsumidor CHAR(36) NOT NULL,
	ApelidoEnderecoConsumidor VARCHAR(20) NOT NULL,
	CepConsumidor CHAR(9) NOT NULL,
	RuaConsumidor VARCHAR(30) NOT NULL,
	BairroConsumidor VARCHAR(30) NOT NULL,
	NumeroLocaConsumidor VARCHAR(5) NOT NULL,
	CidadeConsumidor VARCHAR(30) NOT NULL,
	DataInsercao VARCHAR(30) NOT NULL,
	PRIMARY KEY(IdEnderecoConsumidor),
	FOREIGN KEY (fkConsumidor) REFERENCES SafeFood_Consumidor
);

CREATE TABLE SafeFood_Categoria_Restricao(
	IdCategoriaRestricao CHAR(36) NOT NULL UNIQUE,
	TituloCategoriaRestricao VARCHAR(20) NOT NULL UNIQUE,
	PRIMARY KEY (IdCategoriaRestricao)
);

CREATE TABLE SafeFood_Restricao(
	IdRestricao CHAR(36) NOT NULL UNIQUE,
	TituloRestricao VARCHAR(20) NOT NULL UNIQUE,
	DescricaoRestricao VARCHAR(50) NOT NULL,
	FkCategoriaRestricao CHAR(36) NOT NULL
	PRIMARY KEY (IdRestricao),
	FOREIGN KEY (FkCategoriaRestricao) REFERENCES SafeFood_Categoria_Restricao
);

CREATE TABLE SafeFood_Categoria_Produto(
	IdCategoriaProduto CHAR(36) NOT NULL UNIQUE,
	TituloCategoriaProduto CHAR(20) NOT NULL UNIQUE,
	PRIMARY KEY (IdCategoriaProduto)
);

CREATE TABLE SafeFood_Produto(
	IdProduto CHAR(36) NOT NULL UNIQUE,
	TituloProduto VARCHAR(30) NOT NULL,
	DescricaoProduto VARCHAR(100),
	PrecoProduto SMALLMONEY NOT NULL,
	ImagemProduto VARCHAR(100),
	FkEstabelecimento CHAR(36) NOT NULL,
	FkCategoriaProduto CHAR(36) NOT NULL,
	DataInsercao VARCHAR(30) NOT NULL,
	PRIMARY KEY (IdProduto),
	FOREIGN KEY (FkEstabelecimento) REFERENCES SafeFood_Estabelecimento,
	FOREIGN KEY (FkCategoriaProduto) REFERENCES SafeFood_Categoria_Produto
);

CREATE TABLE SafeFood_Restricao_Produto(
	FkProduto CHAR(36) NOT NULL,
	FkRestricao CHAR(36)  NOT NULL,
	DataInsercao VARCHAR(30) NOT NULL,
	PRIMARY KEY (FkProduto, FkRestricao),
	FOREIGN KEY (FkRestricao) REFERENCES SafeFood_Restricao,
	FOREIGN KEY (FkProduto) REFERENCES SafeFood_Produto
);

CREATE TABLE SafeFood_Restricao_Consumidor(
	FkConsumidor CHAR(36) NOT NULL,
	FkRestricao CHAR(36)  NOT NULL,
	DataInsercao VARCHAR(30) NOT NULL,
	PRIMARY KEY (FkConsumidor, FkRestricao),
	FOREIGN KEY (FkRestricao) REFERENCES SafeFood_Restricao,
	FOREIGN KEY (FkConsumidor) REFERENCES SafeFood_Consumidor
);

CREATE TABLE SafeFood_Avaliacao(
	FkConsumidor CHAR(36) NOT NULL,
	FkProduto CHAR(36)  NOT NULL,
	Rate DECIMAL,
	TituloComentarioProduto CHAR(30),
	DescricaoComentarioProduto CHAR(100),
	DataInsercao VARCHAR(30) NOT NULL,
	PRIMARY KEY (FkConsumidor, FkProduto),
	FOREIGN KEY (FkProduto) REFERENCES SafeFood_Produto,
	FOREIGN KEY (FkConsumidor) REFERENCES SafeFood_Consumidor
);


/* EXEMPLO DE CADASTRO DE ESTABELECIMENTO */
insert into SafeFood_Usuario values('72fe51df-359d-42f-9b46-c40d3f45714c', 'Angolas', 'angolano@gmail.com', CONVERT(VARCHAR(20), HASHBYTES('md5', '23564')), '+55 (11)967584657', 'Sun Mar 19 04:28:58 BRT 2023', null);
insert into SafeFood_Estabelecimento values('72fe51df-359d-42f-2346-c40d3f45714c', '72fe51df-359d-42f-9b46-c40d3f45714c', '12345678901234', '02736-123', 'Rua Augusta', 'Consolacao', '254', 'Sao Paulo', null, null);

/* EXEMPLO DE LOGIN DE ESTABELECIMENTO */
select SafeFood_Usuario.IdUsuario from SafeFood_Usuario where EmailUsuario = 'angolano@gmail.com' and SenhaUsuario = CONVERT(VARCHAR(20), HASHBYTES('md5', '23564'));

/* EXEMPLO DE CADASTRO DE CONSUMIDOR */
insert into SafeFood_Usuario values ('72fe51df-359d-42f-9b46-c40d3f457967', 'Vinicius Soares de Souza', 'vinicius@gmail.com', CONVERT(VARCHAR(20), HASHBYTES('md5', '12345')), '+55 (11)976964512', 'Sun Mar 19 04:28:58 BRT 2023', null);
insert into SafeFood_Consumidor values ('72fe51df-359d-42f-9b46-c40d3f446587', '72fe51df-359d-42f-9b46-c40d3f457967');

/* EXEMPLO DE LOGIN DE CONSUMIDOR */
select SafeFood_Usuario.IdUsuario from SafeFood_Usuario where EmailUsuario = 'vinicius@gmail.com' and SenhaUsuario = CONVERT(VARCHAR(20), HASHBYTES('md5', '12345'));



/* REMOVER TODOS OS DADOS DAS TABELAS */
DELETE FROM SafeFood_Restricao;
DELETE FROM SafeFood_Restricao_Produto;
DELETE FROM SafeFood_Restricao_Consumidor;
DELETE FROM SafeFood_Avaliacao;
DELETE FROM SafeFood_Categoria_Restricao;
DELETE FROM SafeFood_Restricao;
DELETE FROM SafeFood_Endereco_Consumidor;
DELETE FROM SafeFood_Consumidor;
DELETE FROM SafeFood_Estabelecimento;
DELETE FROM SafeFood_Usuario;

/* SELECT DE TODAS AS TABELAS */
SELECT * FROM SafeFood_Restricao_Produto;
SELECT * FROM SafeFood_Restricao_Consumidor;
SELECT * FROM SafeFood_Avaliacao;
SELECT * FROM SafeFood_Restricao;
SELECT * FROM SafeFood_Categoria_Restricao;
SELECT * FROM SafeFood_Consumidor;
SELECT * FROM SafeFood_Estabelecimento;
SELECT * FROM SafeFood_Endereco_Consumidor;
SELECT * FROM SafeFood_Usuario;

/* DELETAR TABELAS (NÃO TROCAR A ORDEM) */
DROP TABLE SafeFood_Restricao_Produto;
DROP TABLE SafeFood_Restricao_Consumidor;
DROP TABLE SafeFood_Avaliacao;
DROP TABLE SafeFood_Restricao;
DROP TABLE SafeFood_Categoria_Restricao;
DROP TABLE SafeFood_Endereco_Consumidor;
DROP TABLE SafeFood_Consumidor;
DROP TABLE SafeFood_Produto;
DROP TABLE SafeFood_Categoria_Produto;
DROP TABLE SafeFood_Estabelecimento;
DROP TABLE SafeFood_Usuario;

/* APAGAR BANCO DE DADOS */
DROP DATABASE SAFE_FOOD_DB;