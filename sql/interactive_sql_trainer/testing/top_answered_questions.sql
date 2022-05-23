SELECT name_subject, CONCAT(LEFT(name_question, 30), '...') AS 'Вопрос', 
     COUNT(question.question_id) AS 'Всего_ответов', 
     ROUND (((SUM(is_correct) / COUNT(question.question_id)) * 100), 2) AS 'Успешность'
FROM subject
   INNER JOIN question USING(subject_id)
   INNER JOIN testing  USING(question_id)
   LEFT JOIN answer USING(answer_id)
GROUP BY name_subject, name_question
ORDER BY name_subject, Успешность DESC, Вопрос;

