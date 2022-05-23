SELECT CONCAT(module_id, '.', lesson_position, '.',
              IF(step_position < 10, CONCAT(0, step_position), step_position), ' ', step_name) AS 'Шаг'
FROM step
INNER JOIN lesson USING (lesson_id)
INNER JOIN module USING (module_id)
WHERE step_id IN (SELECT step_id
FROM keyword
INNER JOIN step_keyword USING (keyword_id)
WHERE keyword_name IN ('AVG', 'MAX')
GROUP BY step_id
HAVING COUNT(keyword_name) = 2)
ORDER BY 1
