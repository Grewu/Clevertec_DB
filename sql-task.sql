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
