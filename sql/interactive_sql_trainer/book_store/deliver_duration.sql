SELECT buy.buy_id, DATEDIFF(date_step_end, date_step_beg) AS 'Количество_дней', 
     IF (date_step_end IS NOT NULL, IF (DATEDIFF(date_step_end, date_step_beg) > days_delivery, DATEDIFF(date_step_end, date_step_beg) - days_delivery, 0), DATEDIFF(date_step_end, date_step_beg)) AS 'Опоздание'
FROM buy
    INNER JOIN buy_step ON buy_step.buy_id = buy.buy_id
    INNER JOIN step ON step.step_id = buy_step.step_id
    INNER JOIN client ON client.client_id = buy.client_id
    INNER JOIN city ON city.city_id = client.city_id
WHERE date_step_end IS NOT NULL AND date_step_beg IS NOT NULL AND step.step_id = 3
ORDER BY buy_id;   