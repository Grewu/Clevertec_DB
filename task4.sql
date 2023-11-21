SELECT ticket_flights.ticket_no,
		ticket_flights.fare_conditions,
		tickets.passenger_name,
		tickets.contact_data 
FROM ticket_flights 
JOIN tickets ON tickets.ticket_no = ticket_flights.ticket_no
WHERE fare_conditions = 'Business'
order by ticket_flights.ticket_no limit 10;
