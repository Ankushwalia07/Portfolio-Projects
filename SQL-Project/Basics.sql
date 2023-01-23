show tables;
describe sales;

select * from sales;

select  SaleDate,amount,Customers from sales;

select SaleDate,Amount,Boxes,Amount/Boxes from sales;

select SaleDate, Amount,Boxes,Amount/Boxes as 'Amount per box' from sales;

select * from sales
where Amount >10000;

select * from sales
where Amount >10000
order by Amount desc;

select * from sales
where GeoID = 'G1'
order by PID, Amount desc;

select * from sales
where Amount>10000 and SaleDate >= '2022-01-01' and GeoID='G1'
order by PID,Amount;

select SaleDate, Amount from sales
where Amount>10000 and year(SaleDate)=2022
order by Amount desc;

select * from sales
where Boxes between 0 and 50;

select SaleDate,Amount, weekday(SaleDate) as 'Day of week' from sales
where weekday(SaleDate)=4;



select * from people;

select * from people
where team = 'Delish' or team ='Jucies';

select * from people
where Salesperson like 'B%';

select * from people
where Salesperson like '%B%';

select * from sales;


select SaleDate, Amount,
	case when amount<1000 then 'under 1K'
		when amount<5000 then 'under 5k'
        when amount<10000 then 'under 10k'
		else '10k or more'
    end as 'Amount Category'
from sales;
