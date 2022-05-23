WITH get_rate (mod_id, stud_id, shag)
AS (
    SELECT module_id, student_name, COUNT(DISTINCT step_id)
    FROM lesson
    INNER JOIN step USING (lesson_id)
    INNER JOIN step_student USING (step_id)
    INNER JOIN student USING (student_id)
    WHERE result = 'correct'
    GROUP BY module_id, student_name)
SELECT mod_id AS 'Модуль', stud_id AS 'Студент', shag AS 'Пройдено_шагов',
       ROUND(((shag / MAX(shag) OVER (PARTITION BY mod_id)) * 100), 1) AS 'Относительный_рейтинг'
FROM get_rate
ORDER BY Модуль, Относительный_рейтинг DESC, Студент;