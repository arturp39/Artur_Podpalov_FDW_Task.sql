-- Install the postgres_fdw extension
CREATE EXTENSION postgres_fdw;

-- Create a foreign server to connect to 'db_two'
CREATE SERVER same_server_postgres
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (dbname 'db_two');

-- Create a user mapping for the current user
CREATE USER MAPPING FOR CURRENT_USER
    SERVER same_server_postgres
    OPTIONS (user 'postgres', password '1234');

-- Define a foreign table to access 'remote_table' in 'db_two'
CREATE FOREIGN TABLE local_remote_table (
   id INTEGER,
   name VARCHAR(255),
   age INTEGER
)
SERVER same_server_postgres
OPTIONS (schema_name 'public', table_name 'remote_table');

-- Select all records from the foreign table
SELECT * FROM local_remote_table;

-- Insert a new record into the foreign table
INSERT INTO local_remote_table (id, name, age) VALUES (4, 'Sam Black', 30);

-- Update a record in the foreign table
UPDATE local_remote_table SET age = 40 WHERE name = 'Artur Podpalov';

-- Delete a record from the foreign table
DELETE FROM local_remote_table WHERE name = 'Gregory Smith';

-- Create a local table in 'db_one'
CREATE TABLE local_table (
    id serial PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE NOT NULL
);

-- Insert data into the local table
INSERT INTO local_table (name, email) VALUES
    ('Artur Podpalov', 'arturpodpalov@gmail.com'),
    ('Gregory Smith', 'gregorysmith@gmail.com'),
    ('Harry Potter', 'harrypotter@gmail.com');

-- Select data from the foreign table and join with the local table
SELECT r.*, l.email
FROM local_remote_table AS r 
LEFT JOIN local_table AS l ON (r.name = l.name);