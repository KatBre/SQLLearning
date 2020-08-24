SET NAMES  'utf8';
SET CHARACTER SET utf8;
DROP TABLE IF EXISTS kontrola;
DROP TABLE IF EXISTS numer_stanowiska;
DROP TABLE IF EXISTS port_lotniczy;
DROP TABLE IF EXISTS przyznane_nagrody;
DROP TABLE IF EXISTS straznik;
 
CREATE TABLE  straznik (
	id		    	BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	imie		    CHAR(200) NOT NULL,
	nazwisko	    CHAR(200) NOT NULL,
	stopien		    CHAR(50)  NOT NULL CHECK (stopien='Szeregowiec' OR stopien='Starszy szeregowiec' OR stopien='Kapral' OR stopien='Starszy kapral'),
	data_zatrudnienia   DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
	pensja		    NUMERIC(8,2) NOT NULL CHECK(pensja>=0),
	skladka_na_ubezpieczenie NUMERIC(8,2)
);

DROP TABLE IF EXISTS straznik_archiwum;
CREATE TABLE  straznik_archiwum (
	id		    	BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,      
	imie		    CHAR(200) NOT NULL,
	nazwisko	    CHAR(200) NOT NULL,
	stopien		    CHAR(50)  NOT NULL CHECK (stopien='Szeregowiec' OR stopien='Starszy szeregowiec' OR stopien='Kapral' OR stopien='Starszy kapral'),
	data_zatrudnienia   DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
	pensja		    NUMERIC(8,2) NOT NULL CHECK(pensja>=0),
	skladka_na_ubezpieczenie NUMERIC(8,2)
);

CREATE TABLE  przyznane_nagrody (
	straznik_id	    INT8  NOT NULL REFERENCES  straznik(id),
	nazwa	            CHAR(200) NOT NULL,
	data_przyznania	    DATETIME  NOT NULL,
	PRIMARY KEY (straznik_id, nazwa, data_przyznania)
);

CREATE TABLE  port_lotniczy (
	nazwa_portu	CHAR(200) PRIMARY KEY
);

CREATE TABLE  numer_stanowiska (
	id		BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	nazwa_portu	CHAR(200) NOT NULL,
	numer  		INT NOT NULL ,
    FOREIGN KEY (nazwa_portu) REFERENCES port_lotniczy(nazwa_portu)
);

DROP TABLE IF EXISTS pasazer;
CREATE TABLE  pasazer (
	id			BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	imie		CHAR(100) NOT NULL,
	nazwisko	CHAR(100) NOT NULL
);


CREATE TABLE  kontrola (
	id_straznik		INT8 NOT NULL,
	id_pasazer		INT8 NOT NULL,
	id_numer_stanowiska     INT8 NOT NULL,
	wynik_kontroli		BOOLEAN NOT NULL,
	czas_kontroli 		DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY  (id_straznik,id_pasazer,id_numer_stanowiska,czas_kontroli),
    
    FOREIGN KEY (id_straznik) REFERENCES straznik(id) ON DELETE CASCADE,
	FOREIGN KEY (id_pasazer) REFERENCES pasazer(id) ON DELETE CASCADE,
	FOREIGN KEY (id_numer_stanowiska) REFERENCES numer_stanowiska(id) ON DELETE CASCADE
);

-- przykładowe dane
INSERT INTO  straznik (imie, nazwisko, stopien, data_zatrudnienia, pensja,skladka_na_ubezpieczenie) 
VALUES 
	('Jan', 'Kowalski', 'Szeregowiec',                DATE_ADD(now(), INTERVAL -10 MONTH), 1500, 300),
	('Marek', 'Nowak'   , 'Starszy szeregowiec',      DATE_ADD(now(), INTERVAL -12 MONTH), 2300, 3320),
	('Franciszek', 'Kowalczyk', 'Szeregowiec',        DATE_ADD(now(), INTERVAL -50 MONTH), 1300,290),
	('Zdzisław', 'Nowak'   , 'Starszy szeregowiec',   DATE_ADD(now(), INTERVAL -11 MONTH), 2200,500),
	('Teofil', 'Kowalski', 'Szeregowiec',             DATE_ADD(now(), INTERVAL -1 MONTH), 2500,200),
	('Jan', 'Nowak'   , 'Starszy szeregowiec',        DATE_ADD(now(), INTERVAL -2 MONTH), 3000,200),
	('Jan', 'Nowakowski'   , 'Starszy szeregowiec',   DATE_ADD(now(), INTERVAL -2 MONTH), 3000,200);

INSERT INTO  straznik_archiwum (imie, nazwisko, stopien, data_zatrudnienia, pensja,skladka_na_ubezpieczenie) 
VALUES 
	('Stefan', 'Jeziorański', 'Szeregowiec',        DATE_ADD(now(), INTERVAL -32 MONTH), 1500, 300);

INSERT INTO  przyznane_nagrody (straznik_id,nazwa, data_przyznania) VALUES 
	(1, 'Przepracowane 10 lat pracy',   DATE_ADD(now(), INTERVAL -20 MONTH)) , 
	(2, 'Nagroda generała',             DATE_ADD(now(), INTERVAL -11 MONTH)),
	(3, 'Przepracowane 15 lat pracy',   DATE_ADD(now(), INTERVAL -23 MONTH)) , 
	(4, 'Nagroda pułkownika',           DATE_ADD(now(), INTERVAL -43 MONTH)),
	(5, 'Przepracowane 20 lat pracy',   DATE_ADD(now(), INTERVAL -23 MONTH)) , 
	(6, 'Nagroda generała',             DATE_ADD(now(), INTERVAL -5 MONTH));

INSERT INTO  port_lotniczy (nazwa_portu) VALUES ('Gdańsk'), ('Warszawa'), ('Szczecin');

INSERT INTO  numer_stanowiska (nazwa_portu, numer) VALUES
	('Gdańsk', 1), ('Gdańsk',2), ('Gdańsk',3),
	('Warszawa',1), ('Warszawa',2), ('Warszawa',3), ('Warszawa',4),
	('Szczecin',1), ('Szczecin',2), ('Szczecin',3)	
	;

INSERT INTO  pasazer (imie, nazwisko) 
VALUES 
	('Jan', 'Brzechwa'), 
	('Stanisław', 'Wyspański'), 
	('Henryk','Sienkiewicz'),
	('Władysław', 'Bartoszewski'),
	('Stefan', 'Żeromski'),
	('Maria', 'Konopnicka'),
	('Maria', 'Kownacka');

INSERT INTO  kontrola (id_straznik, id_pasazer, id_numer_stanowiska, wynik_kontroli, czas_kontroli) VALUES 
 (1, 1, 1, true, DATE_ADD(now(), INTERVAL -5 MONTH)),
 (1, 2, 1, false, now()),
 (2, 2, 4, true, DATE_ADD(now(), INTERVAL -5 MONTH)),
 (2, 2, 5, true, DATE_ADD(now(), INTERVAL -15 MONTH)),
 (3, 1, 1, true, DATE_ADD(now(), INTERVAL -2 MONTH)),
 (3, 2, 1, false, DATE_ADD(now(), INTERVAL -25 MONTH)),
 (4, 2, 4, true, now()),
 (5, 2, 5, true, DATE_ADD(now(), INTERVAL -5 MONTH)),
 (6, 1, 1, true, DATE_ADD(now(), INTERVAL -25 MONTH)),
 (3, 2, 1, false, DATE_ADD(now(), INTERVAL -45 MONTH)),
 (4, 2, 4, true, DATE_ADD(now(), INTERVAL -1 MONTH)),
 (5, 2, 5, true, DATE_ADD(now(), INTERVAL -15 MONTH));
 
-- Podstawowe zapytania
-- 1) Wyświetlenie wszystkich strażników z tym, że zamiast kolumna 'imie' 
-- chciałbym żeby była kolumna imie_strażnika a po tym wszystkie oryginalne kolumny.
SELECT imie AS 'imie_straznika', nazwisko, stopien, data_zatrudnienie, pensja, skladka_na_ubezpieczenie FROM kontrolalotow.straznik;

-- 2) Wyświetlić strażników którzy mają pensje (bez uwzględniania składni na ubezpieczenia) większe niż 1500zł
SELECT * FROM straznik WHERE pensja - skladka_na_ubezpieczenie > 1500;

-- 3) Wyświetlić strażników z pensją większą od 1500zł ale mniejszą niż 2500zł
SELECT * FROM straznik WHERE pensja >1500 AND pensja <2500;
SELECT * FROM straznik WHERE pensja BETWEEN 1500 AND 2500;                                                                                    -- drugi sposób

-- 4) Wyświetlić strażników ale bez strażników o nazwisku Nowak i Kowalczyk
SELECT * FROM straznik WHERE nazwisko NOT IN ("Nowak", "Kowalczyk");

-- 5) Wyświetlić strażników ale bez strażników o id 1,6,5 (z użyciem IN)
SELECT * FROM straznik WHERE id NOT IN (1,5,6);

-- 6) Wyświetlić strazników i pensje które są większe od 1500 ale po odjęciu "skladka_na_ubezpieczenie"
SELECT * FROM straznik WHERE pensja - skladka_na_ubezpieczenie > 1500;

-- 7) Wyświetlić pasażerów posortowanych po nazwisku i imieniu (kolejnosci rosnaca)
SELECT * FROM pasazer ORDER BY  nazwisko ASC, imie ASC;

-- 8) Wyświetlić strażników którzy mają nazwisko rozpoczynające się od "Kowal"
SELECT * FROM straznik WHERE nazwisko LIKE 'Kowal%';

-- 9) Wyświetlić strażników o nazwisku Nowak i którzy zostali zatrudnieni 
-- od początku poprzedniego roku
SELECT * FROM straznik WHERE nazwisko='Nowak' AND data_zatrudnienia >= '2019-01-01 00:00:00';
SELECT * FROM straznik WHERE nazwisko='Nowak' AND data_zatrudnienia >= DATE_FORMAT(DATE_ADD(now(), INTERVAL -12 MONTH),'%Y-01-01');                              -- drugi sposób
-- SELECT DATE_ADD(now(), INTERVAL -12 MONTH)
-- SELECT DATE_FORMAT(DATE_ADD(now(), INTERVAL -12 MONTH),'%Y-01-01');

-- 10) Wyświetlić nazwisko+pensje strażników pomniejszone skladka_na_ubezpieczenie, kolumna ma się nazywać pensja_do_wyplaty
SELECT nazwisko, (pensja - skladka_na_ubezpieczenie) AS "pensja_do_wyplaty" FROM straznik;

-- 11) Wyświetlić wszystkich strażników aktualnych i archiwalnych 
-- ( straznik_archiwum) w jednej tabeli
SELECT * FROM straznik UNION SELECT * FROM straznik_archiwum;

-- 12) Wyświetlić strażnika który nie ma ustawionego pola skladka_na_ubezpieczenie (jest to NULL)
SELECT * FROM straznik WHERE skladka_na_ubezpieczenie IS NULL;

-- Używanie agregatów - Proszę 
-- ---------------------------
-- 13) Napisać zapytania które poda sumę  pensji (pola pensja) dla wszystkich strażników
SELECT SUM(pensja) FROM straznik;

-- 14) Podać średnią pensję strażników 
SELECT AVG(pensja) FROM straznik;

-- 15) Wyświetlić największą pensje
SELECT MAX(pensja) FROM straznik;

-- 16) Podac liczbę  pasażerów w systemie
SELECT COUNT(*) FROM pasazer;

-- 17) Podać liczbę strażników ale tych którzy mają uzupełnione pole skladka_na_ubezpieczenie
SELECT COUNT(*) FROM straznik WHERE skladka_na_ubezpieczenie IS NOT NULL;

-- Zapytania z JOIN
-- -------------------
-- 18) Wyświetlić wszystkie kontrole przeprowadzone na  lotnisku Gdańsk
SELECT k.* FROM kontrola k JOIN numer_stanowiska ns ON k.id_numer_stanowiska=ns.id WHERE nazwa_portu= 'Gdańsk';

-- 19) Wyświetlić wszystkie kontrole przeprowadzone dla lotnisku Gdańsk przez strażnika/ów który ma nazwisko 
-- 'Nowak'
SELECT k.* FROM kontrola k JOIN numer_stanowiska ns ON k.id_numer_stanowiska=ns.id JOIN straznik s ON k.id_straznik=s.id WHERE ns.nazwa_portu='Gdańsk' AND s.nazwisko='Nowak';

-- 20) Wyświetlić strażników i przeprowadzone przez nich kontrole jeśli strażnik nie ma kontroli to wyświetlamy informację o strażniku a w części kontrolu wyświetlamy nulle 
SELECT * FROM straznik s LEFT JOIN kontrola k ON s.id = k.id_straznik;

-- Jan Kowalski		
	-- kont 1
-- Marian Pazdzioch
	-- kont 1
	-- kont 3
	-- kont 2
-- Paweł Recław
	-- kont 3
-- Juzek - prawa strona (kolumny z danymi kontroli) będzie pusta, jeśli nie przeprowadzał kontroli
-- Rafau - prawa strona (kolumny z danymi kontroli) będzie pusta, jeśli nie przeprowadzał kontroli

-- 21) Wyświetlić wszystkie lotniska odwiedzone przez pasażera imie="Jan"  AND nazwisko="Brzechwa"  
SELECT nazwa_portu FROM numer_stanowiska ns JOIN kontrola k ON k.id_numer_stanowiska=ns.id JOIN pasazer p ON k.id_pasazer=p.id WHERE imie='Jan' AND nazwisko='Brzechwa' GROUP BY nazwa_portu; 

-- PODZAPYTANIA
-- ----------------
-- 22) Wyświetlić wszystkie kontrole przeprowadzone dla lotniska Gdańsk 
-- przez strażnika który ma największe zarobki
SELECT * FROM kontrola k LEFT JOIN straznik s ON s.id = k.id_straznik JOIN numer_stanowiska ns ON k.id_numer_stanowiska=ns.id WHERE ns.nazwa_portu='Gdańsk' AND s.pensja = (SELECT MAX(pensja) FROM straznik);

-- 23) Wyświetlić z użyciem podzapytania wszystkich 
-- pasażerów skontrolowanych przez strażnika o nazwisku "Nowak"
SELECT p.* FROM kontrola k JOIN straznik s ON k.id_straznik = s.id JOIN pasazer p ON k.id_pasazer = p.id WHERE s.id IN (SELECT s.id FROM straznik s WHERE s.nazwisko = "Nowak") GROUP BY p.nazwisko;

-- 24) Wyświetlić strażników a w ostatniej kolumnie kwotę najwyższej 
-- pensji strażnika
SELECT s.*, (SELECT MAX(s.pensja) FROM straznik s) FROM straznik s; 

-- 25) Wyświetlić strażników a w ostatniej kolumnie informację o
--  ile mniej/więcej zarabia dany strażnik od średniej  
SELECT imie, nazwisko, pensja, (pensja - (SELECT AVG(pensja) FROM straznik)) AS ile_mniej_wiecej FROM straznik;

-- Zlozone

-- SELECT * FROM pasazer ORDER BY nazwisko LIMIT 2 OFFSET 3

-- 26) Wyświetlić pasażera który  nigdy nie był kontrolowany. 
SELECT * FROM pasazer WHERE id NOT IN (SELECT p.id FROM pasazer p RIGHT JOIN kontrola k ON k.id_pasazer = p.id GROUP BY p.id);
SELECT p.* FROM kontrola k RIGHT JOIN pasazer p ON k.id_pasazer = p.id WHERE k.id_pasazer IS NULL;                                                                    -- drugi sposób

-- 27) Znaleźć pasażera który odwiedził największą ilość lotnisk (użyć LIMIT), 
-- wyświetlić jaką liczbę lotnisk odwiedzili (jeśli pasażer odwiedził dwa razy to samo lotnisko
-- to zliczamy to jako jedno odwiedzenie).
SELECT id, imie,nazwisko, count(*) AS ilosc_lotnisk FROM
(SELECT  DISTINCT p.id,p.imie, p.nazwisko, ns.nazwa_portu FROM  pasazer p JOIN  kontrola k ON (k.id_pasazer=p.id) JOIN  numer_stanowiska ns ON (k.id_numer_stanowiska=ns.id)) T
GROUP BY id, imie,nazwisko ORDER BY  ilosc_lotnisk DESC LIMIT 1;

(SELECT DISTINCT nazwa_portu,imie, nazwisko FROM pasazer p JOIN kontrola k ON k.id_pasazer = p.id LEFT JOIN numer_stanowiska ns ON k.id_numer_stanowiska = ns.id) tabela;
SELECT count(*) AS ilosc_lotnisk, x.imie, x.nazwisko FROM pasazer x JOIN
		(SELECT DISTINCT nazwa_portu,id_pasazer FROM pasazer p JOIN kontrola k ON k.id_pasazer = p.id LEFT JOIN numer_stanowiska ns ON k.id_numer_stanowiska = ns.id) t
        ON t.id_pasazer=x.id GROUP BY x.id ORDER BY ilosc_lotnisk LIMIT 1;                                                                                                -- drugi sposób

-- 28) Znaleźć 2 strażników którzy skontrolowali największą ilość pasażerów
-- (ponowna kontrola pasażera zliczana jest jako dodatkowa kontrola)
SELECT s.*, COUNT(ns.id) FROM kontrola k JOIN straznik s ON k.id_straznik = s.id JOIN numer_stanowiska ns ON k.id_numer_stanowiska = ns.id GROUP BY s.id ORDER BY COUNT(ns.id) DESC LIMIT 2;
select id, imie, nazwisko, count(*) as ilosc_kontroli from straznik s
					join (select k.id_pasazer, s.id as straznik_id from kontrola k join straznik s on k.id_straznik=s.id) p on p.straznik_id = s.id
					group by s.id order by ilosc_kontroli desc limit 2;                                                                                                     -- drugi sposób                                                                                                                                                    -- drugi sposób

-- 29) Znaleźć lotnisko przez które poleciała najmniejsza ilość pasażerów 
-- (=liczba skontrolowanych pasazerow) ale większa od zera 
select count(*), nazwa_portu from kontrola k join numer_stanowiska ns on k.id_numer_stanowiska = ns.id group by nazwa_portu;

-- 30) Znaleźć miesiac (w przeciagu całego okresu)  w którym był największy ruch na 
-- wszystkich lotniskach. Użyć	date_trunc('month', czas_kontroli)
SELECT DATE_FORMAT(czas_kontroli, '&Y-%m-01'), COUNT(*) FROM kontrola GROUP BY DATE_FORMAT(czas_kontroli,'%Y-%m-01') ORDER BY 2 DESC LIMIT 1; 
SELECT *, DATE_FORMAT(czas_kontroli,'%Y-%m-01') FROM kontrola;                                                                                                                 -- drugi sposób 

-- SELECT DATE_FORMAT(now(),'%Y-%m-01'); 
-- 	
-- 31) Wyświetlić  ilość pasażerów w kolejnych latach dla każdego lotniska  (lotnisko sortujemy według nazwy rosnąco a póxniej według roku)
--   Lotnisko ABC   2000   300
--   Lotnisko ABC   2001   400
--   Lotnisko BCD   2000   333
--   Lotnisko CDE   2000   323
--   Lotnisko CDE   2001   332
SELECT ns.nazwa_portu,year(k.czas_kontroli) as rok,count(*) as ilosc
		FROM kontrola k join pasazer p on k.id_pasazer=p.id
			join numer_stanowiska ns on k.id_numer_stanowiska=ns.id
			group by nazwa_portu, rok
            order by nazwa_portu, rok;

-- MODYFIKACJA DANYCH
-- 32) Umieścić wiersz z swoimi danymi w tablicy pasażera i dodać kontrole na lotnisku Gdańsk przez strażnika id=1 w dniu dzisiejszym
INSERT INTO pasazer(id, imie, nazwisko) VALUES((SELECT MAX(id)+1), 'Katarzyna', 'Brewińska');
    
-- 33) Zmienić nazwisko strażników z 'Nowak' na 'Nowakowski' przy okazji zwiększając im pensje o 10%
UPDATE straznik 

-- 34) Skasować wiersz  z swoim wpisem w tablicy pasażer.
DELETE FROM pasazer WHERE MAX(id);

-- 35) Skasować strażnika który skontrolował największa liczbę pasażerów.

