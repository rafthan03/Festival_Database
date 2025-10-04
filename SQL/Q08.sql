--Βρείτε το προσωπικό υποστήριξης που δεν έχει προγραμματισμένη εργασία σε συγκεκριμένη ημερομηνία
SELECT S.name
FROM STAFF S
WHERE S.staff_type = 'Βοηθητικό'
EXCEPT (
SELECT S.name
FROM STAFF S
JOIN EVENTSTAFF es ON es.staff_id = S.staff_id
JOIN EVENT e ON e.event_id = es.event_id
WHERE e.event_date = '2021-08-05'
);