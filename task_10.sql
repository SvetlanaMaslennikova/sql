/* 1. DDL-команды; */

DROP DATABASE IF EXISTS travel_agency;

CREATE DATABASE IF NOT EXISTS travel_agency;

USE travel_agency;

CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	firstname VARCHAR(150) NOT NULL,
	lastname VARCHAR(150) NOT NULL,
	email VARCHAR(150) NOT NULL UNIQUE,
	phone CHAR(11) NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Клиенты';

CREATE TABLE sales(
	id SERIAL PRIMARY KEY,
	user_id INT NOT NULL,
	creater_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	price FLOAT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(id)
) COMMENT = 'Продажи';

CREATE TABLE tours(
	id SERIAL PRIMARY KEY,
	tour_type_id INT NOT NULL, 
	date_begin DATE NOT NULL, 
	date_end DATE NOT NULL, 
	food_type_id INT NOT NULL,
	hotel_id INT NOT NULL,
	flight_id INT NOT NULL,
	FOREIGN KEY (tour_type_id) REFERENCES tour_type(id),
	FOREIGN KEY (food_type_id) REFERENCES food_type(id),
	FOREIGN KEY (hotel_id) REFERENCES hotels(id),
	FOREIGN KEY (flight_id) REFERENCES flights(id)
)  COMMENT = 'Туры';

CREATE TABLE hotels(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150) NOT NULL,
	stars INT NOT NULL,
	city_id INT NOT NULL, 
	type_of_allocation_id INT NOT NULL,
	FOREIGN KEY (city_id) REFERENCES cities(id),
	FOREIGN KEY (type_of_allocation_id) REFERENCES type_of_allocation(id)
)  COMMENT = 'Отели';

CREATE TABLE cities(
	id SERIAL PRIMARY KEY,
	name VARCHAR(250) NOT NULL,
	country_id int not NULL,
	FOREIGN KEY (country_id) REFERENCES countries(id)
)  COMMENT = 'Города';

CREATE TABLE countries(
	 id SERIAL PRIMARY KEY,
	 name VARCHAR(150) NOT NULL
)  COMMENT = 'Страны';

CREATE TABLE tour_type(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150) NOT NULL
)  COMMENT = 'Тип тура';

CREATE TABLE food_type(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150) NOT NULL
)  COMMENT = 'Тип питания';

CREATE TABLE type_of_allocation(
	 id SERIAL PRIMARY KEY,
	 name VARCHAR(150) 
)  COMMENT = 'Тип размещения';

CREATE TABLE flights(
	id SERIAL PRIMARY KEY, 
	departure_city VARCHAR(150) NOT NULL COMMENT 'Город вылета',
	departure_date DATE NOT NULL COMMENT 'Дата вылета', 
	departure_time INT NOT NULL COMMENT 'Время вылета', 
	arrival_city VARCHAR(150) NOT NULL COMMENT 'Город прилета', 
	arrival_date DATE NOT NULL COMMENT 'Дата прилета',
	arrival_time INT NOT NULL COMMENT 'Время прилета',
	FOREIGN KEY (departure_city) REFERENCES cities(id),
	FOREIGN KEY (arrival_city) REFERENCES cities(id)
) COMMENT = 'Авиарейсы';

/* 2. Дамп БД (наполнение таблиц данными), не больше 10 строк в каждой таблице. */

INSERT INTO users (firstname, lastname, email, phone)
VALUES ('Игорь', 'Петров', 'igor@mail.com', '89211234567'),
('Оксана', 'Петрова', 'oksana@mail.com', '89212345678'),
('Иван', 'Иванов', 'ivan@mail.com', '89213456789'),
('Сергей', 'Сидоров', 'sergey@mail.com', '89214567890'),
('Мария', 'Маркова', 'mariya@mail.com', '89215678901'),
('Елена', 'Ленина', 'elena@mail.com', '89216789012'),
('Армен', 'Хачатурян', 'armen@mail.com', '89217890123'),
('Борис', 'Борисов', 'boris@mail.com', '89218901234'),
('Виктория', 'Викторова', 'victor@mail.com', '89219012345'),
('Давид', 'Давыдов', 'david@mail.com', '89210123456');

INSERT INTO sales(user_id, price)
VALUES (1, 35000),
(2, 15000),
(3, 7500),
(4, 27800),
(5, 64654),
(6, 56476),
(7, 7654),
(8, 76537),
(9, 54347),
(10, 8493);

INSERT INTO countries(name) 
VALUES ('Россия'),
('Египет'),
('Турция'),
('Греция'),
('Армения'),
('Кипр'),
('Мексика'),
('ОАЭ'),
('Таиланд'),
('Узбекистан');

INSERT INTO cities(name, country_id)
VALUES ('Москва', 1),
('Каир', 2),
('Анкара', 3),
('Афины', 4),
('Ереван', 5),
('Никосия', 6),
('Мехико', 7),
('Абу-Даби', 8),
('Бангкок', 9),
('Ташкент', 10);

INSERT INTO tour_type(name)
VALUES ('Пакетный'),
('Индивидуальный'),
('Горящий'),
('Экскурсионный'),
('Спортивный'),
('Морской круиз'),
('Горнолыжный'),
('Детский отдых'),
('Свадебный'),
('Оздоровительный');

INSERT INTO food_type(name)
VALUES ('Без питания'),
('Завтраки'),
('Полупансион (завтрак + ужин)'),
('Полный пансион (завтрак, обед, ужин)'),
('Всё включенно (Полный пансион + напитки местного производства)'),
('Шведский стол'),
('Континентальный завтрак'),
('Расширенный полупансион (завтрак + ужин + напитки'),
('Расширенный полный пансион ( завтрак, обед, ужин + напитки'),
('Ультра всё включенно (всё включенно + напитки импортного производства');

INSERT INTO type_of_allocation(name)
VALUES ('Одноместное'),
('Двухместное'),
('Трехместное'),
('Четырехместный номер'),
('Дополнительная кровать'),
('Детская кровать'),
('Стандартная комната'),
('Номер повышенной комфортности'),
('Семейный номер'),
('Люкс');

INSERT INTO hotels(name, stars,	city_id, type_of_allocation_id)
VALUES ('Метрополь', '5', 1, 10),
('Ramses Hilton', '4', 2, 9),
('Hotel Evren', '3', 3, 8),
('Candia Hotel', '4', 4, 7),
('Республика Ереван', '4', 5, 6),
('Merit Hotel', '5', 6, 5),
('MX centro', '3', 7, 4),
('Emirates Palace', '5', 8, 3),
('Asia Hotel Bangkok', '3', 9, 2),
('Гостиница Узбекистан', '4', 10, 1);

INSERT INTO flights(departure_city, departure_date, departure_time, arrival_city, arrival_date, arrival_time)
VALUES (1, '2022-06-15', '08:15', 10, '22-06-16', '18:30'),
(2,'2022-06-22', '10:25', 9, '22-06-23', '11:30'),
(3,'2022-07-15', '09:15', 8, '22-07-15', '10:30'),
(4,'2022-08-13', '12:20', 7, '22-08-13', '18:20'),
(5,'2022-09-15', '16:15', 6, '22-09-16', '08:30'),
(6,'2022-10-15', '18:45', 5, '22-10-16', '02:17'),
(7,'2022-11-15', '14:17', 4, '22-11-15', '18:30'),
(8, '2022-07-26', '17:43', 3, '22-07-15', '18:30'),
(9, '2022-08-31', '18:33', 2, '22-09-01', '00:10'),
(10, '2022-07-16', '05:25', 1, '22-07-16', '08:30');

INSERT INTO tours(tour_type_id, date_begin, date_end, food_type_id, hotel_id, flight_id)
VALUES (1, '2022-06-15', '22-06-26', 2, 5),
(2,'2022-06-22', '22-07-23', 1, 1),
(3,'2022-07-15', '22-08-05', 3, 2),
(4,'2022-08-13', '22-08-30', 5, 6),
(5,'2022-09-15', '22-09-26', 4, 6),
(6,'2022-10-15', '22-10-29', 8, 2),
(7,'2022-11-15', '22-11-15', 7, 3),
(8, '2022-07-26', '22-07-26', 7, 8),
(9, '2022-08-31', '22-09-01', 2, 9),
(10, '2022-07-16', '22-07-16',  10, 6);
