/*Βρείτε ποιοι καλλιτέχνες έχουν εμφανιστεί ως warm up περισσότερες από 2 φορές στο ίδιο φεστιβάλ*/
SELECT p.name,f.festival_id,COUNT(*) AS warmup_count
FROM performer p
JOIN performance pe ON p.performer_id = pe.performer_id
JOIN event e ON pe.event_id = e.event_id
JOIN festival f ON e.festival_id = f.festival_id
WHERE pe.performance_type = 'Warm up'
GROUP BY f.festival_id,p.name
HAVING count(*)>2;
