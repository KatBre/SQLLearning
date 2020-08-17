-- BEGIN;
-- CREATE DATABASE school;
-- COMMIT;
CREATE USER 'newuser2'@'localhost' IDENTIFIED BY 'password';      -- tworzy nowego użytkownika
GRANT uprawnienie ON school.* TO 'newuser2';                      -- w miejscu uprawnienie wpisać uprawnienie do dodania z tej listy: https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html
GRANT INSERT ON school.* TO 'newuser2';                           -- dodaje wszystkie uprawnienia
SELECT * FROM mysql.user;                                         -- pokazuje wszystkich użytkownikówith
