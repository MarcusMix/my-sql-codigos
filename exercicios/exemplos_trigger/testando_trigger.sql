SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS dbTestandoTrigger;
CREATE DATABASE dbTestandoTrigger;
USE dbTestandoTrigger;


CREATE TABLE estudantes (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    idade INT
);

/*
INSERT INTO estudantes (id, nome, idade) VALUES (1, 'Milena', 23);
INSERT INTO estudantes (id, nome, idade) VALUES (2, 'Marcus', 20);
INSERT INTO estudantes (id, nome, idade) VALUES (3, 'Ana', 17);
*/


DELIMITER $$
CREATE TRIGGER tg_estudantes_bu BEFORE UPDATE ON estudantes FOR EACH ROW
BEGIN

	SET NEW.nome = UPPER(NEW.nome);

END $$


CREATE TRIGGER tg_estudantes_bi BEFORE INSERT ON estudantes FOR EACH ROW
BEGIN

	SET NEW.nome = UPPER(NEW.nome);

END $$

DELIMITER ;

INSERT INTO estudantes (id, nome, idade) VALUES (5, 'João', 20);

SELECT * FROM estudantes;

