--select * from credit_card_transcations
--alter table credit_card_transcations alter column transaction_id int not null
--alter table credit_card_transcations alter column transaction_date datetime
--alter table credit_card_transcations alter column amount decimal

--solve below questions
--1- write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends 
--2- write a query to print highest spend month and amount spent in that month for each card type
--3- write a query to print the transaction details(all columns from the table) for each card type when
--it reaches a cumulative of 1000000 total spends(We should have 4 rows in the o/p one for each card type)
--4- write a query to find city which had lowest percentage spend for gold card type
--5- write a query to print 3 columns:  city, highest_expense_type , lowest_expense_type (example format : Delhi , bills, Fuel)
--6- write a query to find percentage contribution of spends by females for each expense type
--7- which card and expense type combination saw highest month over month growth in Jan-2014
--8- during weekends which city has highest total spend to total no of transcations ratio 
--9- which city took least number of days to reach its 500th transaction after the first transaction in that city

select * from credit_card_transcations
select count(1) from credit_card_transcations

select min(transaction_date) as earliest_transaction_date,max(transaction_date) as latest_transaction_date
from credit_card_transcations

select distinct card_type from credit_card_transcations
select distinct exp_type from credit_card_transcations
select distinct city from credit_card_transcations
--------------------------------------------------------------------------------------------------------------------------------------------------------
--1. write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends 
with cte1 as
(select city,sum(amount) as total_spend 
from credit_card_transcations
group by city)
,total_spent as (select sum(cast(amount as bigint)) as total_amount from credit_card_transcations)
select top 5cte1.*,round(total_spend*1.0/total_amount * 100,2) as percentage_contribution
from cte1 inner join total_spent
on 1=1
order by total_spend desc

--------------------------------------------------------------------------------------------------------------------------------------------------
--2- write a query to print highest spend month and amount spent in that month for each card type

with cte as (
select card_type,datepart(year,transaction_date) as year_of_transaction,
datepart(month,transaction_date) as month_of_transaction, sum(amount) as total_spend
from credit_card_transcations
group by card_type,datepart(year,transaction_date),
datepart(month,transaction_date)
)
select * from(select * ,rank() over(partition by card_type order by total_spend) as rank_num
from cte ) a where rank_num = 1

--------------------------------------------------------------------------------------------------------------------------------------------------------
--3. write a query to print the transaction details(all columns from the table) for each card type when
--it reaches a cumulative of 1000000 total spends(We should have 4 rows in the o/p one for each card type)

with cte1 as(
select *,sum(amount) over(partition by card_type order by transaction_date,transaction_id)as total_spend from credit_card_transcations)--it is giving running total
select * from (select *,rank() over(partition by card_type order by total_spend) as rn from cte1 
where total_spend >= 1000000) a 
where rn = 1
-------------------------------------------------------------------------------------------------------------------------------------------------------------
--4- write a query to find city which had lowest percentage spend for gold card type?

with cte as (
select city,card_type,sum(amount) as amount,
sum(case when card_type = 'Gold' then amount end) as gold_amount
from credit_card_transcations
group by city,card_type)
select city,round(sum(gold_amount)*1.0/sum(amount)*100,2) as gold_ratio
from cte
group by city
having count(gold_amount) >0
order by gold_ratio
-----------------------------------------------------------------------------------------------------------------------------------------------------
--5- write a query to print 3 columns:  city, highest_expense_type , lowest_expense_type (example format : Delhi , bills, Fuel).
select * from credit_card_transcations
with cte as (
select city,exp_type,sum(amount) as total_amount from credit_card_transcations
group by city,exp_type)
select 
city, max(case when rank_asc = 1 then exp_type end )as lowest_exp_type,
min(case when rank_desc = 1 then exp_type end) as highest_exp_type
from (select *,
rank() over(partition by city order by total_amount desc) as rank_desc,
rank() over(partition by city order by total_amount asc) as rank_asc
from cte) A
group by city
----------------------------------------------------------------------------------------------------------------------------------------------------------
--6- write a query to find percentage contribution of spends by females for each expense type?

select exp_type,sum(case when gender = 'F' then amount else 0 end)*1.0/sum(amount) as percentage_female_contribution
from credit_card_transcations
group by exp_type
order by percentage_female_contribution
------------------------------------------------------------------------------------------------------------------------------------------------------
--7. which card and expense type combination saw highest month over month growth in Jan-2014?

select * from credit_card_transcations






