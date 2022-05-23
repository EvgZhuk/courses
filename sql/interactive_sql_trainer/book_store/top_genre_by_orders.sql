SELECT name_genre, SUM(buy_book.amount) AS 'Количество'
FROM buy_book
   INNER JOIN book ON book.book_id = buy_book.book_id
   INNER JOIN genre ON genre.genre_id = book.genre_id
GROUP BY name_genre
HAVING SUM(buy_book.amount) = (SELECT MAX(sum_amount) AS max_sum_amount FROM
(SELECT name_genre, SUM(buy_book.amount) AS sum_amount
FROM buy_book
   INNER JOIN book ON book.book_id = buy_book.book_id
   INNER JOIN genre ON genre.genre_id = book.genre_id
GROUP BY name_genre) query1);