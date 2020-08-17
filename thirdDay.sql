SELECT f.title, f.description FROM film f JOIN language l ON f.language_id = l.language_id WHERE l.name = 'English';                                                                                        -- zad.1a
SELECT f.title, f.description FROM film f JOIN film_actor fa ON f.film_id = fa.film_id JOIN actor a ON fa.actor_id = a.actor_id WHERE a.first_name = 'UMA' AND a.last_name = 'WOOD';                        -- zad.1b  
SELECT DISTINCT f.title, a.first_name, a.last_name FROM film f JOIN film_actor fa ON f.film_id = fa.film_id JOIN actor a ON fa.actor_id = a.actor_id WHERE a.first_name LIKE 'A%' OR a.last_name LIKE 'A%'; -- wariacja nt. zad.1b
SELECT f.film_id, f.title FROM film f JOIN film_category fc ON f.film_id = fc.film_id JOIN category c ON fc.category_id = c.category_id WHERE c.name = 'Sci-Fi' ORDER BY f.film_id DESC LIMIT 1;            -- zad.1c
SELECT f.film_id, f.title FROM film f WHERE f.film_id = (
	SELECT MAX(f.film_id)FROM film f JOIN film_category fc ON f.film_id = fc.film_id JOIN category c ON c.category_id = fc.category_id WHERE c.name = 'Sci-Fi');                                            -- inne rozwiązanie zad.1c
    SELECT f.film_id, f.title, COUNT(*) AS rentals FROM film f JOIN inventory i ON f.film_id=i.film_id JOIN rental r ON i.inventory_id=r.inventory_id GROUP BY f.title ORDER BY rentals DESC LIMIT 1;       -- inne rozwiązanie zad.1c
SELECT COUNT(f.film_id) FROM film f JOIN language l ON f.language_id = l.language_id WHERE l.name = 'Italian';                                                                                              -- zad.1d
SELECT COUNT(f.film_id) FROM film AS f JOIN language AS l ON f.language_id = l.language_id WHERE l.name = 'English';                                                                                        -- inne rozwiązanie zad.1d
UPDATE film JOIN film_actor fa ON f.film_id = fa.film_id JOIN actor a ON a.actor_id = fa.actor_id SET f.language_id = (SELECT language_id FROM language WHERE name = 'Italian') WHERE a.first_name = 'UMA' AND a.last_name = 'WOOD';  -- zamieniamy we wszystkich filmach z Umą język na włoski
SELECT f.title, COUNT(i.film_id) AS rentals FROM film f JOIN inventory i ON f.film_id = i.film_id JOIN rental r ON i.inventory_id = r.inventory_id GROUP BY f.film_id ORDER BY rentals DESC LIMIT 1;        -- zad.1e
SET autocommit=0;                                                                                                                                                                                           -- wyłącza autocommitowanie, mogę wtedy testować, zrobić rollback itp.
SET autocommit=1;                                                                                                                                                                                           -- włącza autocommitowanie, ustawienie default'owe                                                                                                                                                                                       -- wyłącza autocommitowanie, mogę wtedy testować, zrobić rollback itp.
SELECT s.store_id, CONCAT(st.first_name, ' ', st.last_name) AS staff, GROUP_CONCAT(DISTINCT f.title SEPARATOR ', ') AS films FROM film f JOIN inventory i ON f.film_id = i.film_id JOIN store s ON s.store_id = i.store_id JOIN staff st ON st.store_id = s.store_id GROUP BY s.store_id;    -- zad.1f
CREATE VIEW film_language
AS
SELECT f.title FROM film f JOIN language l ON f.language_id = l.language_id;                                                                                                                                -- przykład widoku
CREATE VIEW stores_list
AS
SELECT s.store_id, a.address, c.city, co.country FROM store s JOIN address a ON s.address_id = a.address_id JOIN city c ON c.city_id = a.city_id JOIN country co ON co.country_id = c.country_id;           -- zad.2a
CREATE VIEW payment_by_days
AS
SELECT SUM(p.amount), s.store_id FROM payment p JOIN staff st ON p.staff_id = st.staff_id JOIN store s ON s.store_id = st.store_id GROUP BY s.store_id;                                                     -- zad.2b
SELECT * FROM payment_by_days;
SELECT SUM(payment.amount) FROM payment;
CREATE INDEX film_title_index ON film(title);                                                                                                                                                               -- tworzę indeksy na kolumnie tytuł w tabeli film
CREATE INDEX film_title_desc_index ON film(title, description(10));                                                                                                                                         -- tworzę indeksy na kolumnie tytuł i kolumnie opis ograniczony do 10 znaków w tabeli film
CREATE TABLE new_category (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL UNIQUE
);                                                                                                                                                                                                          -- zad.3a
DELIMITER ;;                                                                                                                                                                                                -- zmieniam znacznik końca zapytania
CREATE TRIGGER `ins_film` AFTER INSERT ON `film` FOR EACH ROW 
BEGIN
INSERT INTO film_text (film_id, title, description)
VALUES (new.film_id, new.title, new.description);
END;;                                                                                                                                                                                                       -- przykład tworzenia triggera
DELIMITER ;                                                                                                                                                                                                 -- wracam do default'owego znacznika końca zapytania

DELIMITER ;;
CREATE TRIGGER `ins_category` AFTER INSERT ON `category` FOR EACH ROW BEGIN
INSERT INTO new_category (name)
VALUES (new.name);
END;;                                                                                                                                                                                                        -- zad.3b
DELIMITER ; 

DELIMITER ;;
CREATE TRIGGER `update_category_name` AFTER UPDATE ON `category` FOR EACH ROW BEGIN
UPDATE new_category SET name = new.name WHERE name = old.name;
END;;                                                                                                                                                                                                       -- zad.3c
delimiter ;

INSERT INTO category (name) VALUES ('new_category');                                                                                                                                                        -- wrzucam nową kategorię do tabeli kategorii
SELECT * FROM new_category;                                                                                                                                                                                 -- sprawdzam czy trigger zadziałał

SELECT MAX(category_id) FROM category;                                                                                                                                                                      -- sprwdzam, jaki jest najwyższy id
UPDATE category SET name = 'new_ONE_category' WHERE category_id = 21;                                                                                                                                       -- zmieniam nazwę kategorii w id 21 w tabeli kategorii
SELECT * FROM new_category;                                                                                                                                                                                 -- sprawdzam czy trigger zadziałał

CREATE FUNCTION fn_dataa                                                                                                                                                                                    -- przykład deklaracji funkcji
(data varchar(30))                                                                                                                                                                                          -- argument funkcji
RETURNS CHAR(2) DETERMINISTIC                                                                                                                                                                               -- typ zwracany
RETURN SUBSTRING(data, 2, 4);                                                                                                                                                                               -- zwracana zmienna
SELECT fn_dataa('baa!!aa!!12aa');                                                                                                                                                                           -- wywolanie funkcji

CREATE PROCEDURE przecena                                                                                                                                                                                   -- przykład deklaracji procedury
(IN nazwa varchar (64))
UPDATE item
SET sell_price = sell_price*0.9
WHERE description = nazwa;
CALL przecena ('Fan Small');

SELECT * FROM film f LEFT JOIN film_actor fa ON fa.film_id = f.film_id LEFT JOIN actor a ON a.actor_id = fa.actor_id;                                                                                       -- wyszukuję wszystkie filmy z aktorami
SELECT * FROM film f LEFT JOIN film_actor fa ON fa.film_id = f.film_id LEFT JOIN actor a ON a.actor_id = fa.actor_id WHERE fa.actor_id IS NULL;                                                             -- wyszukuję wszystkie filmy bez aktorów
SELECT * FROM film f RIGHT JOIN film_actor fa ON fa.film_id = f.film_id RIGHT JOIN actor a ON a.actor_id = fa.actor_id;                                                                                     -- wyszukuję wszystkich aktorów z filmami
SELECT * FROM film f RIGHT JOIN film_actor fa ON fa.film_id = f.film_id RIGHT JOIN actor a ON a.actor_id = fa.actor_id WHERE fa.film_id IS NULL;                                                           -- wyszukuję wszystkich aktorów bez filmu 
