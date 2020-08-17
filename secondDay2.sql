-- CREATE TABLE nazwa_tabeli (id INT PRIMARY KEY AUTO_INCREMENT, nazwa_zmiennej RODZAJ_ZMIENNEJ(długość), nazwa_zmiennej RODZAJ_ZMIENNEJ(długość), itp.); -- tak się tworzy tabelę
-- CREATE TABLE pet(name VARCHAR(20), owner VARCHAR(20), species VARCHAR(20), sex CHAR(1), birth DATE, death DATE);                                       -- przykład tworzenia tabeli
CREATE TABLE attribute (
id INT PRIMARY KEY AUTO_INCREMENT,
 name VARCHAR(20) NOT NULL UNIQUE,
 description VARCHAR(200),
create_date DATETIME DEFAULT CURRENT_TIMESTAMP,
last_update DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
INSERT INTO attribute (name, description) VALUES ('table', 'grey simple table');
INSERT INTO attribute (name, description) VALUES ('chair', 'orange comfortable chair');
INSERT INTO attribute (name, description) VALUES ('schoolboard', 'dry clean magnetic schoolboard');
INSERT INTO attribute (name, description) VALUES ('TV', 'interactive TV');
INSERT INTO attribute (name, description) VALUES ('computer', 'basic computer for student');
SELECT * FROM attribute;
-- ALTER TABLE attribute
-- MODIFY create_date DATETIME DEFAULT CURRENT_TIMESTAMP,
-- MODIFY last_update DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;                                                                     -- nadpisuje zmiany dotyczące daty, jeśli nie były dodane wcześniej
-- ALTER TABLE attribute
-- MODIFY name VARCHAR(20) NOT NULL;                                                                                                                      -- dodaje NOT NULLa do nazwy, jeśli nie była dodana wcześniej
ALTER TABLE atrribute
MODIFY name VARCHAR(20) NOT NULL UNIQUE;                                                                                                                  -- dodaje NOT NULLa do nazwy, jeśli nie była dodana wcześniej
INSERT INTO attribute (name, description) VALUES ('teacher_table', 'executive teacher table'), ('teacher_chair', 'very comfortable teacher chair');       -- inny sposób dodawania elementów do tablicy
DROP TABLE classroom;
CREATE TABLE classroom_type (
id INT PRIMARY KEY AUTO_INCREMENT,
type VARCHAR(50) NOT NULL UNIQUE
);                                                                                                                                                        -- tworzy tabelę z typami sal
CREATE TABLE classroom (
id INT PRIMARY KEY AUTO_INCREMENT,
number INT NOT NULL UNIQUE,
floor INTEGER CHECK (floor >=-1 AND floor <=10),
type_id INT NOT NULL,
FOREIGN KEY (type_id) REFERENCES classroom_type(id),
create_date DATETIME DEFAULT CURRENT_TIMESTAMP,
last_update DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);                                                                                                                                                         -- tworzy tabelę sal
INSERT INTO classroom_type (type) VALUES ('history'), ('geography'), ('biology'), ('aula'), ('daycare_center');                                            -- dodaje typy sal do tabeli
INSERT INTO classroom_type (type) VALUES ('IT');                                                                                                           -- dodaje kolejny rekord do tabeli
INSERT INTO classroom (number, floor, type_id)
VALUES (1, 0,
(SELECT id FROM classroom_type WHERE type = 'IT'));   								                                                                	   -- dodaje jedną klasę do tabeli klas
ALTER TABLE classroom 
ADD COLUMN size INTEGER CHECK (size >= 0) NOT NULL,                
ADD COLUMN capacity INT NOT NULL;	                                                                                                                       -- dodaje nowe kolumny do tabeli klasa 
DELETE FROM classroom WHERE id=1;                                                                                                                          -- usuwam rekord o klasie, bo nie zawiera wartości, które dodałam dalej
INSERT INTO classroom (number, floor, size, capacity, type_id)
VALUES (1, 0, 50, 15,
(SELECT id FROM classroom_type WHERE type = 'IT'));                                                                                                        -- dodaję nową klasę do tabeli                                                                                      											
SELECT * FROM classroom;                                                                                                                                   -- sprawdzam, co jest zapisane w tabeli klas
CREATE TABLE classroom_attribute (
id INT PRIMARY KEY AUTO_INCREMENT,
classroom_id INT NOT NULL,
attribute_id INT NOT NULL,
FOREIGN KEY (classroom_id) REFERENCES classroom(id),
FOREIGN KEY (attribute_id) REFERENCES attribute(id),
create_date DATETIME DEFAULT CURRENT_TIMESTAMP,
last_update DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);                                                                                                                                                         -- łączy tabele klas i atrybutów
INSERT INTO classroom_attribute (classroom_id, attribute_id) VALUES ((SELECT id FROM classroom WHERE number=1), (SELECT id FROM attribute WHERE name='table')); -- wrzucam dane do połączonej tabeli klas i atrybutów
SELECT * FROM classroom_attribute;                                                                                                                         -- sprawdzam, co jest zapisane w połączonej tabeli              
INSERT INTO classroom (number, floor, size, capacity, type_id)
VALUES (2, 1, 150, 40,
(SELECT id FROM classroom_type WHERE type = 'aula'));                                                                                                      -- dodaję nową klasę do tabeli klas     
INSERT INTO classroom (number, floor, size, capacity, type_id)
VALUES (3, -1, 20, 5,
(SELECT id FROM classroom_type WHERE type = 'daycare_center'));                                                                                            -- dodaję nową klasę do tabeli klas 
INSERT INTO classroom_attribute (classroom_id, attribute_id) VALUES ((SELECT id FROM classroom WHERE number=1), (SELECT id FROM attribute WHERE name='table')); -- wrzucam dane do połączonej tabeli klas i atrybutów
INSERT INTO classroom_attribute (classroom_id, attribute_id) VALUES ((SELECT id FROM classroom WHERE number=1), (SELECT id FROM attribute WHERE name='chair')); -- wrzucam dane do połączonej tabeli klas i atrybutów
INSERT INTO classroom_attribute (classroom_id, attribute_id) VALUES ((SELECT id FROM classroom WHERE number=1), (SELECT id FROM attribute WHERE name='schoolboard')); -- wrzucam dane do połączonej tabeli klas i atrybutów
INSERT INTO classroom_attribute (classroom_id, attribute_id) VALUES ((SELECT id FROM classroom WHERE number=1), (SELECT id FROM attribute WHERE name='TV')); -- wrzucam dane do połączonej tabeli klas i atrybutów
INSERT INTO classroom_attribute (classroom_id, attribute_id) VALUES ((SELECT id FROM classroom WHERE number=1), (SELECT id FROM attribute WHERE name='computer')); -- wrzucam dane do połączonej tabeli klas i atrybutów
INSERT INTO classroom_attribute (classroom_id, attribute_id) VALUES ((SELECT id FROM classroom WHERE number=1), (SELECT id FROM attribute WHERE name='teacher_table')); -- wrzucam dane do połączonej tabeli klas i atrybutów
INSERT INTO classroom_attribute (classroom_id, attribute_id) VALUES ((SELECT id FROM classroom WHERE number=1), (SELECT id FROM attribute WHERE name='teacher_chair')); -- wrzucam dane do połączonej tabeli klas i atrybutów
INSERT INTO classroom_attribute (classroom_id, attribute_id) VALUES ((SELECT id FROM classroom WHERE number=2), (SELECT id FROM attribute WHERE name='chair')); -- wrzucam dane do połączonej tabeli klas i atrybutów
INSERT INTO classroom_attribute (classroom_id, attribute_id) VALUES ((SELECT id FROM classroom WHERE number=2), (SELECT id FROM attribute WHERE name='teacher_chair')); -- wrzucam dane do połączonej tabeli klas i atrybutów
INSERT INTO classroom_attribute (classroom_id, attribute_id) VALUES ((SELECT id FROM classroom WHERE number=2), (SELECT id FROM attribute WHERE name='schoolboard')); -- wrzucam dane do połączonej tabeli klas i atrybutów
INSERT INTO classroom_attribute (classroom_id, attribute_id) VALUES ((SELECT id FROM classroom WHERE number=3), (SELECT id FROM attribute WHERE name='TV')); -- wrzucam dane do połączonej tabeli klas i atrybutów
INSERT INTO classroom_attribute (classroom_id, attribute_id) VALUES ((SELECT id FROM classroom WHERE number=3), (SELECT id FROM attribute WHERE name='chair')); -- wrzucam dane do połączonej tabeli klas i atrybutów
INSERT INTO classroom_attribute (classroom_id, attribute_id) VALUES ((SELECT id FROM classroom WHERE number=3), (SELECT id FROM attribute WHERE name='teacher_chair')); -- wrzucam dane do połączonej tabeli klas i atrybutów
SELECT * FROM classroom_attribute;  
BEGIN;                                                                                                                                                      -- zaczynam transakcję
CREATE TABLE employee (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(200) NOT NULL,
pesel BIGINT(11) UNIQUE,
birth_date DATE NOT NULL,
employment_date DATE NOT NULL,
salary DECIMAL(9, 2) NOT NULL
);                                                                                                                                                         -- tworzę tabelę pracowników
CREATE TABLE address (
id INT PRIMARY KEY AUTO_INCREMENT,
street VARCHAR(200),
city VARCHAR(200),
country VARCHAR(200),
FOREIGN KEY (id) REFERENCES employee(id)
);                                                                                                                                                         -- tworzę tabelę adresów
COMMIT;                                                                                                                                                    -- kończę transakcję
INSERT INTO employee (first_name, last_name, birth_date, employment_date, salary) VALUES ('Mike', 'Magic', '1975-04-05', '2013-12-01', '28500.00');        -- dodaję pracownika do tabeli pracowników
INSERT INTO address (id, street) VALUE (1, 'grunwaldzka');                                                                                                 -- dodaję jeden adres do tabeli adresów
INSERT INTO address (id, street) VALUE ((SELECT id FROM employee WHERE last_name = 'Magic'), 'grunwaldzka');                                                -- inny sposób jw
-- CREATE TABLE address2 (
-- id INT PRIMARY KEY AUTO_INCREMENT,
-- street VARCHAR(200)
-- );                                                                                                                                                      -- inny przykład, gdy zaczynamy w odwrotnej kolejności
-- CREATE TABLE employee2 (
-- id INT PRIMARY KEY AUTO_INCREMENT,
-- first_name VARCHAR(50) NOT NULL,
-- address2_id INT UNIQUE,
-- FOREIGN KEY (address2_id) REFERENCES address2(id)
-- );                                                                                                                                                      -- tworzę przypisuję unikalny adres dla pracownika i tylko jeden; inny przykład cd.
                                                                                                                                                          -- ?


