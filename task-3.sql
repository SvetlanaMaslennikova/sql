USE vk;

CREATE TABLE posts(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	txt TEXT NOT NULL,
	media_id INT UNSIGNED NOT NULL
	FOREIGN KEY (user_id) REFERENCES users (id)
	FOREIGN KEY (media_id) REFERENCES media (id)
);

CREATE TABLE likes(
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	post_id INT UNSIGNED NOT NULL,
	create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (from_user_id) REFERENCES users (id),
	FOREIGN KEY (to_user_id) REFERENCES users (id),
	FOREIGN KEY (post_id) REFERENCES posts (id)
);

CREATE TABLE comments(
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	txt TEXT NOT NULL,
	post_id INT UNSIGNED NOT NULL,
	create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (from_user_id) REFERENCES users (id),
	FOREIGN KEY (to_user_id) REFERENCES users (id),
	FOREIGN KEY (post_id) REFERENCES posts (id)	
);