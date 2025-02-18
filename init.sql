CREATE DATABASE IF NOT EXISTS bot_app;
USE bot_app;

CREATE USER IF NOT EXISTS 'chat_user'@'%' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON bot_app.* TO 'chat_user'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE chats (
    chat_id INT AUTO_INCREMENT PRIMARY KEY,
    creator_id INT NOT NULL,
    chat_title VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (creator_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE messages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT NOT NULL,
    message_text TEXT NOT NULL,
    bot_response TEXT NOT NULL,
    chat_id INT NOT NULL,
    FOREIGN KEY (chat_id) REFERENCES chats(chat_id) ON DELETE CASCADE,
    FOREIGN KEY (sender_id) REFERENCES users(user_id) ON DELETE CASCADE
);