-- Crear tabla de usuarios: Representa a cada usuario individual del sistema de monedero virtual.
CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	email VARCHAR(50) UNIQUE NOT NULL,
	password VARCHAR(50) NOT NULL,
	balance NUMERIC(10, 2) DEFAULT 0
);

-- Crear tabla de transacciones: Representa cada transacción financiera realizada por los usuarios.
CREATE TABLE transactions (
	transaction_id SERIAL PRIMARY KEY,
	sender_user_id INTEGER NOT NULL,
	receiver_user_id INTEGER NOT NULL,
	amount NUMERIC(10, 2) NOT NULL,
	transaction_date DATE NOT NULL,
	FOREIGN KEY (sender_user_id) REFERENCES users(user_id),
	FOREIGN KEY (receiver_user_id) REFERENCES users(user_id)
);

-- Crear tabla de moneda: Representa las diferentes monedas que se pueden utilizar en el monedero virtual.
CREATE TABLE money (
	currency_id SERIAL PRIMARY KEY,
	currency_name VARCHAR(50) NOT NULL,
	currency_symbol VARCHAR(5) NOT NULL
);

-- Se solicitan las siguientes consultas SQL:
-- 1. Consulta para obtener el nombre de la moneda elegida por un usuario específico.
-- 2. Consulta para obtener todas las transacciones registradas.
-- 3. Consulta para obtener todas las transacciones realizadas por un usuario específico.
-- 4. Sentencia DML para modificar el campo correo electrónico de un usuario específico.
-- 5. Sentencia para eliminar los datos de una transacción (eliminado de la fila completa).

-- Para la primera consulta es necesario crear la relación de las tablas users y money.
-- Primero se agrega la columna para el id de la moneda.
ALTER TABLE users
ADD COLUMN currency_id INTEGER;

-- Luego se crea la relación entre las tablas con la clave foránea.
ALTER TABLE users
ADD FOREIGN KEY (currency_id) REFERENCES money(currency_id);

-- Se llenan las tablas, primero insertar usuarios.
INSERT INTO users (name, email, password, balance, currency_id) VALUES
('Frodo', 'frodo_bolson@email.com', 'TybFKoFgMR', 10000, 1),
('Bilbo', 'bilbo_bolson@email.com', 'xxJSQpivbU', 2000, 1),
('Sam', 'samsagaz_gamyi@email.com', 'gXA9FqglGn', 8000, 1),
('Pippin', 'peregrin_tuk@email.com', 'ID1Fqahk3a', 5000, 1),
('Merry', 'meriadoc_brandigamo@email.com', '9J1TU2NwAl', 5000, 1),
('Legolas', 'legolas@email.com', 'tBPLoe6pQt', 15000, 2),
('Gimli', 'gimli@email.com', '5JRFgwj7Fz', 14500, 2),
('Boromir', 'boromir@email.com', 'DWDShHWcSb', 10000, 3),
('Aragorn', 'aragorn@email.com', 'lH8wxHiV0s', 11000, 3),
('Gandalf', 'gandalf@email.com', 'fLu2lI3zht', 20000, 3);

-- Insertar transacciones.
INSERT INTO transactions (sender_user_id, receiver_user_id, amount, transaction_date) VALUES
(1, 2, 1000, '2025-01-12'),
(1, 3, 500, '2025-02-15'),
(1, 10, 1500, '2025-03-16'),
(2, 10, 700, '2025-01-05'),
(3, 1, 5000, '2025-01-20'),
(3, 9, 200, '2025-02-02'),
(4, 5, 100, '2025-02-21'),
(4, 6, 200, '2025-03-04'),
(5, 4, 200, '2025-02-11'),
(5, 8, 400, '2025-05-15'),
(6, 7, 1500, '2025-03-11'),
(6, 8, 1200, '2025-03-15'),
(6, 10, 3000, '2025-04-22'),
(7, 1, 500, '2025-05-26'),
(8, 2, 900, '2025-02-24'),
(8, 4, 200, '2025-03-16'),
(9, 1, 1000, '2025-01-10'),
(9, 3, 800, '2025-02-10'),
(9, 5, 600, '2025-03-10'),
(10, 2, 2000, '2025-10-23');

-- Insertar monedas.
INSERT INTO money (currency_name, currency_symbol) VALUES
('dolar', '$'),
('euro', '€'),
('pound', '£');

-- 1. Obtener el nombre de la moneda de un usuario específico (Bilbo)
SELECT m.currency_name
FROM users u
JOIN money m ON u.currency_id = m.currency_id
WHERE u.user_id = 2;

-- 1. Obtener el nombre de la moneda de un usuario específico (Legolas)
SELECT m.currency_name
FROM users u
JOIN money m ON u.currency_id = m.currency_id
WHERE u.user_id = 6;

-- 1. Obtener el nombre de la moneda de un usuario específico (Gandalf)
SELECT m.currency_name
FROM users u
JOIN money m ON u.currency_id = m.currency_id
WHERE u.user_id = 10;

-- 2. Obtener todas las transacciones registradas
SELECT * FROM transactions;

-- 3. Obtener todas las transacciones realizadas por un usuario específico (Merry)
SELECT * FROM transactions WHERE sender_user_id = 5;

-- 3. Obtener todas las transacciones realizadas por un usuario específico (Aragorn)
SELECT * FROM transactions WHERE sender_user_id = 9;

-- 4. Modificar el campo correo electrónico de un usuario específico (Pippin)
UPDATE users SET email = 'pippin@email.com' WHERE user_id = 4;

SELECT * FROM users WHERE user_id = 4;

-- 5. Eliminar los datos de una transacción
DELETE FROM transactions WHERE transaction_id = 18;

SELECT * FROM transactions;