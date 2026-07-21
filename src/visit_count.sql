/*
This SQL query retrieves the total number of visits recorded by sensors in different facilities (branches) over a specified date range. 
It joins multiple tables from the ServerManager database to gather relevant data, including sensor readings, facility information, 
and server details. The results are grouped by facility name and date, providing a summary of visits for each branch on each day 
within the specified timeframe. The output includes the branch name, date, and total visits for that date.
*/


declare @StartDate datetime = '2026-01-01 00:00:00';
declare @EndDate datetime = '2026-07-01 00:00:00';


select f.FacilityName as 'Branch', 
CAST(sd.ServerDate AS DATE) AS [Date],
DATEPART(hour, sd.ServerDate) AS [HourOfDay],
Sum(ValueA) as 'Visits'
from ServerManager.dbo.SensorData as sd
join ServerManager.dbo.Sensors as s on s.SensorId = sd.SensorId
join ServerManager.dbo.Facility as f on f.Facility = s.FacilityId
join ServerManager.dbo.Servers as ser on ser.ServerId = sd.ServerId
where sd.ServerDate > @StartDate
and sd.ServerDate < @EndDate
group by f.FacilityName, CAST(sd.ServerDate AS DATE), DATEPART(hour, sd.ServerDate) 
order by f.FacilityName, CAST(sd.ServerDate AS DATE), DATEPART(hour, sd.ServerDate);