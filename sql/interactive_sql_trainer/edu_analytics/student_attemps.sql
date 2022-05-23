SELECT student_name AS 'Студент', CONCAT(LEFT(step_name, 20), '...') AS 'Шаг', result AS 'Результат',
    FROM_UNIXTIME(submission_time) AS 'Дата_отправки',
    SEC_TO_TIME(submission_time - IFNULL(LAG(submission_time) OVER (ORDER BY submission_time), submission_time))
    AS 'Разница'
FROM student
    INNER JOIN step_student USING (student_id)
    INNER JOIN step USING (step_id)
WHERE student_name = 'student_61'
GROUP BY student_name, step_name, result, submission_time
ORDER BY submission_time;   