SELECT name_student, name_subject, date_attempt, ROUND (SUM(((is_correct) / 3) * 100), 2) AS 'Результат'
FROM student
   INNER JOIN attempt USING(student_id)
   INNER JOIN subject USING(subject_id)
   INNER JOIN testing USING(attempt_id)
   INNER JOIN answer USING(answer_id)
GROUP BY name_student, name_subject, date_attempt
ORDER BY name_student, date_attempt DESC;
