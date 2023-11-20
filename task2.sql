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
