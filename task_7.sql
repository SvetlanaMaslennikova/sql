/* 1. Составьте список пользователей users, 
 * которые осуществили хотя бы один заказ orders в интернет магазине. 
 */

SELECT users.id, users.name, users.birthday_at, orders.created_at 
FROM users
JOIN orders ON users.id = orders.user_id;

/* 2. Выведите список товаров products и разделов catalogs,
 * который соответствует товару.
 */

SELECT
	catalogs.name AS catalog_name,
	products.name AS product_name,
	products.price,
	products.description AS product_description
FROM products
LEFT JOIN catalogs ON catalogs.id = products.catalog_id;

/* 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to)
 *  и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, 
 * поле name — русское. Выведите список рейсов flights с русскими названиями городов.
*/

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
	id SERIAL PRIMARY KEY, 
    `from` VARCHAR(50),
    `to` VARCHAR(50)
);

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
	id SERIAL PRIMARY KEY, 
    label VARCHAR(50),
    name VARCHAR(50)
);

INSERT INTO flights (`from`, `to`) VALUES
			('moscow', 'omsk'),
			('novgorod', 'kazan'),
			('irkutsk', 'moscow'),
			('omsk', 'irkutsk'),
			('moscow', 'kazan');
			
INSERT INTO cities (label, name) VALUES
			('moscow', 'Москва'),
			('irkutsk', 'Иркутск'),
			('novgorod', 'Новгород'),
			('kazan', 'Казань'),
			('omsk', 'Омск');
			
SELECT flights.id, `from`.name AS `from`, `to`.name AS `to`
FROM flights
JOIN cities AS `from` ON flights.`from` = `from`.label
JOIN cities AS `to` ON flights.`to` = `to`.label
ORDER BY id;
