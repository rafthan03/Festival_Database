/*Για κάποιο καλλιτέχνη, βρείτε το μέσο όρο αξιολογήσεων (Ερμηνεία καλλιτεχνών) και εμφάνιση (Συνολική
εντύπωση).*/
SELECT p.performer_id,p.name AS artist_name,AVG(r.interpretation) AS avg_interpretation,AVG(r.overall_experience) AS avg_overall_experience
FROM Performer p
JOIN Performance pf ON pf.performer_id = p.performer_id
JOIN Rating r ON r.performance_id = pf.performance_id
WHERE p.performer_id=1
GROUP BY p.performer_id, p.name;
select * from information_schema.optimizer_trace limit 1\G

