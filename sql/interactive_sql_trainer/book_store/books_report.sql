SELECT title, SUM(sum_amount) AS 'Количество', SUM(Summa) AS 'Сумма'
FROM
     (SELECT title, SUM(buy_book.amount) AS sum_amount, SUM(book.price * buy_book.amount) AS Summa
FROM book
   INNER JOIN buy_book USING(book_id)
   INNER JOIN buy USING(buy_id)
   INNER JOIN buy_step USING(buy_id)
WHERE date_step_end IS NOT NULL AND step_id = 1
GROUP BY title
UNION
SELECT title, SUM(buy_archive.amount) AS sum_amount_archive, SUM(buy_archive.price * buy_archive.amount) AS 'Сумма_архив'
FROM  buy_archive
   INNER JOIN book USING(book_id)
GROUP BY title) query1
GROUP BY title   
ORDER BY Сумма DESC;
