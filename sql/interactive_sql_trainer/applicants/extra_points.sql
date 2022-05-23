SELECT name_enrollee, IFNULL(SUM(achievement.bonus), 0) AS 'Бонус'
FROM enrollee
   LEFT JOIN enrollee_achievement USING(enrollee_id)
   LEFT JOIN achievement USING(achievement_id)
GROUP BY name_enrollee
ORDER BY name_enrollee;

