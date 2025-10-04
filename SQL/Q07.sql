--Βρείτε ποιο φεστιβάλ είχε τον χαμηλότερο μέσο όρο εμπειρίας τεχνικού προσωπικού
SELECT f.festival_id, AVG(
CASE s.experience_level
WHEN 'Αρχάριος' THEN 1.0
WHEN 'Μέσος' THEN 2.0
WHEN 'Έμπειρος' THEN 3.0 
WHEN 'Πολύ έμπειρος' THEN 4.0 
ELSE NULL
END) AS avg_experience_level
FROM staff s
JOIN eventstaff es ON es.staff_id = s.staff_id
JOIN event e ON e.event_id = es.event_id
JOIN festival f ON f.festival_id = e.festival_id
WHERE s.staff_type='Τεχνικός'
GROUP by f.festival_id
ORDER BY avg_experience_level ASC
LIMIT 1;