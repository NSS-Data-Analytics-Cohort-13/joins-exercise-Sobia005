
-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.

SELECT s.film_title, s.release_year,  MIN(r.worldwide_gross) AS min_gross
FROM specs as s
INNER JOIN revenue as r
ON s.movie_id = r.movie_id
GROUP BY s.film_title, s.release_year
ORDER BY min_gross
LIMIT 1;



-- 2. What year has the highest average imdb rating?


SELECT s.release_year, AVG(r.imdb_rating) AS avg_rating
FROM specs as s
INNER JOIN rating as r
ON  s.movie_id = r.movie_id
GROUP BY s.release_year
ORDER BY avg_rating DESC
LIMIT 1;

-- ANSWER
-- release_year 1991, avg_rating 7.450000000000


-- 3. What is the highest grossing G-rated movie? Which company distributed it?
SELECT r.worldwide_gross, s.film_title, d.company_name, s.mpaa_rating 
FROM specs AS s
INNER JOIN revenue AS r
ON s.movie_id = r.movie_id
JOIN distributors AS d
ON d.distributor_id = s.domestic_distributor_id
WHERE s.mpaa_rating = 'G'
ORDER BY r.worldwide_gross DESC;




-- 4. Write a query that returns, for each distributor in the distributors table, 
-- the distributor name and the number of movies associated with that distributor in the movies 
-- table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.


SELECT d.company_name, COUNT(s.movie_id) AS number_of_movies
FROM distributors AS d
LEFT JOIN specs AS s
ON d.distributor_id = s.domestic_distributor_id
GROUP BY d.company_name
ORDER BY number_of_movies DESC;




-- 5. Write a query that returns the five distributors with the highest average movie budget.
SELECT d.company_name
		, AVG(r.film_budget) AS hamb
FROM distributors AS d 
JOIN specs AS s
ON d.distributor_id = s.domestic_distributor_id
JOIN revenue AS r 
ON r.movie_id = s.movie_id
GROUP BY company_name
ORDER BY hamb DESC
LIMIT 5;




-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California?
 -- Which of these movies has the highest imdb rating?

SELECT s.film_title, r.imdb_rating AS highest_imdb_rating
FROM distributors AS d
LEFT JOIN specs AS s
ON d.distributor_id = s.domestic_distributor_id
JOIN rating AS r
ON r.movie_id = s.movie_id
WHERE d.headquarters NOT ILIKE '%CA'
ORDER BY highest_imdb_rating DESC;




-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?

SELECT 
	CASE WHEN length_in_min >=0 AND length_in_min <=120 THEN 'Under 2 Hours' 
	ELSE 'Over 2 Hours'
	END AS length_range, 
	AVG(r.imdb_rating) as avg_rating
FROM specs as s
LEFT JOIN rating as r
USING(movie_id)
GROUP BY length_range
ORDER BY avg_rating DESC;



