/*Βρείτε ποιοι επισκέπτες έχουν παρακολουθήσει τον ίδιο αριθμό παραστάσεων σε διάστημα ενός έτους με
περισσότερες από 3 παρακολουθήσεις*/

WITH yearly_event_counts AS (
SELECT t.visitor_id, YEAR(e.event_date) AS year, COUNT(DISTINCT t.event_id) AS event_count
FROM Ticket AS t
JOIN Event  AS e ON e.event_id = t.event_id
GROUP BY t.visitor_id, YEAR(e.event_date)
HAVING COUNT(DISTINCT t.event_id) > 3
)
SELECT y.year, y.event_count,
GROUP_CONCAT( CONCAT(v.first_name, ' ', v.last_name) ORDER BY v.last_name, v.first_name SEPARATOR ', ') AS visitor_list
FROM yearly_event_counts y
JOIN Visitor v ON v.visitor_id=y.visitor_id
GROUP BY y.year, y.event_count
HAVING COUNT(*) > 1  
ORDER BY y.year;