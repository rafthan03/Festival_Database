/* Βρείτε τα έσοδα του φεστιβάλ, ανά έτος από την πώληση εισιτηρίων, λαμβάνοντας υπόψη όλες τις κατηγορίες
και παρέχοντας ανάλυση ανά είδος πληρωμής*/
SELECT f.year AS festival_year,SUM(t.cost) AS total,
SUM(CASE WHEN t.payment_method='Credit Card' THEN t.cost ELSE 0 END) AS Credit_card,
SUM(CASE WHEN t.payment_method='Debit Card'  THEN t.cost ELSE 0 END) AS Debit_card,
SUM(CASE WHEN t.payment_method='Bank Account' THEN t.cost ELSE 0 END) AS Bank_Account
FROM TICKET t
JOIN EVENT e ON t.event_id=e.event_id
JOIN FESTIVAL f ON e.festival_id=f.festival_id
GROUP BY f.year
ORDER BY f.year;