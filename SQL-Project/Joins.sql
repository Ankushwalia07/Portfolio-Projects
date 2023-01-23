select * from sales;
select * from people;

select s.SaleDate, s.Amount, p.Salesperson, s.SPID, p.SPID
from sales as s
join
people as p on s.SPID = p.SPID;

select s.SaleDate, s.Amount, pr.product, pr.PID, s.PID
from sales as s
join
products as pr on pr.PID = s.PID;

select s.SaleDate, s.Amount, p.Salesperson, pr.product, p.Team
from sales as s
join
people as p on s.SPID = p.SPID
join
products as pr on pr.PID = s.PID;

select s.SaleDate,s.Amount,p.salesperson,pr.product
from sales as s
join people as p on s.SPID =p.SPID
join products as pr on s.PID =pr.PID
where s.amount<=500;

select s.SaleDate,s.Amount, p.Team,pr.product, g.Geo
from sales as s
join people as p on p.SPID = s.SPID
join products as pr on pr.PID = s.PID
join geo as g on g.geoid = s.geoid
where s.amount<500 and p.Team='' and g.Geo in ('New Zealand','India')
order by SaleDate;