/* 6. скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы); */

USE travel_agency;

-- Запрос на выборку городов России с использованием соединения:

SELECT c.name 
FROM cities c 
JOIN countries ct ON c.country_id = ct.id 
WHERE ct.name = 'Россия';


-- Cписок пользователей users, которые осуществили хотя бы один заказ sales:

SELECT u.id, u.firstname, u.lastname, s.creater_at 
FROM users u
JOIN sales s  ON u.id = s.user_id;

-- Cписок пользователей users c отображением выбранного отеля:

SELECT u.id, u.firstname, u.lastname, h.name 
FROM users u 
JOIN sales s  ON u.id = s.user_id
JOIN tours t  ON s.tour_id = t.id 
JOIN hotels h ON h.id = t.hotel_id;

-- Список отелей с группировкой по количеству звезд:
SELECT h.stars 
FROM hotels h 
GROUP BY h.stars;

 /* 7. представления (минимум 2); */

-- Создание представления, которое из таблицы tours извлекает только 'горящие' путевки
CREATE OR REPLACE VIEW hot_tour AS 
SELECT id, date_begin, date_end, food_type_id, hotel_id  
FROM tours t 
WHERE tour_type_id  = 3;

SELECT * FROM hot_tour;

/* Создание представления, которое выводит название name отеля из таблицы hotels
 * и соответствующее название города name из таблицы cities. */

CREATE VIEW items AS SELECT hotels.name, cities.name 
FROM hotels h, cities c
WHERE hotels.city_id  = cities.id;

SELECT * FROM items;

-- Создание обновляемого представления

CREATE VIEW p1 AS
SELECT * FROM sales s  WHERE price  < '20000'
WITH CHECK OPTION;

SELECT * FROM p1;

 /* 8. хранимые процедуры / триггеры */

-- Добавим нового пользователя через процедуру и транзакцию
DROP PROCEDURE IF EXISTS sp_add_user;

DELIMITER //

CREATE PROCEDURE sp_add_user(firstname VARCHAR(150), lastname VARCHAR(150), email VARCHAR(150), phone CHAR(11),
							OUT tran_result VARCHAR(200))
BEGIN 
	DECLARE tran_rollback BOOL DEFAULT 0;
	DECLARE code VARCHAR(100);
	DECLARE error_string VARCHAR(100);

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	-- Если пойман exception ставим флажок
	BEGIN
		SET tran_rollback = 1;
		
		GET STACKED DIAGNOSTICS CONDITION 1
			code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
		SET tran_result = CONCAT(code, ': ', error_string);
	END;
	
	START TRANSACTION;

	INSERT users (firstname, lastname, email, phone)
	VALUES (firstname, lastname, email, phone);

	IF tran_rollback 
	THEN 
		ROLLBACK;
	ELSE
		SET tran_result = 'ok';
		COMMIT;
	END IF;

END//

DELIMITER ;

-- Триггер для контроля даты тура.

DELIMITER //

CREATE TRIGGER check_date_begin_before_insert BEFORE INSERT ON tours
FOR EACH ROW 
BEGIN 
	IF NEW.date_begin <= CURRENT_DATE() THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert Canceled. Date begin must be in the future!';
	END IF;
END//

DELIMITER ;

