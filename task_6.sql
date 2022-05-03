/* 1.Пусть задан некоторый пользователь. 
 * Из всех пользователей соц. сети найдите человека, 
 * который больше всех общался с выбранным пользователем (написал ему сообщений). */

SELECT 
	firstname,
	lastname 
FROM users
JOIN
messages 
WHERE from_user_id = users.id AND to_user_id = 1 
GROUP BY firstname, lastname
ORDER BY COUNT(from_user_id) DESC
LIMIT 1;

-- 2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

SELECT COUNT(*) 'likes count'
FROM posts_likes 
JOIN
profiles
WHERE profiles.user_id = posts_likes.user_id AND TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10;

-- 3. Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT CASE (gender)
        WHEN 'm' THEN 'male'
        WHEN 'f' THEN 'female'
    	END AS 'gender', COUNT(*) as 'likes'
FROM profiles 
JOIN
posts_likes  
WHERE posts_likes.user_id = profiles.user_id
GROUP BY gender 
LIMIT 1;