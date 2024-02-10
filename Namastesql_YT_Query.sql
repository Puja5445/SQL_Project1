--Script to create and insert data:

CREATE table activity
(
user_id varchar(20),
event_name varchar(20),
event_date date,
country varchar(20)
);
delete from activity;
insert into activity values (1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan');

--1. find total active users each day
select event_date,count(distinct(user_id)) as active_users from activity
group by event_date
order by active_users

--2.find total active users each week?
select datepart(week,event_date) as each_week, count(distinct(user_id)) as active_users from activity
group by datepart(week,event_date)

--3. Date wise total number of users who made the purchase same day they installed the app

select event_date, count(new_user) as no_of_users from
(select user_id,event_date,
case
when count(distinct(event_name)) = 2 then user_id else null end as new_user from activity
group by event_date,user_id) a
group by event_date

--4. percentage of paid users in India, USA and any other country should be tagged as others?
 
 with cte as
 (select case when country in ('India','USA') then country else 'others' end as new_country,count(distinct(user_id)) as user_count from activity
 where event_name = 'app-purchase'
 group by case when country in ('India','USA') then country else 'others' end)
 ,total as (select sum(user_count) as total_users from cte)
 select new_country, round(user_count*1.0/total_users*100,2)
 from cte,total