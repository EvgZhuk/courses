WITH 
   T1 AS 
       (SELECT student_name, CONCAT(module_id, '.', lesson_position) AS Урок, MAX(submission_time) AS LT
        FROM step_student 
        INNER JOIN step USING (step_id) 
        INNER JOIN lesson USING (lesson_id)
        INNER JOIN student USING (student_id)
        WHERE result = 'correct'
        GROUP BY student_name, lesson_id),
   T2 AS
       (SELECT student_name
        FROM T1
        GROUP BY student_name
        HAVING COUNT(*) >= 3)
SELECT student_name AS Студент, Урок, FROM_UNIXTIME(LT) AS Макс_время_отправки, 
       IFNULL(CEIL((LT - LAG(LT) OVER (PARTITION BY student_name ORDER BY LT)) / 86400), '-') AS Интервал
FROM T1 
INNER JOIN T2 USING (student_name)
ORDER BY 1, 3;