/*Βρείτε όλους τους καλλιτέχνες που ανήκουν σε ένα συγκεκριμένο μουσικό είδος με ένδειξη αν συμμετείχαν σε
εκδηλώσεις του φεστιβάλ για ενα συγκεκριμένο έτος */
SELECT p.name,f.year,
CASE WHEN f.year = 2019 THEN 'ΥES' ELSE 'NO' END AS apearance_2024
FROM Performer p
JOIN PerformerGenre pg ON p.performer_id = pg.performer_id
JOIN Performance pe ON pe.performer_id = p.performer_id
JOIN Event e ON e.event_id = pe.event_id
JOIN Festival f ON f.festival_id = e.festival_id
WHERE pg.genre = 'POP'
ORDER BY f.year;