SELECT CONCAT(module_id, ' ',LEFT(module_name, 14), '...') AS 'Модуль', 
       CONCAT(module_id, '.', lesson_position, ' ',LEFT(lesson_name, 12), '...') AS 'Урок', 
       CONCAT(module_id, '.', lesson_position, '.', step_position, ' ', step_name) AS 'Шаг'
FROM module
INNER JOIN lesson USING(module_id)
INNER JOIN step USING(lesson_id)
WHERE step_name LIKE '%вложен%запрос%'
ORDER BY Модуль, Урок, Шаг;
