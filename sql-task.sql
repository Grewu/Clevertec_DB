1.Вывести к каждому самолету класс обслуживания и количество мест этого класса
SELECT 
    aircrafts_data.aircraft_code, 
    aircrafts_data.model,
    seats.fare_conditions, 
    COUNT(*) AS seat_count
FROM 
    aircrafts_data 
JOIN 
    seats ON aircrafts_data.aircraft_code = seats.aircraft_code
WHERE 
    seats.fare_conditions IN ('Economy', 'Business')
GROUP BY 
    aircrafts_data.aircraft_code,
    aircrafts_data.model,
    seats.fare_conditions
ORDER BY 
    aircrafts_data.aircraft_code, seats.fare_conditions;

2.Найти 3 самых вместительных самолета (модель + кол-во мест)
SELECT 
    aircrafts_data.aircraft_code, 
    aircrafts_data.model,
    COUNT(*) AS seat_count
FROM 
    aircrafts_data 
JOIN 
    seats ON aircrafts_data.aircraft_code = seats.aircraft_code
GROUP BY 
    aircrafts_data.aircraft_code,
    aircrafts_data.model
ORDER BY 
   seat_count DESC 
LIMIT 3;

3.Найти все рейсы, которые задерживались более 2 часов
SELECT * FROM flights 
where status  = 'Arrived' 
	and (actual_arrival - flights.scheduled_arrival  > 1 * '7200 sec'::interval);

4.Найти последние 10 билетов, купленные в бизнес-классе (fare_conditions = 'Business'), с указанием имени пассажира и контактных данных
SELECT ticket_flights.ticket_no,
		ticket_flights.fare_conditions,
		tickets.passenger_name,
		tickets.contact_data 
FROM ticket_flights 
JOIN tickets ON tickets.ticket_no = ticket_flights.ticket_no
WHERE fare_conditions = 'Business'
order by ticket_flights.ticket_no limit 10;

5.Найти все рейсы, у которых нет забронированных мест в бизнес-классе (fare_conditions = 'Business')
SELECT * from flights
join ticket_flights on flights.flight_id = ticket_flights.flight_id
where ticket_flights.fare_conditions != 'Business';

6.Получить список аэропортов (airport_name) и городов (city), в которых есть рейсы с задержкой
select distinct airport_name,
		city
from airports_data
join flights on  airports_data.airport_code = flights.arrival_airport
where status  = 'Arrived' 
and (actual_arrival - flights.scheduled_arrival  > 0 * '1 sec'::interval);

7.Получить список аэропортов (airport_name) и количество рейсов, вылетающих из каждого аэропорта, отсортированный по убыванию количества рейсов
select airports_data.airport_name,
flights.departure_airport,
		count(flights.departure_airport) as flight_count 
from airports_data
join flights on  airports_data.airport_code = flights.departure_airport
group by  airports_data.airport_name,flights.departure_airport;

8.Найти все рейсы, у которых запланированное время прибытия (scheduled_arrival) было изменено и новое время прибытия (actual_arrival) не совпадает с запланированным
SELECT *
   FROM flights f
   WHERE (f.scheduled_arrival != f.actual_arrival);
9.Вывести код, модель самолета и места не эконом класса для самолета "Аэробус A321-200" с сортировкой по местам
SELECT a.aircraft_code,
		a.model,
		s.fare_conditions
   FROM aircrafts a 
join seats s on a.aircraft_code = s.aircraft_code
where s.fare_conditions != 'Economy' and
	  a.model = 'Аэробус A321-200'
order by a.aircraft_code;
9.Вывести код, модель самолета и места не эконом класса для самолета "Аэробус A321-200" с сортировкой по местам
SELECT a.aircraft_code,
		a.model,
		s.fare_conditions
   FROM aircrafts a 
join seats s on a.aircraft_code = s.aircraft_code
where s.fare_conditions != 'Economy' and
	  a.model = 'Аэробус A321-200'
order by a.aircraft_code;
10.Вывести города, в которых больше 1 аэропорта (код аэропорта, аэропорт, город)
select airport_code, airport_name,city
from airports a1
where (select count(city) from airports a2 where a1.city = a2.city ) > 1;
11.Найти пассажиров, у которых суммарная стоимость бронирований превышает среднюю сумму всех бронирований
SELECT
    t.passenger_id,
    t.passenger_name,
    SUM(b.total_amount) AS total_sum
FROM
    tickets t
JOIN
    bookings b ON t.book_ref = b.book_ref
GROUP BY
    t.passenger_id, t.passenger_name
HAVING
   SUM(b.total_amount) > (SELECT AVG(total_amount) FROM bookings);
12.Найти ближайший вылетающий рейс из Екатеринбурга в Москву, на который еще не завершилась регистрация
SELECT *
FROM flights f
WHERE f.departure_airport = 'SVX' 
  AND f.arrival_airport IN ('SVO', 'VKO', 'DME') 
  AND f.status IN ('Scheduled', 'On Time', 'Delayed');
13.Вывести самый дешевый и дорогой билет и стоимость (в одном результирующем ответе)
select distinct 
tf.fare_conditions,
max(tf.amount),
min(tf.amount) 
FROM ticket_flights tf
group by tf.fare_conditions;
14.Написать DDL таблицы Customers, должны быть поля id, firstName, LastName, email, phone. Добавить ограничения на поля (constraints)
CREATE TABLE Customer (
    id serial4 NOT NULL,
    first_name jsonb NOT NULL,
    last_name jsonb NOT NULL,
    email jsonb UNIQUE NOT NULL,
    contact_data jsonb NULL,
    CONSTRAINT id_pkey PRIMARY KEY (id),
  CONSTRAINT email_format_check CHECK (email->>'email' LIKE '%_@__%.%')
);
15.Написать DDL таблицы Orders, должен быть id, customerId, quantity. Должен быть внешний ключ на таблицу customers + constraints
CREATE TABLE Orders (
    id serial4 NOT NULL,
    customerId serial4 NOT null,
    quantity serial4 NOT null,
    CONSTRAINT order_id_pkey PRIMARY KEY (id),
    CONSTRAINT customerId_ref_fkey FOREIGN KEY (customerId) REFERENCES customer(id),
    CONSTRAINT quantity_check CHECK ((quantity > 0))
);
16.Написать 5 insert в эти таблицы

INSERT INTO bookings.customer (first_name, last_name, email, contact_data)
VALUES
  ('{"first": "Eva"}', '{"last": "Johnson"}', '{"email": "eva.johnson@example.com"}', '{"phone": "111-222-3333"}'),
  ('{"first": "Michael"}', '{"last": "Smith"}', '{"email": "michael.smith@example.com"}', '{"phone": "444-555-6666"}'),
  ('{"first": "Olivia"}', '{"last": "Miller"}', '{"email": "olivia.miller@example.com"}', '{"phone": "777-888-9999"}'),
  ('{"first": "Daniel"}', '{"last": "Brown"}', '{"email": "daniel.brown@example.com"}', '{"phone": "333-666-9999"}'),
  ('{"first": "Sophia"}', '{"last": "Davis"}', '{"email": "sophia.davis@example.com"}', '{"phone": "555-888-1111"}');

INSERT INTO Orders (customerId, quantity)
VALUES
  (1, 5),
  (3, 2),
  (2, 10),
  (4, 8),
  (5, 3);

  INSERT INTO bookings.customer (first_name, last_name, email, contact_data)
VALUES
  ('{"first": "John"}', '{"last": "Doe"}', '{"email": "pavel.doe@example.com"}', '{"phone": "123-456-7890"}'),
  ('{"first": "Jane"}', '{"last": "Smith"}', '{"email": "sahsa.smith@example.com"}', '{"phone": "987-654-3210"}'),
  ('{"first": "Bob"}', '{"last": "Johnson"}', '{"email": "job.johnson@example.com"}', NULL);

  INSERT INTO bookings.orders (customerId, quantity)
VALUES
  (16, 7),
  (17, 1);

  INSERT INTO bookings.customer (first_name, last_name, email, contact_data)
VALUES
   ('{"first": "Eva"}', '{"last": "Johnson"}', '"eva.johnson@example.com"', '{"phone": "111-222-3333"}'),
  ('{"first": "Michael"}', '{"last": "Smith"}', '"michael.smith@example.com"', '{"phone": "444-555-6666"}'),
  ('{"first": "Olivia"}', '{"last": "Miller"}', '"olivia.miller@example.com"', '{"phone": "777-888-9999"}'),
  ('{"first": "Daniel"}', '{"last": "Brown"}', '"daniel.brown@example.com"', '{"phone": "333-666-9999"}'),
  ('{"first": "Sophia"}', '{"last": "Davis"}', '"sophia.davis@example.com"', '{"phone": "555-888-1111"}');
  
17.Удалить таблицы
DROP TABLE bookings.orders;
DROP TABLE bookings.customer;