WITH tabl1 (step_id, student_name, Шаг, Номер_попытки, result, Время_попытки)
    AS (
       SELECT step_id, student_name, CONCAT(module_id, '.', lesson_position, '.', step_position) AS 'Шаг',
              ROW_NUMBER () OVER (PARTITION BY step_id ORDER BY submission_time) AS 'Номер_попытки',
              result,CASE
              WHEN submission_time - attempt_time >= 3600 THEN (SELECT AVG(submission_time - attempt_time) 
                                       FROM step_student
                                       INNER JOIN student USING (student_id)
                                       WHERE submission_time - attempt_time <= 3600 AND student_name = 'student_59')
                 ELSE submission_time - attempt_time END AS 'Время_попытки'
       FROM student
       INNER JOIN step_student USING (student_id)
       INNER JOIN step USING (step_id)
       INNER JOIN lesson USING (lesson_id)
       WHERE student_name = 'student_59'
       ORDER BY step_id, Номер_попытки)
SELECT student_name AS 'Студент', Шаг, Номер_попытки, result AS 'Результат', 
       SEC_TO_TIME(ROUND(Время_попытки)) AS 'Время_попытки',
       ROUND((Время_попытки / SUM(Время_попытки) OVER (PARTITION BY Шаг) * 100), 2) AS 'Относительное_время'
FROM tabl1
GROUP BY student_name, Шаг, Номер_попытки, result, Время_попытки, step_id
ORDER BY step_id, Номер_попытки;