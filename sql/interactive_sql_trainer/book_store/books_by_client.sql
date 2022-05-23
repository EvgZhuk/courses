SELECT buy.buy_id, title, price, buy_book.amount
FROM book
     INNER JOIN buy_book ON buy_book.book_id = book.book_id
     INNER JOIN buy ON buy.buy_id = buy_book.buy_id
     INNER JOIN client ON client.client_id = buy.client_id
WHERE name_client = 'Баранов Павел'
ORDER BY buy.buy_id, title;