use oficina
CREATE TABLE cliente (
  idcliente INT NOT NULL AUTO_INCREMENT,
  cpf CHAR(11) NULL,
  contato CHAR(10) NULL,
  modo_pagamento ENUM("Debito", "Credito", "Pix") NULL,
  cliente_idcliente INT NOT NULL,
  PRIMARY KEY (`idcliente`, `cliente_idcliente`));



CREATE TABLE cadastro_carro (
  id_cliente INT NOT NULL AUTO_INCREMENT,
  placa_carro VARCHAR(45) NOT NULL unique,
  Marca VARCHAR(45) NULL,
  Ano INT NULL,
  Cilindrada INT NULL,
  cadastro_carrocol VARCHAR(45) NULL,
  cliente_idcliente INT NOT NULL,
  PRIMARY KEY (`id_cliente`, `placa_carro`),
  CONSTRAINT fk_cadastro_carro_cliente1 FOREIGN KEY (`cliente_idcliente`) REFERENCES cliente (idcliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE TABLE IF NOT EXISTS servico_prestado (
  idservico_prestado INT NOT NULL AUTO_INCREMENT,
  Tipo_servico ENUM("corretivo", "Preventivo") NULL,
  Descricao VARCHAR(45) NULL,
  cliente_idcliente INT NOT NULL,
  Pagamento_cliente_idcliente INT NOT NULL,
  Pagamento_cliente_cliente_idcliente INT NOT NULL,
  PRIMARY KEY (`idservico_prestado`, `Pagamento_cliente_idcliente`, `Pagamento_cliente_cliente_idcliente`),
  INDEX fk_servico_prestado_cliente1_idx (`cliente_idcliente` ASC) VISIBLE,
  INDEX fk_servico_prestado_Pagamento1_idx (`Pagamento_cliente_idcliente` ASC, `Pagamento_cliente_cliente_idcliente` ASC) VISIBLE,
  CONSTRAINT fk_servico_prestado_cliente1 FOREIGN KEY (`cliente_idcliente`) REFERENCES cliente (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_servico_prestado_Pagamento1 FOREIGN KEY (`Pagamento_cliente_idcliente` , `Pagamento_cliente_cliente_idcliente`)
    REFERENCES Pagamento (`cliente_idcliente` , `cliente_cliente_idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;
   
 

CREATE TABLE orcamento (
  idorcamento INT NOT NULL,
  materila VARCHAR(45) NULL,
  mao_de_obra VARCHAR(45) NULL,
  PRIMARY KEY (`idorcamento`))
;

CREATE TABLE Pagamento (
  Preco DOUBLE NOT NULL,
  cliente_idcliente INT NOT NULL,
  cliente_cliente_idcliente INT NOT NULL,
  orcamento_idorcamento INT NOT NULL,
  PRIMARY KEY (`cliente_idcliente`, `cliente_cliente_idcliente`, `orcamento_idorcamento`),
  INDEX fk_Pagamento_orcamento1_idx (`orcamento_idorcamento` ASC) VISIBLE,
  CONSTRAINT fk_Pagamento_cliente1 FOREIGN KEY (`cliente_idcliente` , `cliente_cliente_idcliente`) REFERENCES cliente (`idcliente` , `cliente_idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Pagamento_orcamento1 FOREIGN KEY (`orcamento_idorcamento`) REFERENCES orcamento (`idorcamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE TABLE IF NOT EXISTS time_manutencao (
  idtime_manutencao INT NOT NULL,
  qtd_colaboradores INT NULL,
  skill VARCHAR(45) NULL,
  servico_prestado_idservico_prestado INT NOT NULL,
  PRIMARY KEY (`idtime_manutencao`),
  INDEX fk_time_manutencao_servico_prestado1_idx (`servico_prestado_idservico_prestado` ASC) VISIBLE,
  CONSTRAINT fk_time_manutencao_servico_prestado1 FOREIGN KEY (`servico_prestado_idservico_prestado`)
    REFERENCES servico_prestado (`idservico_prestado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ;
