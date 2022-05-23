SELECT YEAR(date_payment) AS 'Год', MONTHNAME(date_payment) AS 'Месяц', SUM(price * amount) AS 'Сумма'
FROM  buy_archive
GROUP BY Год, Месяц
UNION
SELECT YEAR(date_step_end) AS 'Год', MONTHNAME(date_step_end) 'Месяц', SUM(price * buy_book.amount) AS 'Сумма'
FROM book
   INNER JOIN buy_book USING(book_id)
   INNER JOIN buy USING(buy_id)
   INNER JOIN buy_step USING(buy_id)
   INNER JOIN step USING(step_id)
WHERE  date_step_end IS NOT NULL AND name_step = 'Оплата'
GROUP BY Год, Месяц
ORDER BY Месяц, Год;
