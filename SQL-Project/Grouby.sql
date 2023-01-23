select geoID, sum(amount) as Total, avg(Amount) as Average, sum(Boxes) as Boxes
from sales
group by geoID;

select g.Geo, sum(Amount), avg(Amount),sum(Boxes)
from sales 
join geo as g
group by g.Geo;

select pr.category,p.Team, sum(amount) as Amount, sum(boxes) as Boxes
from sales as s
join people as p on p.SPID = s.PID
join products as pr on pr.PID = s.PID
group by pr.category,p.Team;