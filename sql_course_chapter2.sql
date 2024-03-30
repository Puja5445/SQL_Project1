USE moviesdb
SELECT * FROM moviesdb.movies;
SELECT * FROM movies WHERE industry = 'bollywood'
SELECT COUNT(*) FROM movies WHERE industry = 'Bollywood'
SELECT COUNT(*) FROM movies WHERE industry = "Hollywood"
SELECT DISTINCT industry FROM movies
SELECT * FROM movies WHERE studio = ""
SELECT * FROM movies WHERE title LIKE "%thor%"
SELECT * FROM movies WHERE title LIKE "%AMERICA%"
-------------------------------------------------------------------------------------------------------------------------------------
'''Excercise 1 - chapter 2'''
SELECT title,release_year,studio FROM movies WHERE studio = "Marvel Studios"
SELECT * FROM movies WHERE title LIKE "%avenger%"
SELECT release_year,title FROM movies WHERE title = "the Godfather"
SELECT release_year FROM movies WHERE title = "the Godfather"
SELECT DISTINCT studio,industry FROM movies WHERE industry = "bollywood"

--------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM movies where imdb_rating >= 9
SELECT * FROM movies where imdb_rating >= 6 AND imdb_rating <= 8
SELECT * FROM movies where imdb_rating between 6 and 8
SELECT * FROM movies where release_year = 2022
SELECT * FROM movies where release_year = 2022 or release_year = 2019
SELECT * FROM movies where release_year IN (2019,2022,2018)
SELECT * FROM movies where Studio IN ("Marvel Studios","Zee Studios")
SELECT * FROM movies where imdb_rating is NULL
SELECT * FROM movies where imdb_rating is NOT NULL
SELECT * FROM movies where industry = "bollywood" ORDER BY imdb_rating 
SELECT * FROM movies where industry = "bollywood" ORDER BY imdb_rating DESC
SELECT * FROM movies where industry = "bollywood" ORDER BY imdb_rating DESC LIMIT 5
SELECT * FROM movies where industry = "bollywood" ORDER BY imdb_rating DESC LIMIT 5 OFFSET 2 
---------------------------------------------------------------------------------------------------------------------------
'''' sometimes in a situation where we use offset along with limit, generally the indexing starts with zero for 1st row if you
dont want to see the first row then mention offset 1, where 1 is the next index after zero so the row start with the 2nd number''''
--------------------------------------------------------------------------------------------------------------------------------

Exercise 2

SELECT * FROM movies
SELECT * FROM movies ORDER BY release_year desc 
SELECT * FROM movies where release_year = 2022
SELECT * FROM movies where release_year IN (2021,2022)
SELECT * FROM movies where release_year > 2020
SELECT * FROM movies where release_year > 2020 AND imdb_rating > 8
SELECT * FROM movies where studio IN ("Hombale Films", "Marvel Studios")
SELECT * FROM movies where title LIKE "%THOR%" order by release_year
SELECT * FROM movies where studio != "Marvel Studios"
--------------------------------------------------------------------------------------------------------------------------
SELECT COUNT(*) FROM movies where industry = "Bollywood"
SELECT MAX(imdb_rating) FROM movies where industry = "Bollywood"
SELECT MIN(imdb_rating) FROM movies where industry = "Bollywood"
SELECT AVG(imdb_rating) FROM movies where studio = "Marvel Studios"
SELECT ROUND(AVG(imdb_rating),2) FROM movies where studio = "Marvel Studios"
SELECT ROUND(AVG(imdb_rating),2) as avg_rating FROM movies where studio = "Marvel Studios"
-------------------------------------------------------------------------------------------------------------------------------------
SELECT 
      MAX(imdb_rating) as max_rating, 
      MIN(imdb_rating) as min_rating, 
	  ROUND(AVG(imdb_rating),2) as avg_rating 
FROM movies 
where studio = "Marvel Studios"
---------------------------------------------------------------------------------------------------------------------------------------
SELECT 
      studio,
      COUNT(studio) as cnt,
      ROUND(AVG(imdb_rating),1) as avg_rating
FROM movies
WHERE studio != ""
GROUP BY studio
ORDER BY avg_rating DESC;
----------------------------------------------------------------------------------------------------------------------------------------
Excercise 3

SELECT * FROM movies
SELECT COUNT(*) FROM movies WHERE release_year BETWEEN 2015 AND 2022
SELECT MIN(release_year) as min_release_year, MAX(release_year) as max_release_year FROM movies
SELECT 
	  release_year,
      COUNT(*) as movie_count
FROM movies
GROUP BY release_year
ORDER BY release_year DESC
------------------------------------------------------------------------------------------------------------------------
'''HAVING CLAUSE'''
SELECT 
      release_year,COUNT(*) as movie_count
FROM movies
GROUP BY release_year
HAVING movie_count > 2
ORDER BY movie_count DESC

SELECT --> FROM --> WHERE --> GROUP BY --> HAVING --> ORDER BY

-------------------------------------------------------------------------------------------------------------------------
SELECT * FROM actors
SELECT *, YEAR(CURDATE())-birth_year as age FROM actors
----------------------------------------------------------------------------------------------
SELECT * FROM financials
SELECT *, ROUND((revenue-budget),1) as profit FROM financials
SELECT *, 
     IF(currency = "USD", revenue*77, revenue) as revenue_inr 
FROM financials
SELECT DISTINCT unit FROM financials
SELECT *,
   CASE
         WHEN unit = "Thousand" THEN revenue/1000
         WHEN unit = "Billions" THEN revenue*1000
         ELSE revenue
    END as revenue_mln
FROM financials
------------------------------------------------------------------------------------------------
Excercise: 3

select 
        *, 
    (revenue-budget) as profit, 
    (revenue-budget)*100/budget as profit_pct 
   from financials
-------------------------------------------------------------------------------------------- 












