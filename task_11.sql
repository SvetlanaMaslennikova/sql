/* Практическое задание по теме “Оптимизация запросов”
 * 1. Создайте таблицу logs типа Archive.
 *  Пусть при каждом создании записи в таблицах users, catalogs и products
 *  в таблицу logs помещается время и дата создания записи, название таблицы,
 *  идентификатор первичного ключа и содержимое поля name.
 */

DROP TABLE IF EXISTS logs;

CREATE TABLE logs (
	created_at DATETIME NOT NULL,
	table_name VARCHAR(45) NOT NULL,
	str_id BIGINT(20) NOT NULL,
	name_value VARCHAR(45) NOT NULL
) ENGINE = ARCHIVE;

-- триггер для таблицы users
DROP TRIGGER IF EXISTS watchlog_users;

DELIMITER //

CREATE TRIGGER watchlog_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'users', NEW.id, NEW.name);
END //

DELIMITER ;

-- триггер для таблицы catalogs  
DROP TRIGGER IF EXISTS watchlog_catalogs;

DELIMITER //

CREATE TRIGGER watchlog_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END //

DELIMITER ;

-- триггер для таблицы products  
DROP TRIGGER IF EXISTS watchlog_products;

DELIMITER //

CREATE TRIGGER watchlog_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END //

DELIMITER ;

/* 2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей. */

DROP PROCEDURE IF EXISTS insert_into_users;

DELIMITER //

CREATE PROCEDURE insert_into_users ()
BEGIN
	DECLARE i INT DEFAULT 1000000;
	DECLARE j INT DEFAULT 0;
	WHILE i > 0 DO
		INSERT INTO users(name, birthday_at) VALUES (CONCAT('user_', j), NOW());
		SET j = j + 1;
		SET i = i - 1;
	END WHILE;
END //

DELIMITER ;

/* Практическое задание по теме “NoSQL”
 * 1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
 */

> sadd ip '1' '2' '3'
(integer) 3
> sadd ip '1'
(integer) 0
> scard ip
3

/* 2. При помощи базы данных Redis решите задачу поиска имени пользователя
 * по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени. 
 */

hset user_email name email
hset email_user email name

hget user_email "name" 
hget email_user "email" 

/* 3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB. */

shop.products.insert({
    name: "Intel Core i3-8100",
    description: "Процессор для настольных персональных компьютеров, основанных на платформе Intel.",
    price: 7890.00,
    catalog: "Процессоры"
})
