/*Βρείτε ποια μουσικά είδη είχαν τον ίδιο αριθμό εμφανίσεων σε δύο συνεχόμενες χρονιές με τουλάχιστον 3
εμφανίσεις ανά έτος*/

WITH genre_year AS (
SELECT g.genre,f.year,COUNT(*) AS appearances
FROM performance pe
JOIN event e ON pe.event_id = e.event_id
JOIN festival f ON e.festival_id = f.festival_id
JOIN PerformerGenre g ON pe.performer_id = g.performer_id
GROUP BY g.genre, f.year
HAVING COUNT(*) >= 3)

SELECT g1.genre, g1.year AS year1, g2.year AS year2, g1.appearances
FROM genre_year g1
JOIN genre_year g2 ON g1.genre=g2.genre
AND g1.year+1=g2.year AND g1.appearances=g2.appearances;
