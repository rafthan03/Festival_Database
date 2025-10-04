--Βρείτε τους καλλιτέχνες που έχουν συμμετάσχει σε φεστιβάλ σε τουλάχιστον 3 διαφορετικές ηπείρους

SELECT p.name, COUNT(DISTINCT l.continent) AS appearances
FROM location l
JOIN festival f ON f.location_id = l.location_id
JOIN event e ON e.festival_id = f.festival_id
JOIN performance pe ON pe.event_id = e.event_id
JOIN performer p ON p.performer_id = pe.performer_id
GROUP BY p.performer_id
HAVING COUNT(DISTINCT l.continent) >= 3;