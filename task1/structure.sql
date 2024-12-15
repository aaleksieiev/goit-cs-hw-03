DROP TABLE IF EXISTS tasks CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS status CASCADE;

CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    fullname VARCHAR (100) UNIQUE NOT NULL,
    email VARCHAR (100) UNIQUE NOT NULL
);

CREATE TABLE status(
    id SERIAL PRIMARY KEY,
    name VARCHAR (50) UNIQUE NOT NULL
);

CREATE TABLE tasks(
    id SERIAL PRIMARY KEY,
    title VARCHAR (100) NOT NULL,
    description TEXT,         
    status_id INT,
    user_id INT,   
    FOREIGN KEY (status_id) REFERENCES status (id) 
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);