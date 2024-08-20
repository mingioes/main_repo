-- CREATE DATABASE mycloset;

USE mycloset;


CREATE TABLE users (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_email VARCHAR(200) NOT NULL UNIQUE,
    password VARCHAR(200),
    nick_name VARCHAR(200) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    personal_color VARCHAR(200),
    PRIMARY KEY (id)
);

CREATE TABLE boards (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    text VARCHAR(500) NOT NULL,
    like_count BIGINT UNSIGNED DEFAULT 0,
    unlike_count BIGINT UNSIGNED DEFAULT 0,
    user_id BIGINT UNSIGNED NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE images (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    path VARCHAR(500) NOT NULL,
    url VARCHAR(500) NOT NULL,
    board_id BIGINT UNSIGNED NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (board_id) REFERENCES boards(id) ON DELETE CASCADE
);

create table likes(
	id BIGINT unsigned not null auto_increment,
    user_id BIGINT unsigned not null,
    board_id BIGINT unsigned not null,
    liked boolean not null,
    primary key (id),
    foreign key (board_id) references boards(id) on delete cascade,
    foreign key (user_id) references users(id) on delete cascade
);
