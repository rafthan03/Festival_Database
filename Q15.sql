/* Βρείτε τους top-5 επισκέπτες που έχουν δώσει συνολικά την υψηλότερη βαθμολόγηση σε ένα καλλιτέχνη. (όνομα
επισκέπτη, όνομα καλλιτέχνη και συνολικό σκορ βαθμολόγησης)*/
Select v.first_name,v.last_name,pe.name,sum(r.interpretation+overall_experience) as score
FROM rating r
JOIN ticket t ON t.ticket_id=r.ticket_id
JOIN Visitor v  ON t.visitor_id = v.visitor_id
JOIN performance p On p.performance_id=r.performance_id
JOIN performer pe ON pe.performer_id=p.performer_id
GROUP BY v.visitor_id, p.performer_id
ORDER BY score DESC
LIMIT 5;