-- I. Заполнить все таблицы БД vk данными (не больше 10-20 записей в каждой таблице)

-- Добавляем пользователя
INSERT users (id, firstname, lastname, email, phone, password_hash, create_at)
VALUES (DEFAULT, 'Alex', 'Stepanenko', 'alex_s@mail.com', '89213546567', NULL, DEFAULT);

-- Не указываем default значения
INSERT INTO users (firstname, lastname, phone, email)
VALUES ('Lena', 'Stepanenko', '89213546569', 'lena_s@mail.com');

-- Явно задаем id
INSERT INTO users (id, firstname, lastname, email, phone)
VALUES (45, 'Jane', 'Ivanov', 'jane_i@mail.com', '89293546561');

-- Не указываем названия колонок
INSERT INTO users 
VALUES (5, 'Jane', 'Knight', 'jane_k@mai.com', '89293946561', NULL, DEFAULT);

-- Добавляем несколько пользователей
INSERT INTO users (firstname, lastname, email, phone)
VALUES ('Igor', 'Ivanov', 'igor_i@mail.com', '89213549561'),
('Oksana', 'Perova', 'oksana_p@mail.com', '89213549569'),
('Ivan', 'Ivanov', 'ivan_i@mail.com', '89123456789'),
('Sergey', 'Sidorov', 'sergey_s@mail.com', '89987654321'),
('Vlad', 'Ivanov', 'vlad_i@mail.com', '89112344567'),
('Maria', 'Petrova', 'maria_p@mail.com', '89112345678');

-- Добавляем записи в таблицу communities
INSERT INTO communities (name, description, admin_id)
VALUES ('Number3', 'I am number three', 45),
('Number4', 'I am number four', 44),
('Number5', 'I am number five', 55),
('Number6', 'I am number six', 2),
('Number7', 'I am number seven', 6),
('Number8', 'I am number eight', 67),
('Number9', 'I am number nine', 82),
('Number10', 'I am number ten', 119),
('Number11', 'I am number eleven', 142),
('Number12', 'I am number twelve', 276);

-- Добавляем записи в таблицу communities_users
INSERT INTO communities_users (community_id, user_id)
VALUES (2, 276),
(44, 142),
(5, 119),
(6, 82),
(74, 67),
(85, 6),
(93, 2),
(107, 55),
(118, 44),
(129, 45);

-- Добавляем записи в таблицу friend_requests
INSERT INTO friend_requests (from_user_id, to_user_id)
VALUES (3, 276),
(4, 142),
(5, 119),
(6, 82),
(7, 67),
(8, 6),
(9, 2),
(10, 55),
(11, 44),
(12, 45);

-- Добавляем записи в таблицу media_types
INSERT INTO media_types  (name)
VALUES ('видео');

-- Добавляем записи в таблицу media
INSERT INTO media (user_id, media_types_id, file_name, file_size)
VALUES (44, 1, 'jpg1.jpg', 130),
(45, 2, 'mp1.mp3', 142),
(55, 3, 'doc1.doc', 119),
(60, 4, 'vid1.mp4', 82),
(72, 1, 'jpg2.jpg', 67),
(85, 3, 'doc2.doc',6),
(93, 2, 'mp2.mp3', 150),
(105, 4, 'vid2.mp4', 255),
(116, 1, 'jpg3.jpg', 44),
(127, 2, 'mp3.mp3', 145);

-- Добавляем записи в таблицу messages
INSERT INTO messages (from_user_id, to_user_id, txt)
VALUES (1, 2, 'hi'),
(6, 5, 'hello'),
(44, 45, 'ok'),
(56, 55, 'hi'),
(57, 58, 'hi'),
(105, 107, 'ok'),
(129, 136, 'no'),
(148, 153, 'yes'),
(195, 206, 'hi'),
(321, 272, 'hi');

-- Добавляем записи в таблицу profiles
INSERT INTO profiles (user_id, gender, birthday, photo_id, city, country)
VALUES (321, 'f', '2012-10-25', NULL, 'Moscow', 'Russia'),
(263, 'f', '1985-11-05', NULL, 'St. Peterburg', 'Russia'),
(215, 'm', '2002-05-15', NULL, 'Omsk', 'Russia'),
(167, 'm', '2015-09-21', NULL, 'Nakhodka', 'Russia'),
(146, 'f', '2004-07-30', NULL, 'Penza', 'Russia'),
(122, 'f', '1957-10-14', NULL, 'Podolsk', 'Russia'),
(98, 'm', '1958-01-01', NULL, 'Rostov-on-Don', 'Russia'),
(71, 'x', '1987-05-05', NULL, 'Yelets', 'Russia'),
(56, 'm', '1991-05-11', NULL, 'Krasnodar', 'Russia'),
(57, 'f', '1999-06-10', NULL, 'Kyzyl', 'Russia');


-- II. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке
SELECT DISTINCT firstname FROM users ORDER BY firstname ASC;


-- III. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false).
-- Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)

-- Добавляем поле в таблицу profiles со значением по умолчанию = true (или 1)
ALTER TABLE profiles ADD COLUMN is_active BIT DEFAULT TRUE;

UPDATE profiles 
SET is_active = 0
WHERE (YEAR(CURRENT_DATE) - YEAR(birthday)) < 18;


-- IV. Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней)

DELETE FROM messages WHERE created_at > NOW();
