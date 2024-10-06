--netfrlix project 
drop table if exists netflix;
create table netflix (
	show_id	varchar (6),
	type varchar (10),
	title	varchar (150),
	director varchar (208),
	casts varchar (1000),
	country	varchar (150),
	date_added varchar (50),
	release_year	int ,
	rating varchar (10),
	duration	varchar (15),
	listed_in varchar (100),
	description varchar (250)

);
select * from netflix;
select count(*)from netflix;
select distinct type from netflix;

--analysis
-- count the number of movies vs tv shows
select type,count(*)
from netflix
group by type;

--most common rating for movies and tv shows
select type,rating
	from 
	(
select  type , rating,count(*),
	rank () over(partition by type order by count(*)desc ) as ranking
from netflix 
group by 1, 2)
--as t1
where ranking=1;

--list all the movies released in a specific year (2020) 
select * from netflix
where 
	type ='Movie'
		and  
   	release_year =2020

--list top 5 countries with the most content on netflix
    select unnest(string_to_array(country,','))as	new_country,
	count(show_id)as total_content
    from netflix 
group by 1
	order by 2 desc
	limit 5;

--identify the longest movie
select title,duration from netflix
	where type ='Movie'
	group by duration,title
order by duration desc;

--find content added in the last 5 years 
select * from netflix
where
to_date(date_added,'month DD,yyyy')>= current_date-interval '5 years'

--display all the movies/tv shows by director 'Rajiv Chilaka'
select * from netflix
where director like '%Rajiv Chilaka%';

--list all tv shows with more than 5 seasons
select * from netflix
where
	type='TV Show'
and
    duration > '6 seasons';
