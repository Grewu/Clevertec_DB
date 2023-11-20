SELECT * 
 FROM 
    flights 
where status  = 'Arrived' 
	and (actual_arrival - flights.scheduled_arrival  > 1 * '7200 sec'::interval);

