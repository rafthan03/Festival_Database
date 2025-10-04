DROP DATABASE IF EXISTS FESTIVALDB;
CREATE DATABASE FESTIVALDB;
USE FESTIVALDB;

CREATE TABLE Continent(
continent VARCHAR(150) NOT NULL,
PRIMARY KEY(continent)
);
INSERT INTO continent (continent) VALUES
('Europe'),('Asia'),('North America'),('South America'),('Africa'),('Australia'),('Antarctica');
  
CREATE TABLE LOCATION(
location_id INT AUTO_INCREMENT NOT NULL,
address VARCHAR(255) NOT NULL,
city VARCHAR(150) NOT NULL,
country VARCHAR(150) NOT NULL,
continent VARCHAR(150) NOT NULL,
latitude DECIMAL(10,8) NOT NULL,
longitude DECIMAL(11,8) NOT NULL,
PRIMARY KEY (location_id),
FOREIGN KEY (continent) REFERENCES Continent(continent) ON DELETE CASCADE);



CREATE TABLE FESTIVAL(
festival_id INT AUTO_INCREMENT NOT NULL,
location_id INT NOT NULL,
year INT NOT NULL,
start_date DATE NOT NULL,
end_date DATE NOT NULL,
CHECK (end_date >= start_date),
unique(location_id),
unique(year),
PRIMARY KEY (festival_id),
FOREIGN KEY (location_id) REFERENCES LOCATION(location_id) ON DELETE CASCADE);


CREATE TABLE STAGE(
stage_id INT AUTO_INCREMENT NOT NULL,
stage_name VARCHAR(150) NOT NULL,
description TEXT NOT NULL ,
max_capacity INT NOT NULL,
PRIMARY KEY (stage_id));

CREATE TABLE STAGEEQUIPMENT(
stage_id INT NOT NULL,
equipment_type VARCHAR(150) NOT NULL,
quantity INT NOT NULL,
PRIMARY KEY (stage_id, equipment_type),
FOREIGN KEY (stage_id) REFERENCES STAGE(stage_id) ON DELETE CASCADE);
      
CREATE TABLE EVENT(
event_id INT AUTO_INCREMENT NOT NULL,
festival_id INT NOT NULL,
stage_id INT NOT NULL,
event_date DATE NOT NULL,
start_time TIME NOT NULL,
end_time TIME NOT NULL,
full_ticket BOOLEAN NOT NULL DEFAULT FALSE,
Check (end_time > start_time),
PRIMARY KEY (event_id),
FOREIGN KEY (festival_id) REFERENCES FESTIVAL(festival_id) ON DELETE CASCADE,
FOREIGN KEY (stage_id) REFERENCES STAGE(stage_id) ON DELETE CASCADE);

CREATE TABLE EXPERIENCE_LEVEL (
level VARCHAR(150) NOT NULL,
PRIMARY KEY (level));
INSERT INTO EXPERIENCE_LEVEL (level) VALUES
('Eιδικευόμενος'),('Αρχάριος'),('Μέσος'),('Έμπειρος'),('Πολύ έμπειρος');

CREATE TABLE STAFF_TYPE (
type VARCHAR(20) NOT NULL,
PRIMARY KEY (type));
INSERT INTO STAFF_TYPE (type) VALUES
('Τεχνικός'),('Ασφαλείας'),('Βοηθητικό');

CREATE TABLE Staff(
staff_id INT AUTO_INCREMENT NOT NULL,
name VARCHAR(150) NOT NULL,
age INT NOT NULL,
experience_level VARCHAR(150) NOT NULL,
staff_type VARCHAR(20) NOT NULL,
speciality VARCHAR(150),
PRIMARY KEY (staff_id),
FOREIGN KEY (experience_level) REFERENCES EXPERIENCE_LEVEL(level),
FOREIGN KEY (staff_type) REFERENCES STAFF_TYPE(type));

CREATE TABLE EventStaff(
event_id INT NOT NULL,
staff_id INT NOT NULL,
PRIMARY KEY (event_id, staff_id),
FOREIGN KEY (event_id) REFERENCES EVENT(event_id) ,
FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) ON DELETE CASCADE);

CREATE TABLE performer_type(
type varchar(150) NOT NULL,
PRIMARY KEY (type));
INSERT INTO performer_type(type) VALUES
('Artist'),('Band');

CREATE TABLE Performer (
performer_id INT AUTO_INCREMENT NOT NULL,
name VARCHAR(100) NOT NULL,
website VARCHAR(255),
instagram VARCHAR(255),
performer_type VARCHAR(150) NOT NULL,
PRIMARY KEY (performer_id),
FOREIGN KEY (performer_type) REFERENCES performer_type(type));

CREATE TABLE Artist (
performer_id INT NOT NULL,
alias VARCHAR(150),
birthdate DATE NOT NULL,
PRIMARY KEY (performer_id),
FOREIGN KEY (performer_id) REFERENCES Performer(performer_id) ON DELETE CASCADE);

CREATE TABLE Band (
performer_id INT NOT NULL,
formation_date DATE NOT NULL,
PRIMARY KEY (performer_id),
FOREIGN KEY (performer_id) REFERENCES Performer(performer_id) ON DELETE CASCADE
);

CREATE TABLE Membership (
band_id INT NOT NULL,
artist_id INT NOT NULL,
PRIMARY KEY (band_id, artist_id),
FOREIGN KEY (band_id) REFERENCES Band(performer_id) ON DELETE CASCADE,
 FOREIGN KEY (artist_id) REFERENCES Artist(performer_id) ON DELETE CASCADE
);

CREATE TABLE GENRE(
genre VARCHAR(100) NOT NULL,
PRIMARY KEY(genre),
UNIQUE(genre));
INSERT INTO GENRE (genre) VALUES ('Rock'), ('Pop'), ('Jazz'), ('Blues'), ('Electronic'), ('Hip-Hop'), ('Latin');

CREATE TABLE Subgenre (
subgenre VARCHAR(100) NOT NULL,
PRIMARY KEY(subgenre),
UNIQUE(subgenre));
INSERT INTO Subgenre (subgenre) VALUES 
('Hard Rock'), ('Alternative Rock'), ('Punk Rock'), ('Progressive Rock'), ('Indie Rock'),
('Dance Pop'), ('Teen Pop'), ('Electropop'), ('Euro Pop'), ('Synth-Pop'),
('Bebop'), ('Smooth Jazz'), ('Cool Jazz'), ('Fusion'), ('Latin Jazz'),
('Electric Blues'), ('Chicago Blues'), ('Delta Blues'), ('Modern Blues'), ('Country Blues'),
('House'), ('Techno'), ('Trance'), ('Drum and Bass'), ('Electro Pop'),
('Rap'), ('Trap'), ('Boom Bap'), ('G-Funk'), ('Conscious Rap'),
('Latin Pop'), ('Bachata'), ('Reggaeton'), ('Salsa'), ('Merengue');

CREATE TABLE PerformerGenre (
performer_id INT NOT NULL,
genre VARCHAR(100) NOT NULL,
PRIMARY KEY (performer_id, genre),
FOREIGN KEY (performer_id) REFERENCES Performer(performer_id) ON DELETE CASCADE,
FOREIGN KEY (genre) REFERENCES Genre(genre) ON DELETE CASCADE);
    
CREATE TABLE PerformerSubgenre (
performer_id INT NOT NULL,
subgenre VARCHAR(100) NOT NULL,
PRIMARY KEY (performer_id, subgenre),
FOREIGN KEY (performer_id) REFERENCES Performer(performer_id) ON DELETE CASCADE,
FOREIGN KEY (subgenre) REFERENCES Subgenre(subgenre) ON DELETE CASCADE);

CREATE TABLE PERFORMANCE_TYPE (
type2 VARCHAR(150) NOT NULL,
PRIMARY KEY (type2));
INSERT INTO PERFORMANCE_TYPE (type2) VALUES
('Warm up'),('Headline'),('Special Guest'),('Support Act');

CREATE TABLE Performance (
performance_id INT AUTO_INCREMENT NOT NULL,
event_id INT NOT NULL,
performer_id INT NOT NULL,
performance_type VARCHAR(150) NOT NULL,
start_time TIME NOT NULL,
end_time TIME NOT NULL,
FOREIGN KEY (performance_type) REFERENCES PERFORMANCE_TYPE(type2),
CHECK (end_time > start_time),
CHECK (TIMEDIFF(end_time, start_time) <= '03:00:00'),
PRIMARY KEY (performance_id),
FOREIGN KEY (event_id) REFERENCES EVENT(event_id) ON DELETE CASCADE,
FOREIGN KEY (performer_id) REFERENCES Performer(performer_id));


CREATE TABLE Visitor(
visitor_id INT AUTO_INCREMENT NOT NULL,
first_name VARCHAR(150) NOT NULL,
last_name VARCHAR(150) NOT NULL,
email VARCHAR(150) NOT NULL,
phone_number VARCHAR(150) NOT NULL,
age INT NOT NULL,
PRIMARY KEY (visitor_id));

CREATE TABLE TICKET_CATEGORY (
category VARCHAR(150) NOT NULL,
PRIMARY KEY (category));
INSERT INTO TICKET_CATEGORY (category) VALUES
('VIP'),('General'),('backstage');

CREATE TABLE TICKET_PAYMENT_METHOD (
method VARCHAR(150) NOT NULL,
PRIMARY KEY (method));
INSERT INTO TICKET_PAYMENT_METHOD (method) VALUES('Credit Card'),('Debit Card'),('Bank Account');
   

CREATE TABLE Ticket(
ticket_id INT AUTO_INCREMENT NOT NULL,
visitor_id INT NOT NULL,
event_id INT NOT NULL,
category VARCHAR(150) NOT NULL,
cost DECIMAL(10,2) NOT NULL,
CHECK(cost>0) ,
payment_method VARCHAR(150) NOT NULL,
purchase_date DATE NOT NULL,
ean BIGINT NOT NULL,
activated BOOLEAN  NOT NULL DEFAULT FALSE,
CHECK(ean BETWEEN 1000000000000 AND 9999999999999),
UNIQUE(ean),
FOREIGN KEY (visitor_id) REFERENCES VISITOR(visitor_id) ON DELETE CASCADE,
FOREIGN KEY (event_id) REFERENCES EVENT(event_id) ON DELETE CASCADE,
PRIMARY KEY (ticket_id),
FOREIGN KEY (category) REFERENCES TICKET_CATEGORY(category),
FOREIGN KEY (payment_method) REFERENCES TICKET_PAYMENT_METHOD(method),
UNIQUE (visitor_id, event_id));


Create table ResaleInterest(
interest VARCHAR(150) NOT NULL,
PRIMARY KEY (interest));
Insert INTO ResaleInterest (interest) VALUES
('Buy'),('Sell');


CREATE TABLE Seller (
seller_id INT AUTO_INCREMENT NOT NULL,
ticket_id INT NOT NULL,
PRIMARY KEY (seller_id),
UNIQUE(ticket_id),
FOREIGN KEY (ticket_id) REFERENCES Ticket(ticket_id) ON DELETE CASCADE);

CREATE TABLE Buyer (
buyer_id INT AUTO_INCREMENT NOT NULL,
visitor_id INT NOT NULL,
ticket_id INT NULL,
event_id INT NULL,
category   VARCHAR(150) NULL,
CHECK((ticket_id IS NOT NULL AND event_id  IS NULL AND category IS NULL)
OR(ticket_id IS NULL AND event_id IS NOT NULL AND category IS NOT NULL)),
PRIMARY KEY (buyer_id),
FOREIGN KEY (ticket_id)REFERENCES Ticket(ticket_id) ON DELETE CASCADE,
FOREIGN KEY (event_id) REFERENCES Event(event_id) ON DELETE CASCADE,
FOREIGN KEY (category) REFERENCES TICKET_CATEGORY(category) );

CREATE TABLE ResaleQueue (
resale_id INT AUTO_INCREMENT NOT NULL,
seller_id INT NULL,
buyer_id INT NULL,
interest VARCHAR(150) NOT NULL,
status VARCHAR(150) NOT NULL DEFAULT 'Available',
listing_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
CHECK((interest='Sell' AND seller_id IS NOT NULL AND buyer_id IS NULL)
OR(interest='Buy'AND buyer_id IS NOT NULL AND seller_id IS NULL)),
PRIMARY KEY (resale_id),
FOREIGN KEY (seller_id) REFERENCES Seller(seller_id)  ON DELETE CASCADE,
FOREIGN KEY (buyer_id) REFERENCES Buyer(buyer_id)    ON DELETE CASCADE,
FOREIGN KEY (interest) REFERENCES ResaleInterest(interest));

CREATE TABLE Rating(
rating_id INT AUTO_INCREMENT NOT NULL,
ticket_id INT NOT NULL,
performance_id INT NOT NULL,
sound_light INT NOT NULL,CHECK(sound_light BETWEEN 1 AND 5),
interpretation  INT NOT NULL,CHECK(interpretation  BETWEEN 1 AND 5),
stage_presesce INT NOT NULL,CHECK(stage_presesce BETWEEN 1 AND 5),
organization INT NOT NULL,CHECK(organization BETWEEN 1 AND 5),
overall_experience INT NOT NULL,CHECK(overall_experience BETWEEN 1 AND 5),
UNIQUE(ticket_id, performance_id),
PRIMARY KEY (rating_id),
FOREIGN KEY (ticket_id) REFERENCES TICKET(ticket_id) ON DELETE CASCADE,
FOREIGN KEY (performance_id) REFERENCES Performance(performance_id) ON DELETE CASCADE);
  
Create TABLE Image(
image_id INT AUTO_INCREMENT NOT NULL,
image_path VARCHAR(255) NOT NULL,
description TEXT NOT NULL,
PRIMARY KEY (image_id));

Create TABLE Festival_Image(
festival_id INT NOT NULL,
image_id INT NOT NULL,
PRIMARY KEY (festival_id, image_id),
FOREIGN KEY (festival_id) REFERENCES FESTIVAL(festival_id) ON DELETE CASCADE,
FOREIGN KEY (image_id) REFERENCES IMAGE(image_id) ON DELETE CASCADE);

CREATE TABLE STAGE_IMAGE(
stage_id INT NOT NULL,
image_id INT NOT NULL,
PRIMARY KEY (stage_id, image_id),
FOREIGN KEY (stage_id) REFERENCES STAGE(stage_id) ON DELETE CASCADE,
FOREIGN KEY (image_id) REFERENCES IMAGE(image_id) ON DELETE CASCADE);

CREATE TABLE PERFORMANCE_IMAGE(
performance_id INT NOT NULL,
image_id INT NOT NULL,
PRIMARY KEY (performance_id, image_id),
fOREIGN KEY (performance_id) REFERENCES PERFORMANCE(performance_id) ON DELETE CASCADE,
FOREIGN KEY (image_id) REFERENCES IMAGE(image_id) ON DELETE CASCADE);

CREATE TABLE PERFORMER_IMAGE (
performer_id INT NOT NULL,
image_id INT NOT NULL,
PRIMARY KEY (performer_id, image_id),
FOREIGN KEY (performer_id) REFERENCES performer(performer_id) ON DELETE CASCADE,
FOREIGN KEY (image_id) REFERENCES IMAGE(image_id) ON DELETE CASCADE);

CREATE TABLE STAGEEQUIPMENT_IMAGE(
stage_id INT NOT NULL,
equipment_type VARCHAR(150) NOT NULL,
image_id INT NOT NULL,
PRIMARY KEY (stage_id, image_id,equipment_type),
FOREIGN KEY (stage_id) REFERENCES STAGE(stage_id) ON DELETE CASCADE,
FOREIGN KEY (image_id) REFERENCES IMAGE(image_id) ON DELETE CASCADE);


----TRIGGERS------------------------------------
--Trigger για να μην εχουμε 2 event την ιδια χρονικη στιγμή 
DELIMITER $$
Create Trigger insert_event_overlap
BEFORE INSERT ON EVENT
FOR EACH ROW
BEGIN
IF EXISTS(
SELECT * FROM EVENT
WHERE festival_id = NEW.festival_id and stage_id = NEW.stage_id and event_date=new.event_date
AND (
new.start_time BETWEEN start_time AND end_time OR new.end_time BETWEEN start_time AND end_time
OR start_time BETWEEN NEW.start_time AND NEW.end_time OR end_time BETWEEN NEW.start_time AND NEW.end_time))
THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Υπάρχει ήδη προγραμματισμένη παράσταση σε αυτήν τη σκηνή.';
END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER update_event_overlap
BEFORE UPDATE ON EVENT
FOR EACH ROW
BEGIN
IF EXISTS(
SELECT * FROM EVENT
WHERE festival_id = NEW.festival_id and stage_id = NEW.stage_id and event_date=new.event_date  AND event_id<>NEW.event_id
AND (
new.start_time BETWEEN start_time AND end_time OR new.end_time BETWEEN start_time AND end_time
OR start_time BETWEEN NEW.start_time AND NEW.end_time OR end_time BETWEEN NEW.start_time AND NEW.end_time))
THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Υπάρχει ήδη προγραμματισμένη παράσταση σε αυτήν τη σκηνή.';
END IF;
END$$
DELIMITER ;

--TRIGGER για να μην διαγράψουμε φεστιβάλ ή παράσταση
DELIMITER $$
CREATE TRIGGER prevent_delete_festival
BEFORE DELETE ON FESTIVAL
FOR EACH ROW
BEGIN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Δεν επιτρέπεται η διαγραφή του φεστιβάλ';
END$$

Create trigger prevent_delete_event
Before DELETE ON event
FOR EACH ROW
BEGIN
Signal SQLSTATE '45000'
SET MESSAGE_TEXT = 'Δεν επιτρέπεται η διαγραφή της παράστασης';
END$$

DELIMITER ;   

--Trigger για τον έλεγχο των διαλειμμάτων
DELIMITER $$
CREATE TRIGGER uptate_check_breaks
BEFORE UPDATE ON Performance
FOR EACH ROW
BEGIN
DECLARE ending TIME;


SELECT end_time Into ending
FROM Performance
WHERE event_id = NEW.event_id AND performance_id <> NEW.performance_id 
ORDER BY end_time DESC
LIMIT 1;

IF ending IS NOT NULL THEN
IF TIMEDIFF(NEW.start_time,ending)<'00:05:00'OR TIMEDIFF(NEW.start_time,ending)>'00:30:00' 
THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Το διάλειμμα μεταξύ παραστάσεων πρέπει να είναι μεταξύ 5 και 30 λεπτών.';
END IF;
END IF;
END$$
DELIMITER ;


--Trigger για τον έλεγχο των διαλειμμάτων
DELIMITER $$
CREATE TRIGGER insert_check_breaks
BEFORE INSERT ON Performance
FOR EACH ROW
BEGIN
DECLARE ending TIME;

SELECT end_time Into ending
FROM Performance
WHERE event_id = NEW.event_id
ORDER BY end_time DESC
LIMIT 1;

IF ending IS NOT NULL THEN
IF TIMEDIFF(NEW.start_time,ending) < '00:05:00'OR TIMEDIFF(NEW.start_time,ending) > '00:30:00' 
THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Το διάλειμμα μεταξύ παραστάσεων πρέπει να είναι μεταξύ 5 και 30 λεπτών.';
END IF;
END IF;
END$$
DELIMITER ;

CREATE VIEW v_band_members AS
SELECT
B.performer_id AS band_id,
P.name AS band_name,
IFNULL(GROUP_CONCAT(PA.name SEPARATOR ', '), 'Δεν υπάρχουν μέλη') AS member_list
FROM Band B
JOIN Performer P ON B.performer_id = P.performer_id
LEFT JOIN Membership BM ON BM.band_id = B.performer_id
LEFT JOIN Artist A ON A.performer_id = BM.artist_id
LEFT JOIN Performer PA ON PA.performer_id = A.performer_id  
GROUP BY B.performer_id, P.name;

--Έλεγχος αν το artist_id ανήκει σε σόλο καλλιτέχνη και το band_id σε συγκρότημα
DELIMITER $$
CREATE TRIGGER Membership
BEFORE INSERT ON Membership
FOR EACH ROW
BEGIN    
IF (SELECT performer_type FROM Performer WHERE performer_id = NEW.artist_id) = 'Band' THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Το solo_id πρέπει να αντιστοιχεί σε σόλο καλλιτέχνη.';
END IF;

IF (SELECT performer_type FROM Performer WHERE performer_id = NEW.band_id) = 'Artist' THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Το band_id πρέπει να αντιστοιχεί σε συγκρότημα.';
END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE validate_performance_schedule(
IN new_performer_id INT,
IN new_event_id INT,
IN new_start TIME,
IN new_end TIME,
IN exclude_id INT -- Προκειμένου να αγνοήσουμε την τρέχουσα εγγραφή κατά το Uptade
)
BEGIN
DECLARE perftype VARCHAR(150);
DECLARE edate DATE;

SELECT performer_type INTO perftype
FROM Performer
WHERE performer_id = new_performer_id;

SELECT event_date INTO edate FROM Event WHERE event_id = new_event_id;

-- Έλεγχος αν ο performer έχει ήδη εμφάνιση στην εκδήλωση
IF EXISTS (
SELECT 1
FROM Performance p
JOIN Event e ON p.event_id = e.event_id
WHERE p.performer_id = new_performer_id
AND e.event_date = edate AND (exclude_id IS NULL OR p.performance_id != exclude_id)
AND ( new_start BETWEEN p.start_time AND p.end_time OR new_end BETWEEN p.start_time AND p.end_time
OR p.start_time BETWEEN new_start AND new_end OR p.end_time BETWEEN new_start AND new_end)) 
THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Ο performer έχει ήδη εμφάνιση σε αυτή τη χρονική ζώνη.';
END IF;

-- Αν είναι band, γίνεται μέλος και ξεχωριστά για τα μέλη
IF perftype = 'Band' THEN
IF EXISTS (
  SELECT 1
FROM Membership m
JOIN Performance p2 ON p2.performer_id = m.artist_id
JOIN Event e2 ON e2.event_id = p2.event_id
WHERE m.band_id = new_performer_id AND e2.event_date = edate
AND (exclude_id IS NULL OR p2.performance_id != exclude_id)
AND ( new_start BETWEEN p2.start_time AND p2.end_time OR new_end BETWEEN p2.start_time AND p2.end_time
OR p2.start_time BETWEEN new_start AND new_end OR p2.end_time BETWEEN new_start AND new_end)) 
THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Μέλος της μπάντας έχει ήδη εμφάνιση σε αυτή τη χρονική ζώνη.';
END IF;
END IF;
END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER validate_performance_insert
BEFORE INSERT ON Performance
FOR EACH ROW
BEGIN
CALL validate_performance_schedule(NEW.performer_id,NEW.event_id,NEW.start_time,NEW.end_time,NULL);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER validate_performance_update
BEFORE UPDATE ON Performance
FOR EACH ROW
BEGIN
CALL validate_performance_schedule(NEW.performer_id,NEW.event_id,NEW.start_time,NEW.end_time,NEW.performance_id);
END$$
DELIMITER ;

--Trigger για να ενημερωθεί η στήλη full_ticket στην εκδήλωση
DELIMITER $$
CREATE TRIGGER ticket_after_insert
AFTER INSERT ON Ticket
FOR EACH ROW
BEGIN
DECLARE sold      INT;
DECLARE capacity  INT;
SELECT COUNT(*) INTO sold
FROM Ticket WHERE event_id = NEW.event_id;

SELECT s.max_capacity  INTO capacity
FROM EVENT  e JOIN STAGE  s ON s.stage_id = e.stage_id
WHERE e.event_id = NEW.event_id;

IF sold >= capacity THEN
UPDATE EVENT
SET full_ticket = TRUE WHERE event_id = NEW.event_id;
END IF;
END$$
DELIMITER ;


--Trigger για τον έλεγχο της χωρητικότητας της παράστασης και των VIO
DELIMITER $$
Create Trigger insert_ticket_capacity
Before INSERT ON Ticket
FOR EACH ROW 
BEGIN
IF (Select count(*) FROM Ticket where event_id = new.event_id )>=
(Select max_capacity From Stage JOIN EVENT ON Stage.stage_id = Event.stage_id where event_id = new.event_id)
THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT ='Έχει συμπληρωθεί η χωριτηκότητα της παράστασης';
END IF;

IF(new.category='VIP') THEN
IF (select count(*) from Ticket Where event_id=new.event_id  and category='VIP')>=
0.1*(Select max_capacity From Stage JOIN Event ON Stage.stage_id=Event.stage_id WHERE  event_id = new.event_id)
THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Έχει συμπληρωθεί η χωριτηκότητα των VIP';
END IF;
END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER uptate_ticket_capacity
BEFORE UPDATE ON Ticket
FOR EACH ROW 
BEGIN

IF (NEW.event_id <> OLD.event_id) OR (NEW.category  <> OLD.category) THEN -- Η αλλαγή του event_id ή category μπορούν να προκαλέσουν προβλήματα χωρητικότητας

IF (Select count(*) FROM Ticket where event_id = new.event_id )>=
(Select max_capacity From Stage JOIN EVENT ON Stage.stage_id = Event.stage_id where event_id = new.event_id)
THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Έχει συμπληρωθεί η χωριτηκότητα της παράστασης';
END IF;

IF(new.category='VIP') AND (select count(*) from Ticket Where event_id=new.event_id  and category='VIP')>=
0.1*(Select max_capacity From Stage JOIN Event ON Stage.stage_id=Event.stage_id WHERE  event_id = new.event_id)
THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Έχει συμπληρωθεί η χωριτηκότητα των VIP';
END IF;
END IF;

END$$
DELIMITER ;

CREATE VIEW v_event_staff_summary AS
SELECT 
e.event_id,
s.stage_name,
s.max_capacity,
CEILING(s.max_capacity * 0.05) AS required_security,
CEILING(s.max_capacity * 0.02) AS required_helper,

COUNT(CASE WHEN st.staff_type = 'Ασφαλείας' THEN 1 END) AS total_security,
COUNT(CASE WHEN st.staff_type = 'Βοηθητικό' THEN 1 END) AS total_helper,

CASE 
WHEN COUNT(CASE WHEN st.staff_type = 'Ασφαλείας' THEN 1 END) < CEILING(s.max_capacity * 0.05) 
THEN 'Ανεπαρκές Ασφαλείας'
ELSE 'Επαρκές Ασφαλείας'
END AS security_status,

CASE 
WHEN COUNT(CASE WHEN st.staff_type = 'Βοηθητικό' THEN 1 END) < CEILING(s.max_capacity * 0.02) 
THEN 'Ανεπαρκές Βοηθητικού'
ELSE 'Επαρκές Βοηθητικού'
END AS helper_status

FROM EVENT e
JOIN STAGE s ON e.stage_id = s.stage_id
LEFT JOIN EVENTSTAFF es ON e.event_id = es.event_id
LEFT JOIN STAFF st ON st.staff_id = es.staff_id
GROUP BY e.event_id, s.stage_name, s.max_capacity;


---------------------------------------------------------------------------------------------------------------
DELIMITER $$
-- Εισαγωγή του απαραίτητπυ προσωπικού σε ενα event
CREATE PROCEDURE InsertEventStaff(IN eventId INT, IN capacity INT)
BEGIN
-- Υπολογισμός απαιτούμενου προσωπικού
DECLARE security   INT DEFAULT CEIL(0.05* capacity);  -- 5% Ασφαλείας
DECLARE helper  INT DEFAULT CEIL(0.02 * capacity);  -- 2% Βοηθητικό
DECLARE technician  INT DEFAULT CEIL(0.01 * capacity);  -- 1% Τεχνικός
DECLARE i INT DEFAULT 0;

-- 1) Εισαγωγή προσωπικού Ασφαλείας
WHILE i < security DO
INSERT INTO EventStaff (event_id, staff_id)
SELECT eventId, staff_id
FROM Staff WHERE staff_type = 'Ασφαλείας'
AND staff_id NOT IN (SELECT staff_id FROM EventStaff WHERE event_id = eventId)
ORDER BY RAND()
LIMIT 1;
SET i = i + 1;
END WHILE;

-- 2) Εισαγωγή προσωπικού Βοηθητικού
SET i = 0;
WHILE i < helper DO
INSERT INTO EventStaff (event_id, staff_id)
SELECT eventId, staff_id
FROM Staff WHERE staff_type = 'Βοηθητικό'
AND staff_id NOT IN (SELECT staff_id FROM EventStaff WHERE event_id = eventId)
ORDER BY RAND()
LIMIT 1;
SET i = i + 1;
END WHILE;

-- 3) Εισαγωγή προσωπικού Τεχνικού
SET i = 0;
WHILE i < technician DO
INSERT INTO EventStaff (event_id, staff_id)
SELECT eventId, staff_id
FROM Staff WHERE staff_type = 'Τεχνικός'
AND staff_id NOT IN (SELECT staff_id FROM EventStaff WHERE event_id = eventId)
ORDER BY RAND()
LIMIT 1;
SET i = i + 1;
END WHILE;
END$$
DELIMITER ;
-----------------------------------------------------------------------------------------------------


-- Καλεί την παραπάνω διαδικασία για όλα τα events
DELIMITER $$
CREATE PROCEDURE ProcessAllEvents()
BEGIN
DECLARE eventID INT;
DECLARE capacity INT;
DECLARE i INT DEFAULT 0;
DECLARE total INT;

SELECT COUNT(*) INTO total FROM EVENT;

While i<=total DO
Select e.event_id, s.max_capacity INTO eventID, capacity
FROM EVENT e 
JOIN Stage s ON e.stage_id = s.stage_id
ORDER BY e.event_id
LIMIT 1 OFFSET i;

CALL InsertEventStaff(eventID,capacity);
SET i = i + 1;
end while;
END$$ 
DELIMITER ;


-- Trigger για να ελεγξουμε εαν το εισιτηριο είναι ενεργοποιημένο
DELIMITER //
CREATE TRIGGER active_ticket
BEFORE INSERT ON Seller
FOR EACH ROW
BEGIN
IF (SELECT activated FROM Ticket WHERE ticket_id = NEW.ticket_id) = TRUE THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Το εισιτήριο είναι ήδη ενεργοποιημένο';
END IF;
END//
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE FIFO_resale(IN newresale_id INT )
BEGIN
DECLARE new_interest   VARCHAR(150);
DECLARE new_sellerid   INT;
DECLARE new_buyerid    INT;
DECLARE new_ticketid   INT;
DECLARE new_eventid    INT;
DECLARE new_category   VARCHAR(150);
DECLARE otherid        INT;


SELECT interest, seller_id, buyer_id INTO new_interest, new_sellerid, new_buyerid
FROM ResaleQueue WHERE resale_id = newresale_id;

-- Περίπτωση SELL
IF new_interest = 'Sell' THEN
SELECT t.event_id, t.category INTO new_eventid, new_category
FROM Seller s
JOIN Ticket t ON s.ticket_id = t.ticket_id
WHERE s.seller_id = new_sellerid;
-- Βρίσκουμε αγοραστή με το ίδιο event_id και category ( Δεν θεωρήσαμε οτι κάποιος αγοραστής θα μπορούσε να έχει βάλει από πριν ζητηση για το συγκεκριμένο εισιτήριο καθώς
-- δεν θα ήταν λογικό να γνωρίζει οτι το συγκεκριμένο εισιτήριο θα μπει στην ουρά μεταπώλησης)
SELECT rq2.resale_id
INTO otherid
FROM ResaleQueue rq2
JOIN Buyer b ON rq2.buyer_id = b.buyer_id
WHERE rq2.interest='Buy' AND rq2.status='Available' AND b.event_id=new_eventid AND b.category=new_category
ORDER BY rq2.listing_date
LIMIT 1;

-- Aν βρεθεί αγοραστής δηλώνονται και τα 2 ως Sold
IF otherid IS NOT NULL THEN
UPDATE ResaleQueue
SET status='Sold'
WHERE resale_id IN (newresale_id, otherid);

-- Ενημερώνεται ο πίνακας Ticket για το νέο ιδιοκτήτη του εισιτηρίου
UPDATE Ticket t
JOIN Seller s  ON s.ticket_id = t.ticket_id
JOIN ResaleQueue rs ON rs.seller_id = s.seller_id AND rs.resale_id=newresale_id
JOIN ResaleQueue rb ON rb.resale_id = otherid AND rb.interest= 'Buy'
JOIN Buyer b   ON b.buyer_id = rb.buyer_id
SET t.visitor_id = b.visitor_id;
END IF;
END IF;

-- Περίπτωση BUY
IF new_interest ='Buy' THEN
SELECT b.ticket_id, b.event_id, b.category
INTO new_ticketid, new_eventid, new_category
FROM Buyer b
WHERE b.buyer_id = new_buyerid;

-- Αναζητούμε πωλητη με ίδιο ticket ή ίδιο event+category
SELECT rq2.resale_id
INTO otherid
FROM ResaleQueue rq2
JOIN Seller s ON rq2.seller_id = s.seller_id
JOIN Ticket t ON s.ticket_id = t.ticket_id
WHERE rq2.interest='Sell' AND rq2.status='Available'
AND ((new_ticketid IS NOT NULL AND t.ticket_id = new_ticketid) OR (new_ticketid IS NULL AND t.event_id  = new_eventid AND t.category  = new_category))
ORDER BY rq2.listing_date
LIMIT 1;

-- Aν βρεθεί πωλητης δηλώνονται και τα 2 ως Sold
IF otherid IS NOT NULL THEN
UPDATE ResaleQueue
SET status='Sold'
WHERE resale_id IN (newresale_id, otherid);

-- Ενημερώνεται ο πίνακας Ticket για το νέο ιδιοκτήτη του εισιτηρίου
UPDATE Ticket t
JOIN Seller s  ON s.ticket_id = t.ticket_id
JOIN ResaleQueue rs ON rs.seller_id = s.seller_id AND rs.resale_id = otherid
JOIN Buyer b   ON b.buyer_id = new_buyerid
SET t.visitor_id = b.visitor_id;
END IF;
END IF;

END$$
DELIMITER ;


--Trigger πριν την καταχωρηση του Seller για να ελεγξουμε εαν εχει ανοιξει η ουρά μεταπώλησης
DELIMITER $$
CREATE TRIGGER before_insert_Seller
BEFORE INSERT ON Seller
FOR EACH ROW
BEGIN
DECLARE ACTIVE BOOLEAN DEFAULT FALSE;

Select e.full_ticket INTO ACTIVE
FROM ticket t 
JOIN EVENT E ON T.event_id = E.event_id
WHERE t.ticket_id = NEW.ticket_id;

IF active=FALSE THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Η ουρά μεταπώλησης δεν είναι ανοιχτή για το συγκεκριμένο event.';
END IF;
END$$
DELIMITER ;

-- Trigger για να ελέγξουμε εαν η ουρά μεταπώλησης είναι ανοιχτή, αν ο χρήστης έχει ήδη εισιτήριο για το event ή εαν έχει
-- δηλώσει ήδη ενδιαφέρον για το ίδιο event καθώς επιτρέπεται να αγοράσει μόνο 1 εισιτήριο για το ίδιο event.
DELIMITER $$
CREATE TRIGGER buyer_before_insert
BEFORE INSERT ON Buyer
FOR EACH ROW
BEGIN
DECLARE resale_open BOOLEAN DEFAULT FALSE;
DECLARE already INT DEFAULT 0;
DECLARE n_event_id INT;
DECLARE own_count INT DEFAULT 0;


IF NEW.ticket_id IS NOT NULL THEN
SELECT t.event_id INTO n_event_id
FROM Ticket t
WHERE t.ticket_id=NEW.ticket_id;
ELSE
SET n_event_id=NEW.event_id;
END IF;

-- Έλεγχος αν η ουρά είναι ανοιχτή
SELECT full_ticket INTO resale_open
FROM Event WHERE event_id=n_event_id;

IF resale_open = FALSE THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 
'Η ουρά μεταπώλησης δεν είναι ανοιχτή για το συγκεκριμένο event.';
END IF;

-- Έλεγχος αν ο χρήστης έχει ήδη εισιτήριο για το event
SELECT COUNT(*) INTO own_count
FROM Ticket
WHERE visitor_id=NEW.visitor_id AND event_id=n_event_id;

IF own_count > 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 
'Ο χρήστης ήδη έχει εισιτήριο για αυτό το event.';
END IF;


-- Έλεγχος διπλής εγγραφής
IF NEW.ticket_id IS NOT NULL THEN
-- Έχει ήδη ενδιαφέρον για αυτό το εισιτήριο

SELECT COUNT(*) INTO already
FROM Buyer 
WHERE visitor_id=new.visitor_id and ticket_id=new.ticket_id;
ELSE
-- Έχει ήδη ενδιαφέρομ για το ίδιο event+category;
SELECT COUNT(*) INTO already
FROM Buyer
WHERE visitor_id=NEW.visitor_id AND event_id=NEW.event_id AND category=NEW.category;
END IF;

IF already > 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Ο χρήστης έχει ήδη εισιτήριο ή ενδιαφέρον για αυτό το event.';
END IF;
END$$
DELIMITER ;


-- Μετά την εισαγωγή δεδομένων σε έναν πωλητή, εισάγονται αυτόματα στην RESALE QUEUE και καλείται η FIFO
DELIMITER $$
CREATE TRIGGER after_insert_Seller
AFTER INSERT ON Seller
FOR EACH ROW
BEGIN
DECLARE id INT;
INSERT INTO ResaleQueue (seller_id, interest) VALUES (NEW.seller_id, 'Sell');

SELECT resale_id INTO id
FROM ResaleQueue WHERE seller_id=NEW.seller_id
ORDER BY listing_date DESC
LIMIT 1;

CALL FIFO_resale(id);
END$$
DELIMITER ;

-- Μετά την εισαγωγή δεδομένων σε έναν αγοραστη, εισάγονται αυτόματα στην RESALE QUEUE και καλείται η FIFO
DELIMITER $$
CREATE TRIGGER after_insert_Buyer
AFTER INSERT ON Buyer
FOR EACH ROW
BEGIN
DECLARE id INT;
INSERT INTO ResaleQueue (buyer_id, interest) VALUES (NEW.buyer_id,'Buy');
 
SELECT resale_id INTO id
FROM ResaleQueue WHERE buyer_id=NEW.buyer_id
ORDER BY listing_date DESC
LIMIT 1;

CALL FIFO_resale(id);
END$$
DELIMITER ;

-- Δημιουργία View για την ResaleQueue προκειμένου να βλέπουμε και τα αποτελέσματα της FIFO
CREATE  VIEW ResaleQueueView AS
SELECT
rq.resale_id,
COALESCE(s.ticket_id, b.ticket_id) AS ticket_id, -- Επιστρέφει την πρώτη μη null τιμή
COALESCE(t.event_id,b.event_id) AS event_id,
COALESCE(t.category,b.category) AS category,
rq.seller_id,
rq.buyer_id,
t.cost AS cost,
rq.status AS status,
rq.listing_date AS listing_date,
rq.interest AS interest
FROM ResaleQueue rq
LEFT JOIN Seller s ON rq.seller_id=s.seller_id
LEFT JOIN Buyer b ON rq.buyer_id =b.buyer_id
LEFT JOIN Ticket t 
ON t.ticket_id=COALESCE(s.ticket_id,b.ticket_id);

--Αφαίρεση από την ResaleQueue αν o πώλητής αλλάξει γνώμη και διαγραφεί 
DELIMITER $$
CREATE TRIGGER delete_seller_resalequeue
AFTER DELETE ON Seller
FOR EACH ROW
BEGIN
DELETE FROM ResaleQueue 
WHERE seller_id = OLD.seller_id;
END$$
DELIMITER ;

--Αφαίρεση από την ResaleQueue αν o αγοραστής αλλάξει γνώμη και διαγραφεί 
DELIMITER $$
CREATE TRIGGER delete_buyer_resalequeue
AFTER DELETE ON buyer
FOR EACH ROW
BEGIN
DELETE FROM ResaleQueue 
WHERE buyer_id=OLD.buyer_id;
END$$
DELIMITER ;

DELIMITER $$

-- Ελέγχουμε εαν το εισιτήριο είναι ενεργοποιημένο και αν η παράσταση υπάρχει για να γίνει η αξιολόγηση
CREATE TRIGGER rating_insert
BEFORE INSERT ON Rating
FOR EACH ROW
BEGIN

IF (Select t.activated FROM Ticket t WHERE t.ticket_id = NEW.ticket_id)=FALSE THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Το εισιτήριο δεν είναι ενεργοποιημένο.';
END IF;

-- Ελέγχουμε ότι η παράσταση υπάρχει
IF NOT EXISTS (
SELECT 1
FROM Performance p
WHERE p.performance_id = NEW.performance_id) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Η παράσταση δεν υπάρχει.';
END IF;

-- Ελέγχουμε ότι το εισιτήριο και η παράσταση ανήκουν στο ίδιο event
IF NOT EXISTS (
SELECT 1
FROM Ticket t
JOIN Performance p ON t.event_id=p.event_id
WHERE t.ticket_id=NEW.ticket_id AND p.performance_id=NEW.performance_id) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Το εισιτήριο δεν αντιστοιχεί στην παράσταση για το ίδιο event.';
END IF;
END$$

-- Ελέγχουμε εαν το εισιτήριο είναι ενεργοποιημένο και αν η παράσταση υπάρχει για να γίνει η αξιολόγηση
CREATE TRIGGER rating_update
BEFORE UPDATE ON Rating
FOR EACH ROW
BEGIN

IF (Select t.activated FROM Ticket t WHERE t.ticket_id = NEW.ticket_id)=FALSE THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Το εισιτήριο δεν είναι ενεργοποιημένο.';
END IF;

-- Ελέγχουμε ότι η παράσταση υπάρχει
IF NOT EXISTS (
SELECT 1
FROM Performance p
WHERE p.performance_id = NEW.performance_id) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Η παράσταση δεν υπάρχει.';
END IF;

-- Ελέγχουμε ότι το εισιτήριο και η παράσταση ανήκουν στο ίδιο event
IF NOT EXISTS (
SELECT 1
FROM Ticket t
JOIN Performance p ON t.event_id=p.event_id
WHERE t.ticket_id=NEW.ticket_id AND p.performance_id=NEW.performance_id) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Το εισιτήριο δεν αντιστοιχεί στην παράσταση για το ίδιο event.';
END IF;
END$$
DELIMITER ;

-- Ελέγχουμε εαν ο καλλιτέχνης συμμετέχει 3 συνεχόμενες χρονιές στο φεστιβάλ
DELIMITER $$
CREATE trigger continius_years 
Before insert on performance
FOR EACH ROW
BEGIN
Declare this_year INT;
Declare total1 INT;  
Declare total2 INT;
Declare total3 INT;

Select F.year into this_year
FROM festival F
LEFT JOIN EVENT e ON f.festival_id = e.festival_id
WHERE e.event_id= NEW.event_id;

Select count(Distinct(f2.year)) INTO total1
FROM festival f2
JOIN EVENT e2 ON f2.festival_id = e2.festival_id
JOIN performance p ON p.event_id = e2.event_id
WHERE p.performer_id=NEW.performer_id And f2.year IN (this_year-1,this_year,this_year-2);

Select count(Distinct(f3.year)) INTO total2
FROM festival f3
JOIN EVENT e3 ON f3.festival_id = e3.festival_id
JOIN performance p ON p.event_id = e3.event_id
WHERE p.performer_id=NEW.performer_id And f3.year IN (this_year-1,this_year,this_year+1);

Select count(Distinct(f4.year)) INTO total3
FROM festival f4
JOIN EVENT e4 ON f4.festival_id = e4.festival_id
JOIN performance p ON p.event_id = e4.event_id
WHERE p.performer_id=NEW.performer_id And f4.year IN (this_year,this_year+1,this_year+2);

IF total1=3
OR total2=3
OR total3=3 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Δεν επιτρέπεται να συμετάσχει ο καλλιτέχνης 3 συνεχόμενες χρονιές στο φεστιβάλ.';
END IF;
END$$
DELIMITER ;




CREATE INDEX idx_ticket_event_cat_pay ON TICKET (event_id, category, payment_method);

CREATE INDEX idx_pg_gen_perf ON PERFORMERGENRE (genre, performer_id);

CREATE INDEX idx_perf_type_perf ON PERFORMANCE (performance_type, performer_id, event_id);

CREATE INDEX idx_perf_performer ON PERFORMANCE (performer_id);

CREATE INDEX idx_rating_performance ON RATING (performance_id);

CREATE INDEX idx_rating_ticket ON RATING (ticket_id);

CREATE INDEX idx_artist_birthdate ON ARTIST (birthdate);

CREATE INDEX idx_band_birthdate ON BAND (formation_date);

CREATE INDEX idx_location_continent ON LOCATION (continent);

CREATE INDEX idx_pg_perf_gen ON PERFORMERGENRE (performer_id, genre);

CREATE INDEX idx_event_stage_date ON EVENT (stage_id, event_date);

CREATE INDEX idx_event_date ON EVENT (event_date);

CREATE INDEX idx_event_festival ON EVENT (festival_id);

CREATE INDEX idx_ticket_event ON TICKET (event_id);

CREATE INDEX idx_ticket_paymethod ON TICKET (payment_method);

CREATE INDEX idx_performance_event ON PERFORMANCE (event_id);

CREATE INDEX idx_performance_start ON PERFORMANCE (start_time);

CREATE INDEX idx_staff_experience ON STAFF (experience_level);

CREATE INDEX idx_evtstaff_event ON EVENTSTAFF (event_id);

CREATE INDEX idx_evtstaff_staff ON EVENTSTAFF (staff_id);

CREATE INDEX idx_resale_status_fifo  ON ResaleQueue (status, interest, listing_date);

CREATE INDEX idx_ticket_visitor ON TICKET (visitor_id);

CREATE INDEX idx_membership_band ON MEMBERSHIP (band_id);

CREATE INDEX idx_membership_artist ON MEMBERSHIP (artist_id);
