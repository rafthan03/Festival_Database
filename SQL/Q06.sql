/*Για κάποιο επισκέπτη, βρείτε τις παραστάσεις που έχει παρακολουθήσει και το μέσο όρο της αξιολόγησης του,
ανά παράσταση.*/

Select v.first_name,v.last_name, e.event_id,AVG(r.overall_experience) as event_Average
FROM rating r
JOIN Ticket t on r.ticket_id=t.ticket_id
JOIN visitor v ON t.visitor_id=v.visitor_id
JOIN Event e ON e.event_id=t.event_id
WHERE t.visitor_id=50
GROUP BY e.event_id;
select * from information_schema.optimizer_trace limit 1\G
