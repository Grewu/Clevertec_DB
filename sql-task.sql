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
10.Вывести города, в которых больше 1 аэропорта (код аэропорта, аэропорт, город)
select airport_code, airport_name,city
from airports a1
where (select count(city) from airports a2 where a1.city = a2.city ) > 1;
11.Найти пассажиров, у которых суммарная стоимость бронирований превышает среднюю сумму всех бронирований
12.Найти ближайший вылетающий рейс из Екатеринбурга в Москву, на который еще не завершилась регистрация
13.Вывести самый дешевый и дорогой билет и стоимость (в одном результирующем ответе)
14.Написать DDL таблицы Customers, должны быть поля id, firstName, LastName, email, phone. Добавить ограничения на поля (constraints)
15.Написать DDL таблицы Orders, должен быть id, customerId, quantity. Должен быть внешний ключ на таблицу customers + constraints
16.Написать 5 insert в эти таблицы
17.Удалить таблицы

