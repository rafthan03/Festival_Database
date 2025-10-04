/*Βρείτε το προσωπικό που απαιτείται για κάθε ημέρα του φεστιβάλ, παρέχοντας ανάλυση ανά κατηγορία (τεχνικό
προσωπικό ασφαλείας, βοηθητικό προσωπικό)*/
Select sum(CEIL(s.max_capacity*0.02)) as Βοηθητικό, sum(CEIL(s.max_capacity*0.05)) as Ασφάλεια,sum(CEIL(s.max_capacity*0.01)) as Τεχνικό, f.festival_id, e.event_date as ημέρα
FROM stage s
JOIN event e ON s.stage_id=e.stage_id
JOIN festival f ON f.festival_id=e.festival_id
Group by e.event_date;