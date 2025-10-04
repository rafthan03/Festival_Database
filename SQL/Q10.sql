/*Πολλοί καλλιτέχνες καλύπτουν περισσότερα από ένα μουσικά είδη. Ανάμεσα σε ζεύγη πεδίων (π.χ. ροκ, τζαζ) που
είναι κοινά στους καλλιτέχνες, βρείτε τα 3 κορυφαία (top-3) ζεύγη που εμφανίστηκαν σε φεστιβάλ*/
SELECT 
genre1, genre2, COUNT(*) AS appearances
FROM (
SELECT DISTINCT pg1.genre AS genre1, pg2.genre AS genre2, e.event_id
FROM PerformerGenre pg1
JOIN PerformerGenre pg2 ON pg1.performer_id = pg2.performer_id AND pg1.genre < pg2.genre
JOIN PERFORMANCE pf ON pf.performer_id = pg1.performer_id
JOIN EVENT e ON e.event_id = pf.event_id
) AS GenrePairsWithFestival
GROUP BY genre1, genre2
ORDER BY appearances DESC
LIMIT 3;
