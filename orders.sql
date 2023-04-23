--https://dev.mysql.com/doc/refman/8.0/en/datetime.html
--https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html

--MySQL предоставляет большой набор возможностей для выполнения различных операций, таких как сложение и вычитание дат, получение разницы между 2 датами, получение конкретных частей заданного значения даты и времени, получение данных за определенный период времени и т.д.

--Типы данных включают YEAR, DATE, TIME, DATETIME и TIMESTAMP.

--YEAR - может хранить год в диапазоне 1901 - 2155 или 0000
--DATE - диапазон '1000-01-01' до '9999-12-31'
--TIME - диапазон '00:00:00' до '23:59:59'
--DATETIME - диапазон '1000-01-01 00:00:00' до '9999-12-31 23:59:59'
--TIMESTAMP - диапазон '1970-01-01 00:00:01' до '2038-01-19 03:14:07'

--Наиболее часто используемым разделителем для дат является тире (-), а для времени - двоеточие (:). Но мы можем использовать любой символ, или вообще не добавлять никакого символа.

INSERT INTO tbl (f_date, f_time, f_year, f_datetime, f_timestamp);
VALUES (CURDATE(), CURTIME(), YEAR(NOW()), NOW(), CURRENT_TIMESTAMP());

INSERT INTO tbl (f_datetime, f_timestamp) 
VALUES ('2023-04-23 10:11:12', '2023-04-23 10:11:12');

INSERT INTO tbl (f_datetime, f_timestamp) 
VALUES ('20230423101112', '2023/04/23/10/11/12');

--Функция DATE ADD() позволяет добавить к дате нужный интервал
SELECT NOW(), DATE_ADD(NOW(), interval 10 day);

--При добавлении месяца результат будет коррелироваться
SELECT NOW(), DATE_ADD('2023-03-30 13:42:15', interval 1 MONTH) AS d1, DATE_ADD('2023-03-31 13:42:15', interval 1 MONTH) AS d2;

--Выборка заказов за месяц
SELECT * FROM orders WHERE YEAR(created) = '2012' AND MONTH(created) = 5;
SELECT * FROM orders WHERE created BETWEEN '2012-05-01' AND '2012-05-31';
SELECT * FROM orders WHERE created BETWEEN '2012-05-01 00:00:00' AND '2012-05-31 23:59:59';
SELECT * FROM orders WHERE created BETWEEN '2012-05-01' AND '2012-06-01';
SELECT * FROM orders WHERE created BETWEEN '2012-05-01' AND DATE_ADD('2012-05-01', interval 1 MONTH);

--Группировка количества заказов по месяцам
SELECT COUNT(*) FROM orders WHERE YEAR(created) = 2020 GROUP BY MONTH(created);
SELECT MONTH(created) AS m, COUNT(*) FROM orders WHERE YEAR(created) = 2020 GROUP BY m;

--и с сортировкой
SELECT MONTH(created) AS m, COUNT(*) FROM orders WHERE YEAR(created) = 2020 GROUP BY m;
SELECT MONTH(created) AS m, COUNT(*) AS cnt FROM orders WHERE YEAR(created) = 2020 GROUP BY m ORDER BY cnt;

--Заказы за текущий месяц
SELECT COUNT(*) FROM orders WHERE MONTH(created) = MONTH(NOW()) AND YEAR(created) = YEAR(NOW());
SELECT COUNT(*) FROM orders WHERE created BETWEEN '2023-04-01' AND NOW();

--Заказы за последние 3 дня
SELECT NOW(), DATE(NOW() - interval 3 DAY); # !
SELECT NOW(), date_add(NOW(), interval -3 DAY); # ?
SELECT * FROM orders WHERE created BETWEEN DATE(NOW() - interval 3 DAY) and NOW();
