WITH kol_razl_sagov (student_id, razlich_sagov)
    AS (
        SELECT student_id, COUNT(DISTINCT step_id) AS vsego_sagov
        FROM step_student
        GROUP BY student_id), 
    kol_corr_otv (student_id, correct_otv)
    AS (
        SELECT student_id, COUNT(DISTINCT step_id) AS correct_otv 
        FROM step_student
        WHERE result = 'correct'
        GROUP BY student_id)
SELECT student_name AS 'Студент', Прогресс,
    CASE
        WHEN Прогресс = 100 THEN 'Сертификат с отличием'
        WHEN Прогресс >= 80 THEN 'Сертификат'
        ELSE ''
        END AS 'Результат'
FROM (
SELECT student_name, student_id, 
    ROUND (correct_otv / (SELECT COUNT(DISTINCT step_id) FROM step_student) * 100) AS Прогресс
    FROM kol_razl_sagov
    INNER JOIN kol_corr_otv USING (student_id)
    INNER JOIN student USING (student_id)) tabl_1
ORDER BY Прогресс DESC, Студент;