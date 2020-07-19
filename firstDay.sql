SELECT * FROM sakila.actor;
SELECT 1; -- zawsze zwraca 1
INSERT INTO actor (first_name, last_name) VALUES ('ZDZISLAW', 'PAZURA');    -- wstawianie nowego rekordu
SELECT * FROM actor WHERE last_name = 'PAZURA';						        -- wypisanie danych dla rekordu gdzie last_name = 'PAZURA'
UPDATE actor SET first_name ='CEZARY' WHERE last_name ='PAZURA';		    -- update first_name dla rekordu gdzie last_name = 'PAZURA'
SELECT * FROM actor WHERE last_name = 'PAZURA';						
UPDATE actor SET last_name = 'BANANA' WHERE actor_id = 35;
SELECT * FROM actor WHERE actor_id = 35;
SET SQL_SAFE_UPDATES=0;													    -- zniesienie ograniczen w usuwaniu rekordow
DELETE FROM actor WHERE first_name="ED";                                    -- usuwanie rekordu
SELECT * FROM actor WHERE first_name="ED";                                  -- szukanie aktorów z imieniem "ED"
SELECT * FROM actor WHERE actor_id >= 35;                                   -- szukanie wszystkich aktorów od id 35
SELECT * FROM actor WHERE actor_id >= 35 && actor_id <= 45;                 -- szukanie wszystkich aktorów od id 35 do 45
SELECT * FROM actor WHERE actor_id >= 35 AND actor_id <= 45;                -- inna wersja jw
SELECT * FROM actor ORDER BY first_name;                                    -- wypisuje w kolejności rosnącej (alfabetycznej) -- default
SELECT * FROM actor ORDER BY first_name DESC;                               -- wypisuje w kolejności malehjącej (odwrotnie alfabetycznej)
UPDATE actor SET last_name = NULL WHERE actor_id = 201;                     -- nie wykonuje, bo baza jest zablokowana na wpisywanie nullów
SELECT * FROM film_text;
UPDATE film_text SET description = NULL WHERE film_id = 1;                  -- usuwa opis filmu z pierwszego rekordu w tabeli z tekstem filmu
SELECT * FROM film_text;
SELECT * FROM film_text WHERE description IS NULL;                          -- wyszukuje rekordy, gdzie w opis jest nullem
SELECT MIN(amount) FROM payment;                                            -- wyszukuje minimalną wartość płacy
SELECT MAX(amount) FROM payment;                                            -- wyszukuje maksymalną wartość płacy
SELECT AVG(amount) FROM payment;                                            -- oblicza średnią wartość płacy
SELECT COUNT(amount) FROM payment;                                          -- zlicza ilość wystąpienia kwoty w płacach
SELECT SUM(amount) FROM payment;                                            -- sumuje wszystkie płace razem
SELECT COUNT(amount) FROM payment WHERE amount >= 5;                        -- zlicza ilość wystąpień kwoty powyżej 5
SELECT * FROM actor WHERE first_name LIKE 'ED';                             -- wyszukuje wszystkie wystąpienia EDa
SELECT * FROM actor WHERE first_name LIKE 'E%';                             -- wyszukuje wszystkie imiona, które zaczynają się od "E"
SELECT * FROM actor WHERE first_name LIKE 'E_';                             -- wyszukuje wszystkie imiona, któe zaczynają się na "E" i mają po "E" jeden znak
SELECT * FROM actor WHERE first_name LIKE '_E';                             -- wyszukuje wszystkie imiona, które zaczynają się na jakiś jeden znak i mają po nim "E"
SELECT * FROM actor WHERE first_name LIKE '%E';                             -- wyszukuje wszystkie imiona, które kończą się na "E"
SELECT * FROM actor WHERE first_name LIKE '%E_';                            -- wyszukuje wszystkie imiona, któe mają przedostatnią literkę "E"
SELECT * FROM actor WHERE first_name LIKE '%ED';                            -- wyszukuje wszystkie imiona, które kończą się na "ED"
SELECT * FROM actor WHERE first_name LIKE '%E___';                          -- wyszukuje wszystkie imiona, które mają na czwartym miejscu od końca "E"
SELECT first_name, last_name FROM actor WHERE first_name IN ('JOHN', 'ED');	-- poszukiwania imion z list
SELECT * FROM actor WHERE first_name IN (SELECT first_name FROM actor WHERE first_name='ED'); -- poszukiwania imion z listy
SELECT * FROM actor WHERE first_name IN (SELECT first_name FROM staff); 	-- wyszukanie w tabeli actor imion z tabeli staff
SELECT a1.first_name FROM actor AS a1 WHERE first_name IN (SELECT a2.first_name FROM actor AS a2); -- nadawanie aliasow np. dla kolumn z roznych tabel
SELECT a1.first_name, a2.first_name FROM actor a1, staff a2;                -- do każdego rekordu dla staffa dodał rekord z aktora
SELECT a1.first_name as actory, a2.first_name FROM actor a1, staff a2;      -- zmienia nazwę kolumny na "actory"
SELECT SUM(amount) FROM payment GROUP BY (payment_date);                    -- sumuje kwoty na podstawie daty płatności
SELECT SUM(actor_id) FROM actor GROUP BY (first_name);
SELECT SUM(actor_id) FROM actor GROUP BY (first_name = 'ED');               -- sumuje id aktorów o imieniu ED
SELECT first_name, SUM(actor_id) FROM actor GROUP BY (first_name);          -- wypisuje imiona i sumuje id aktorów o tych imionch
SELECT first_name, COUNT(actor_id) FROM actor GROUP BY (first_name);        -- liczy wystąpienia imion
SELECT first_name, COUNT(actor_id) AS occur FROM actor GROUP BY first_name ORDER BY occur DESC;-- liczenie wystapien imion dla konkretnych imion i ustawienie w kolejności odwrotnie alfabetycznej
SELECT * FROM customer c JOIN address a;                                    -- łączy dwie tabele, ale nie po kluczach
SELECT * FROM customer c JOIN address a ON a.address_id = c.address_id;     -- połączenie dwóch tabel po kryterium adress_id
SELECT * FROM customer c, address a WHERE c.address_id = a.address_id;      -- inny sposób jw - niezalecany








