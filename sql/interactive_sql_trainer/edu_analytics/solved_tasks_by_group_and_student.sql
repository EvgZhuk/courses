WITH tabl1
    AS (SELECT student_name, result, LAG(result) OVER (PARTITION BY student_id, step_id 
               ORDER BY  student_id, step_id, submission_time) AS lag_result 
        FROM student
        INNER JOIN step_student USING (student_id)),
     tabl1_1
    AS (SELECT 'I' AS 'Группа', student_name AS 'Студент', COUNT(*) AS 'Количество_шагов'
        FROM tabl1
        WHERE lag_result = 'correct' AND result = 'wrong'
        GROUP BY student_name),
     tabl2
    AS (SELECT student_name, step_id
        FROM student
        INNER JOIN step_student USING (student_id)
        WHERE result = 'correct'),
      tabl2_1
    AS (SELECT student_name, step_id, COUNT(step_id) AS 'kol_ver'
        FROM tabl2
        GROUP BY student_name, step_id
        HAVING COUNT(step_id) > 1),
      tabl2_2
    AS (SELECT 'II' AS 'Группа', student_name AS 'Студент', COUNT(student_name) AS 'Количество_шагов'
        FROM tabl2_1
        GROUP BY student_name),
      tabl3
    AS (SELECT DISTINCT CONCAT (student_id, '.', step_id) AS stud_wrong
        FROM student
        INNER JOIN step_student USING (student_id)
        WHERE result = 'wrong'),
     tabl3_1
    AS (SELECT student_name, result, CONCAT (student_id, '.', step_id) AS stud_wrong
        FROM student
        INNER JOIN step_student USING (student_id)),
     tabl3_2
    AS (SELECT student_name, stud_wrong
        FROM tabl3_1
        GROUP BY student_name, stud_wrong
        HAVING COUNT(DISTINCT result) = 1),
     tabl3_3
    AS (SELECT 'III' AS 'Группа', student_name AS Студент, COUNT(student_name) AS Количество_шагов
        FROM tabl3
        INNER JOIN tabl3_2 USING (stud_wrong)
        GROUP BY student_name)
SELECT * FROM tabl1_1
UNION ALL
SELECT * FROM tabl2_2
UNION ALL
SELECT * FROM tabl3_3
ORDER BY Группа, Количество_шагов DESC, Студент;