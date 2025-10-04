/*Βρείτε όλους τους καλλιτέχνες που συμμετείχαν τουλάχιστον 5 λιγότερες φορές από τον καλλιτέχνη με τις
περισσότερες συμμετοχές σε φεστιβάλ.*/

SELECT pe.name ,COUNT(*) AS appearances
FROM performance p
JOIN performer pe ON pe.performer_id= p.performer_id
GROUP BY p.performer_id
HAVING COUNT(*) <= (
SELECT MAX(cnt)
FROM (
SELECT COUNT(*) AS cnt
FROM performance 
GROUP BY performer_id) AS max_counts)- 5
ORDER BY appearances DESC;