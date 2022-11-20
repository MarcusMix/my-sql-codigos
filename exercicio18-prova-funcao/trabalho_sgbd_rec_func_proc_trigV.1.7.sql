-- SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS DBCARTAOCREDITO;
CREATE DATABASE DBCARTAOCREDITO;
USE DBCARTAOCREDITO;
-- SET sql_mode = '';


CREATE TABLE CLIENTE (
	IDCLIENTE INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(100) NOT NULL,
	CPF CHAR(11) NOT NULL,
	RG VARCHAR(16),
	LOGRADOURO VARCHAR(100),
	NUMERO VARCHAR(10),
	BAIRRO VARCHAR(100),
	CIDADE VARCHAR(100),
	UF CHAR(2),
	COMPLEMENTO VARCHAR(100),
	DT_NASCIMENTO DATE,
	TELEFONE_RESIDENCIAL VARCHAR(15),
	TELEFONE_COMERCIAL VARCHAR(15),
	TELEFONE_RECADO VARCHAR(15)
);
CREATE TABLE CARTAO (
	IDCARTAO INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	IDCLIENTE INT NOT NULL,
	NUMERO CHAR(17) NOT NULL,
	DIA_VENCIMENTO INT NOT NULL,
	LIMITE NUMERIC(8,2),
	CONSTRAINT FK_CARTAO_CLIENTE FOREIGN KEY (IDCLIENTE) REFERENCES CLIENTE(IDCLIENTE)
);

CREATE TABLE DEBITO (
	IDDEBITO INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	IDCARTAO INT NOT NULL,
	DESCRICAO VARCHAR(255) NOT NULL,
	PARCELA NUMERIC(8,2),
	VALOR NUMERIC(8,2) NOT NULL, 
	DT_DEBITO DATETIME,
	CONSTRAINT FK_DEBITO_CARTAO FOREIGN KEY (IDCARTAO) REFERENCES CARTAO(IDCARTAO)
);

CREATE TABLE BOLETO (
	IDBOLETO INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	IDCARTAO INT NOT NULL,
	DT_GERACAO DATE NOT NULL,
	DT_VENCIMENTO DATE NOT NULL,
	VALOR_TOTAL NUMERIC(8,2) NOT NULL, 
	DT_PAGAMENTO DATE,
	VALOR_PAGO NUMERIC(8,2), 
	CONSTRAINT FK_BOLETO_CLIENTE FOREIGN KEY (IDCARTAO) REFERENCES CARTAO(IDCARTAO)
);


CREATE TABLE ITEM_BOLETO (
	IDITEM_BOLETO INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	IDBOLETO INT NOT NULL,
	IDDEBITO INT NOT NULL,
    DESCRICAO VARCHAR(255),
	CONSTRAINT FK_ITEM_BOLETO_BOLETO FOREIGN KEY (IDBOLETO) REFERENCES BOLETO(IDBOLETO),
	CONSTRAINT FK_ITEM_BOLETO_DEBITO FOREIGN KEY (IDDEBITO) REFERENCES DEBITO(IDDEBITO)
);


-- função escrever por extenso
DROP FUNCTION IF EXISTS FN_EXTENSO;
DELIMITER $$
CREATE FUNCTION FN_EXTENSO(pVALOR  NUMERIC(17,2)) RETURNS TEXT deterministic
BEGIN
	-- VARIAVEL PARA VERIFICAR O GRUPO DA DIREITA PARA A ESQUERDA
    DECLARE vGRUPO INT DEFAULT 0;
    -- VARIAVEL PARA TRABALHAR COM O VALOR INFORMADO NO FORMATO TEXTO
    DECLARE vVALORTEXTO VARCHAR(100);
    -- VARIAVEL PARA TRABALHAR COM O VALOR DE CADA GRUPO
    DECLARE VALOR  NUMERIC(14,2);
    -- TEXT DO NUMERO
    DECLARE vTEXTO TEXT DEFAULT '';
    DECLARE EXTENSO TEXT DEFAULT '';
    -- RESULTADO
    DECLARE vRESULTADO TEXT DEFAULT '';

    -- TRANSFORMANDO O NUMERO EM TEXTO
    SET vVALORTEXTO = pVALOR;

    -- PERCORRENDO O VALOR
    WHILE (LENGTH(vVALORTEXTO) > 0 ) DO
 
        SET vGRUPO = vGRUPO + 1;
 
        IF vGRUPO = 1 THEN
            SET VALOR = REPLACE(RIGHT(vVALORTEXTO, 3), '.', '');
        ELSE
            SET VALOR = RIGHT(vVALORTEXTO, 3);
        END IF;

        WHILE (VALOR > 0) DO
            CASE 
                WHEN VALOR = 1 THEN
                    SET EXTENSO = 'UM';
                    SET VALOR = VALOR - 1;
                WHEN VALOR = 2 THEN 
                    SET EXTENSO = 'DOIS';
                    SET VALOR = VALOR - 2;
                WHEN VALOR = 3 THEN 
                    SET EXTENSO = 'TRES';
                    SET VALOR = VALOR - 3;
                WHEN VALOR = 4 THEN 
                    SET EXTENSO = 'QUATRO';
                    SET VALOR = VALOR - 4;
                WHEN VALOR = 5 THEN 
                    SET EXTENSO = 'CINCO';
                    SET VALOR = VALOR - 5;
                WHEN VALOR = 6 THEN 
                    SET EXTENSO = 'SEIS';
                    SET VALOR = VALOR - 6;
                WHEN VALOR = 7 THEN 
                    SET EXTENSO = 'SETE';
                    SET VALOR = VALOR - 7;
                WHEN VALOR = 8 THEN 
                    SET EXTENSO = 'OITO';
                    SET VALOR = VALOR - 8;
                WHEN VALOR = 9 THEN 
                    SET EXTENSO = 'NOVE';
                    SET VALOR = VALOR - 9;
                WHEN VALOR = 10 THEN 
                    SET EXTENSO = 'DEZ';
                    SET VALOR = VALOR - 10;
                WHEN VALOR = 11 THEN 
                    SET EXTENSO = 'ONZE';
                    SET VALOR = VALOR - 11;
                WHEN VALOR = 12 THEN 
                    SET EXTENSO = 'DOZE';
                    SET VALOR = VALOR - 12;
                WHEN VALOR = 13 THEN 
                    SET EXTENSO = 'TREZE';
                    SET VALOR = VALOR - 13;
                WHEN VALOR = 14 THEN 
                    SET EXTENSO = 'CATORZE';
                    SET VALOR = VALOR - 14;
                WHEN VALOR = 15 THEN 
                     SET EXTENSO = 'QUINZE';
                     SET VALOR = VALOR - 15;
                WHEN VALOR = 16 THEN 
                     SET EXTENSO = 'DEZESSEIS';
                     SET VALOR = VALOR - 16;
                WHEN VALOR = 17 THEN 
                     SET EXTENSO = 'DEZESSETE';
                     SET VALOR = VALOR - 17;
                WHEN VALOR = 18 THEN 
                     SET EXTENSO = 'DEZOITO';
                     SET VALOR = VALOR - 18;
                WHEN VALOR = 19 THEN 
                     SET EXTENSO = 'DEZENOVE';
                     SET VALOR = VALOR - 19;
                WHEN VALOR BETWEEN 20 AND 29 THEN 
                     SET EXTENSO = 'VINTE';
                     SET VALOR = VALOR - 20;
                WHEN VALOR BETWEEN 30 AND 39 THEN 
                     SET EXTENSO = 'TRINTA';
                     SET VALOR = VALOR - 30;
                WHEN VALOR BETWEEN 40 AND 49 THEN 
                     SET EXTENSO = 'QUARENTA';
                     SET VALOR = VALOR - 40;
                WHEN VALOR BETWEEN 50 AND 59 THEN 
                     SET EXTENSO = 'CINQUENTA';
                     SET VALOR = VALOR - 50;
                WHEN VALOR BETWEEN 60 AND 69 THEN 
                     SET EXTENSO = 'SESSENTA';
                     SET VALOR = VALOR - 60;
                WHEN VALOR BETWEEN 70 AND 79 THEN 
                     SET EXTENSO = 'SETENTA';
                     SET VALOR = VALOR - 70;
                WHEN VALOR BETWEEN 80 AND 89 THEN 
                     SET EXTENSO = 'OITENTA';
                     SET VALOR = VALOR - 80;
                WHEN VALOR BETWEEN 90 AND 99 THEN 
                     SET EXTENSO = 'NOVENTA';
                     SET VALOR = VALOR - 90;
                WHEN VALOR = 100 THEN 
                     SET EXTENSO = 'CEM';
                     SET VALOR = VALOR - 100;
                WHEN VALOR >= 100 AND VALOR < 200 THEN 
                     SET EXTENSO = 'CENTO';
                     SET VALOR = VALOR - 100;
                WHEN VALOR >= 200 AND VALOR < 300 THEN 
                     SET EXTENSO = 'DUZENTOS';
                     SET VALOR = VALOR - 200;
                WHEN VALOR >= 300 AND VALOR < 400 THEN 
                     SET EXTENSO = 'TREZENTOS';
                     SET VALOR = VALOR - 300;
                WHEN VALOR >= 400 AND VALOR < 500 THEN 
                     SET EXTENSO = 'QUATROCENTOS';
                     SET VALOR = VALOR - 400;
                WHEN VALOR >= 500 AND VALOR < 600 THEN 
                     SET EXTENSO = 'QUINHENTOS';
                     SET VALOR = VALOR - 500;
                WHEN VALOR >= 600 AND VALOR < 700 THEN 
                     SET EXTENSO = 'SEISCENTOS';
                     SET VALOR = VALOR - 600;
                WHEN VALOR >= 700 AND VALOR < 800 THEN 
                     SET EXTENSO = 'SETECENTOS';
                     SET VALOR = VALOR - 700;
                WHEN VALOR >= 800 AND VALOR < 900 THEN 
                     SET EXTENSO = 'OITOCENTOS';
                     SET VALOR = VALOR - 800;
                WHEN VALOR >= 900 AND VALOR < 1000 THEN 
                     SET EXTENSO = 'NOVECENTOS';
                     SET VALOR = VALOR - 900;
                ELSE
                     SET EXTENSO = 'ERRO';
                     SET VALOR = -1;
            END CASE;
               
            IF vTEXTO <> '' THEN
                SET vTEXTO = CONCAT(vTEXTO, ' E ');
            END IF;
            SET vTEXTO = CONCAT(vTEXTO, EXTENSO);

        END WHILE;

        CASE vGRUPO
            WHEN 1 THEN 

                SET VALOR = REPLACE(RIGHT(vVALORTEXTO, 3), '.', '');
                IF VALOR = 0 THEN
                    SET vTEXTO = CONCAT(vTEXTO, '');
                ELSEIF VALOR = 1 THEN
                    SET vTEXTO = CONCAT(vTEXTO, ' CENTAVO');
                ELSE
                    SET vTEXTO = CONCAT(vTEXTO, ' CENTAVOS');
                END IF;
 
            WHEN 2 THEN

                SET VALOR = REPLACE(RIGHT(vVALORTEXTO, 3), '.', '');
                IF VALOR = 0 THEN
                    SET vTEXTO = CONCAT(vTEXTO, '');
                ELSEIF VALOR = 1 THEN
                    SET vTEXTO = CONCAT(vTEXTO, ' REAL');
                ELSE
                    SET vTEXTO = CONCAT(vTEXTO, ' REAIS');
                END IF;

            WHEN 3 THEN SET vTEXTO = CONCAT(vTEXTO, ' MIL');
            WHEN 4 THEN

                SET VALOR = REPLACE(RIGHT(vVALORTEXTO, 3), '.', '');
                IF VALOR = 0 THEN
                    SET vTEXTO = CONCAT(vTEXTO, '');
                ELSEIF VALOR = 1 THEN
                    SET vTEXTO = CONCAT(vTEXTO, ' MILHÃO');
                ELSE
                    SET vTEXTO = CONCAT(vTEXTO, ' MILHÕES');
                END IF;

            WHEN 5 THEN 
                
                SET VALOR = REPLACE(RIGHT(vVALORTEXTO, 3), '.', '');
                IF VALOR = 0 THEN
                    SET vTEXTO = CONCAT(vTEXTO, '');
                ELSEIF VALOR = 1 THEN
                    SET vTEXTO = CONCAT(vTEXTO, ' BILHÃO');
                ELSE
                    SET vTEXTO = CONCAT(vTEXTO, ' BILHÕES');
                END IF;

            WHEN 6 THEN 
                
                SET VALOR = REPLACE(RIGHT(vVALORTEXTO, 3), '.', '');
                IF VALOR = 0 THEN
                    SET vTEXTO = CONCAT(vTEXTO, '');
                ELSEIF VALOR = 1 THEN
                    SET vTEXTO = CONCAT(vTEXTO, ' TRILHÃO');
                ELSE
                    SET vTEXTO = CONCAT(vTEXTO, ' TRILHÕES');
                END IF;

        END CASE;

        IF vRESULTADO <> '' THEN
            IF vGRUPO = 2 THEN
                SET vRESULTADO = CONCAT(' E ', vRESULTADO);
            ELSE
                SET vRESULTADO = CONCAT(' E ', vRESULTADO);
            END IF;
        END IF;

        SET vRESULTADO = CONCAT(vTEXTO, '', vRESULTADO);
        SET vTEXTO = '';
        SET vVALORTEXTO = TRIM(LEFT(vVALORTEXTO, LENGTH(vVALORTEXTO) - 3));

    END WHILE;

    RETURN vRESULTADO;

END $$
DELIMITER ;




-- view saldo
CREATE VIEW vw_saldo AS
SELECT cliente.nome AS NOME,
	   cliente.cpf AS CPF,
	   cartao.idcartao AS IDCARTAO,
	   (cartao.limite -
	   SUM(debito.valor)) AS SALDO_ATUAL,
       SUM(debito.valor) AS GASTOS,
       cartao.limite AS SALDO_TOTAL
FROM cliente
INNER JOIN cartao ON
       cliente.idcliente = cartao.idcartao
INNER JOIN debito ON
	   cartao.idcartao = debito.idcartao
GROUP BY cliente.nome,
	     cliente.cpf,
         cartao.limite,
	     cartao.idcartao;


-- view extrato
CREATE VIEW vw_extrato AS
SELECT cliente.idcliente AS idCLIENTE,
	   cliente.nome AS NOME,
       CONCAT(CONCAT(SUBSTR(cartao.numero, 1, 2), LPAD('', '13', '-')), SUBSTR(cartao.numero, 14, 2)) AS NUMERO_DO_CARTÃO,
       debito.dt_debito AS DATA_COMPRA,
	   debito.descricao AS DESCRIÇÃO,
	   debito.parcela AS VALOR_PARCELAS,
	   debito.valor AS VALOR_DO_PRODUTO
FROM cliente 
INNER JOIN cartao ON
cliente.idcliente = cartao.idcartao
INNER JOIN debito ON
debito.idcartao = cartao.idcartao;


-- view boleto
CREATE VIEW vw_boleto AS
SELECT cliente.nome AS NOME,
	   cliente.numero AS NUMERO,
       cliente.bairro AS BAIRRO,
       cliente.cidade AS CIDADE,
       cliente.uf AS ESTADO,
       cliente.complemento AS COMPLEMENTO,
       cartao.numero AS NUMERO_DO_CARTÃO,
	   boleto.dt_geracao AS DATA_GERAÇÃO,
       boleto.valor_total AS VALOR_TOTAL,
       (SELECT FN_EXTENSO(boleto.valor_total)) AS VALOR_EXTENSO,
       boleto.dt_vencimento AS DATA_VENCIMENTO
FROM cliente 
INNER JOIN cartao ON
cliente.idcliente = cartao.idcliente
INNER JOIN boleto ON
boleto.idcartao = cartao.idcartao 
ORDER BY cliente.nome;

-- view boleto detalhado
CREATE VIEW vw_boleto_detalhado AS
SELECT boleto.idboleto AS NUMERO_BOLETO,
	   item_boleto.iditem_boleto AS NUMERO_ITEM,
       debito.descricao AS DESCRIÇÃO_ITEM,
       debito.valor AS VALOR_ITEM,
       boleto.dt_pagamento AS DATA_PARCELA
FROM boleto 
INNER JOIN item_boleto ON
item_boleto.idboleto = boleto.idboleto
INNER JOIN debito ON
item_boleto.iddebito = debito.iddebito
INNER JOIN cartao ON
cartao.idcartao = debito.idcartao;

    
    
DELIMITER $$
-- VALIDAR CPF!!!


CREATE FUNCTION FN_VALIDACPF (pCPF VARCHAR(11)) RETURNS INT DETERMINISTIC
BEGIN
	DECLARE vCPF CHAR(11);
    DECLARE vDIGITO1 CHAR(1);
    DECLARE vDIGITO2 CHAR(1);
    DECLARE vCALCULO_DIGITO INT;
    
    
    IF length(pCPF) = 11 THEN
		-- CALCULANDO PRIMEIRO DIGITO
		SET vCPF = SUBSTR(pCPF, 1, 9);
		SET vCALCULO_DIGITO = 	(CONVERT(SUBSTR(vCPF, 1, 1), UNSIGNED) * 10) +
								(CONVERT(SUBSTR(vCPF, 2, 1), UNSIGNED) * 09) +
								(CONVERT(SUBSTR(vCPF, 3, 1), UNSIGNED) * 08) +
								(CONVERT(SUBSTR(vCPF, 4, 1), UNSIGNED) * 07) +
								(CONVERT(SUBSTR(vCPF, 5, 1), UNSIGNED) * 06) +
								(CONVERT(SUBSTR(vCPF, 6, 1), UNSIGNED) * 05) +
								(CONVERT(SUBSTR(vCPF, 7, 1), UNSIGNED) * 04) +
								(CONVERT(SUBSTR(vCPF, 8, 1), UNSIGNED) * 03) +
								(CONVERT(SUBSTR(vCPF, 9, 1), UNSIGNED) * 02) ;
								
		SET vCALCULO_DIGITO = 11 - (vCALCULO_DIGITO%11);
		IF (vCALCULO_DIGITO >= 10) THEN
			SET vDIGITO1 = '0';
		ELSE
			SET vDIGITO1 = CAST(vCALCULO_DIGITO AS CHAR);
		END IF;
		
		-- CALCULANDO SEGUNDO DIGITO
		SET vCPF = CONCAT(vCPF, vDIGITO1);
		SET vCALCULO_DIGITO = 	(CONVERT(SUBSTR(vCPF, 01, 1), UNSIGNED) * 11) +
								(CONVERT(SUBSTR(vCPF, 02, 1), UNSIGNED) * 10) +
								(CONVERT(SUBSTR(vCPF, 03, 1), UNSIGNED) * 09) +
								(CONVERT(SUBSTR(vCPF, 04, 1), UNSIGNED) * 08) +
								(CONVERT(SUBSTR(vCPF, 05, 1), UNSIGNED) * 07) +
								(CONVERT(SUBSTR(vCPF, 06, 1), UNSIGNED) * 06) +
								(CONVERT(SUBSTR(vCPF, 07, 1), UNSIGNED) * 05) +
								(CONVERT(SUBSTR(vCPF, 08, 1), UNSIGNED) * 04) +
								(CONVERT(SUBSTR(vCPF, 09, 1), UNSIGNED) * 03) +
								(CONVERT(SUBSTR(vCPF, 10, 1), UNSIGNED) * 02) ;
								
		SET vCALCULO_DIGITO = 11 - (vCALCULO_DIGITO%11);
		IF (vCALCULO_DIGITO >= 10) THEN
			SET vDIGITO2 = '0';
		ELSE
			SET vDIGITO2 = CAST(vCALCULO_DIGITO AS CHAR);
		END IF;
		
		SET vCPF = CONCAT(vCPF, vDIGITO2);

		IF vCPF = pCPF AND pCPF NOT IN ('00000000000','11111111111','22222222222','33333333333','44444444444','55555555555','66666666666','77777777777','88888888888','99999999999') THEN
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	ELSE
		RETURN 0;
	END IF;

END $$



CREATE TRIGGER tr_cliente_bi BEFORE INSERT ON cliente FOR EACH ROW
BEGIN
		DECLARE vcpf VARCHAR(11);
        
		SELECT cpf
		INTO vcpf
		FROM cliente
		WHERE idcliente = NEW.idcliente;
        
        
        
         IF(LENGTH(NEW.cpf) < 11) OR (LENGTH(NEW.cpf) > 11) THEN
            SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'CPF inválido!';
        
		END IF;
END $$

CREATE TRIGGER tr_cliente_bu BEFORE UPDATE ON cliente FOR EACH ROW
BEGIN
		DECLARE vcpf VARCHAR(11);
        
		SELECT cpf
		INTO vcpf
		FROM cliente
		WHERE idcliente = NEW.idcliente;
        
         IF(LENGTH(NEW.cpf) < 11) OR (LENGTH(NEW.cpf) > 11) THEN
            SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'CPF inválido!';
        
		END IF;
END $$

-- VALIDAR CARTAO DE CREDITO!!!
CREATE TRIGGER tr_cartao_bi BEFORE INSERT ON cartao FOR EACH ROW
BEGIN

	DECLARE vcpf VARCHAR(11);
    DECLARE cartao_validado CHAR(17);
	DECLARE vNUMERO CHAR(17);

    SELECT CONCAT(cliente.cpf, LPAD(COUNT(cartao.idcartao) + 1, 6, '0'))
    INTO vNUMERO
    FROM
		cliente
        LEFT JOIN CARTAO ON
        cartao.idcliente = cliente.idcliente
	WHERE	
		cliente.idcliente = NEW.idcliente;
    
    SET NEW.numero = vNUMERO;

END $$

CREATE TRIGGER tr_cartao_bu BEFORE UPDATE ON cartao FOR EACH ROW
BEGIN

	DECLARE vcpf VARCHAR(11);
    DECLARE cartao_validado CHAR(17);
	DECLARE vNUMERO CHAR(17);

    SELECT CONCAT(cliente.cpf, LPAD(COUNT(cartao.idcartao) + 1, 6, '0'))
    INTO vNUMERO
    FROM
		cliente
        LEFT JOIN CARTAO ON
        cartao.idcliente = cliente.idcliente
	WHERE	
		cliente.idcliente = NEW.idcliente;
    
    SET NEW.numero = vNUMERO;

END $$


CREATE PROCEDURE validar_debito (pIDDEBITO INT(11) , pIDCARTAO INT(11), pDESCRICAO VARCHAR(255), pPARCELA NUMERIC(8,2), pVALOR DECIMAL (8, 2), pDT_DEBITO DATETIME)
BEGIN
	DECLARE valor_total_compra DECIMAL (8, 2);
    DECLARE saldo_total2 DECIMAL (8, 2);
    DECLARE valor_parcela DECIMAL (8, 2);
    DECLARE descricao_legal VARCHAR(255);
    DECLARE vPARCELA INT;
    
	SET vPARCELA = pPARCELA;
	SET valor_total_compra = pVALOR;

    
    SELECT descricao
    INTO descricao_legal
    FROM debito
    WHERE iddebito = pIDDEBITO;
       
      
    SELECT SALDO_TOTAL
    INTO saldo_total2
    FROM vw_saldo
    WHERE idcartao = pIDCARTAO;
    
    IF(valor_total_compra > saldo_total2) THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Saldo insuficiente!';
        ELSEIF(pPARCELA < 1) THEN
		SET valor_parcela = valor_total_compra / pPARCELA;
	END IF;
    
    IF(pPARCELA > 1) THEN
		SET valor_parcela = valor_total_compra / vPARCELA;
        SET descricao_legal = CONCAT('à prazo ' , vPARCELA, '/12');
        INSERT INTO debito VALUES (pIDDEBITO, pIDCARTAO, descricao_legal , valor_parcela, pVALOR,pDT_DEBITO);

	ELSE 
		SET descricao_legal = CONCAT('à vista ' , vPARCELA, '/12');
		SET valor_parcela = valor_total_compra / vPARCELA;
		INSERT INTO debito VALUES (pIDDEBITO, pIDCARTAO, descricao_legal, valor_parcela, pVALOR, pDT_DEBITO);
	END IF;
END $$


CREATE PROCEDURE gerar_boleto (pIDBOLETO INT(11), pIDCARTAO INT(11), pDT_GERACAO DATE, 
pDT_VENCIMENTO DATE, pVALOR_TOTAL DECIMAL(8, 2), pDT_PAGAMENTO DATE, pVALOR_PAGO DECIMAL(8, 2))
BEGIN
DECLARE multa NUMERIC(8, 2);
DECLARE multaDia NUMERIC(8, 2);
DECLARE diferencaDias DATE;
DECLARE multaValorPago NUMERIC(8, 2);





-- PAGAMENTO ATRASADO
IF (pDT_PAGAMENTO > pDT_VENCIMENTO) THEN
	SET multa = (pVALOR_TOTAL * 0.2);
    -- INSERT INTO boleto (VALOR_TOTAL)VALUES(pVALOR_TOTAL + multa);
    
END IF;

-- PAGAMENTO ATRASADO POR DIA
IF (pDT_PAGAMENTO > pDT_VENCIMENTO) THEN
	SET diferencaDias = pDT_PAGAMENTO - pDT_VENCIMENTO;
	SET multaDia = (diferencaDias * (pVALOR_TOTAL * 0.02));
	-- INSERT INTO boleto (VALOR_TOTAL)VALUES(pVALOR_TOTAL + multaDia);
    
END IF;

-- PAGAMENTO MENOR QUE O VALOR TOTAL
IF(pVALOR_PAGO < pVALOR_TOTAL) THEN
	SET multaValorPago = (pVALOR_TOTAL * 0.15);
    -- INSERT INTO boleto (VALOR_TOTAL)VALUES(pVALOR_TOTAL + multaValorPago);
END IF;

 INSERT INTO boleto VALUES(pIDBOLETO, pIDCARTAO, pDT_GERACAO, NOW() + INTERVAL 1 MONTH, pVALOR_TOTAL , pDT_PAGAMENTO, pVALOR_PAGO);

END $$

DELIMITER ;






-- inserindo dados cliente
INSERT INTO cliente VALUES (1, 'Marcus', '12943896969', 7777118, 'Casa', '98', 'José Mendes','Florianópolis' ,'SC', 'Hostel 98', '2001-12-23', '3225-8155','3225-8155', '48-984243714');
INSERT INTO cliente VALUES (2, 'Milena', '07528187917', 120522343, 'Kitnet', '364', 'Abraão','Florianópolis' ,'SC', 'Apt', '1999-01-30', '3222-2235','3222-2235', '47-993454321');
INSERT INTO cliente VALUES (3, 'Joni', '60910585920', 7755118, 'Casa', '98', 'José Mendes','Florianópolis' ,'SC', 'Hostel 98', '2001-12-23', '3225-8155','3225-8155', '48-984243714');


-- inserindo dados cartao
INSERT INTO cartao VALUES(1, 1, 12943896969, 25, 5000);
INSERT INTO cartao VALUES(2, 2, 07528187917, 25, 2000);
INSERT INTO cartao VALUES(4, 2, 07528187917, 25, 2000);
INSERT INTO cartao VALUES(3, 3, 60910585920, 25, 7500);


-- procedure validar débito
-- inserindo dados debito (compras)
CALL validar_debito(1 , 1, 'Café melita', 1, 20.9, '2021-11-01 19:10:01');
CALL validar_debito(2 , 1, 'Notbook', 3, 500, '2021-11-06 23:19:21');
CALL validar_debito(3 , 2, 'Empanado', 1, 7.5, '2021-11-01 19:10:01');
CALL validar_debito(4 , 2, 'Remédio', 2, 53.99, '2021-11-08 05:32:54');
CALL validar_debito(5 , 3, 'Água mineral', 1, 2, '2021-11-09 08:20:04');
CALL validar_debito(6 , 3, 'Mercado Bistek', 2, 598.21, '2021-11-10 21:42:44');


-- procedure gerar boleto
-- inserindo dados boleto
CALL gerar_boleto(1, 1, '2022-02-15', '2022-11-30', 2000, '2022-11-26', 1500);
CALL gerar_boleto(2, 2, '2022-02-11', '2022-11-10', 1000, '2022-11-01', 100);
CALL gerar_boleto(3, 3, '2022-02-12', '2022-11-12', 1200, '2022-11-03', 500);


-- inserindo dados item_boleto
INSERT INTO item_boleto (iditem_boleto, idboleto, iddebito) VALUES(1, 1, 1);
INSERT INTO item_boleto (iditem_boleto, idboleto, iddebito) VALUES(2, 1, 2);
INSERT INTO item_boleto (iditem_boleto, idboleto, iddebito) VALUES(3, 2, 3);
INSERT INTO item_boleto (iditem_boleto, idboleto, iddebito) VALUES(4, 2, 4);
INSERT INTO item_boleto (iditem_boleto, idboleto, iddebito) VALUES(5, 3, 5);
INSERT INTO item_boleto (iditem_boleto, idboleto, iddebito) VALUES(6, 3, 6);


-- chamando as views
select * from vw_boleto;
select * from vw_extrato;
select * from vw_saldo;
select * from vw_boleto_detalhado;

-- chamando as tabelas
/*
select * from cliente;
select * from cartao;
select * from debito;
select * from boleto;
select * from item_boleto;

*/

 


