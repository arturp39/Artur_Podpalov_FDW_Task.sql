-- Create table
CREATE TABLE remote_table (
    id serial PRIMARY KEY,
    name VARCHAR(255),
    age INTEGER
);

-- Insert sample data
INSERT INTO remote_table (name, age) VALUES
    ('Artur Podpalov', 35),
    ('Gregory Smith', 28),
    ('Harry Potter', 42);
