-- Creates a table with unique users.
CREATE TABLE IF NOT EXIST users(
id INT NOT NULL PRIMARY KEY,
email VARCHAR(255) NOT NULL UNIQUE,
name VARCHAR(255)
);
