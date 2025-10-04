--Βρείτε τους νέους καλλιτέχνες (ηλικία < 30 ετών) που έχουν τις περισσότερες συμμετοχές σε φεστιβάλ
SELECT p.name,TIMESTAMPDIFF(YEAR, a.birthdate,CURRENT_DATE) AS age, COUNT(*) AS part
FROM artist a
JOIN performer p ON a.performer_id = p.performer_id
JOIN performance pe ON pe.performer_id = p.performer_id
WHERE TIMESTAMPDIFF(YEAR, a.birthdate, CURRENT_DATE) < 30
GROUP BY p.name, age
UNION(
Select p.name,TIMESTAMPDIFF(YEAR,b.formation_date,CURRENT_DATE) As age,count(*) as part
FROM band b
JOIN performer p ON b.performer_id=p.performer_id
JOIN performance pe ON pe.performer_id=p.performer_id
WHERE TIMESTAMPDIFF(YEAR, b.formation_date, CURRENT_DATE) < 30
GROUP BY p.name, age)
ORDER by part DESC;