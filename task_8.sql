/* 1. Пусть задан некоторый пользователь.
 * Из всех пользователей соц. сети найдите человека,
 *  который больше всех общался с выбранным пользователем (написал ему сообщений).
 */

SELECT 
	u.firstname,
	u.lastname 
FROM users u
JOIN
messages m
WHERE m.from_user_id = u.id AND m.to_user_id = 1 
GROUP BY u.firstname, u.lastname
ORDER BY COUNT(m.from_user_id) DESC
LIMIT 1;

/* 2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.. */

SELECT COUNT(*) 'likes count'
FROM posts_likes pl
JOIN
profiles p
WHERE p.user_id = pl.user_id AND TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10;

/* 3. Определить кто больше поставил лайков (всего): мужчины или женщины. */

SELECT CASE (p.gender)
        WHEN 'm' THEN 'male'
        WHEN 'f' THEN 'female'
    	END AS 'gender', COUNT(*) as 'likes'
FROM profiles p
JOIN
posts_likes pl
WHERE pl.user_id = p.user_id
GROUP BY p.gender 
LIMIT 1;
