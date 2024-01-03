use movie_ratings;
-- Average rating of each movie
SELECT title, ROUND(AVG(CAST(rating AS FLOAT)), 2) AS avg_rating
FROM movies
INNER JOIN user_ratings AS ratings
ON movies.movie_id = ratings.movie_id
GROUP BY title
ORDER BY avg_rating DESC;

--Average rating of movies rated by at least 3 users
SELECT title, COUNT(rating) AS num_ratings, ROUND(AVG(CAST(rating AS FLOAT)), 2) AS avg_rating
FROM movies
INNER JOIN user_ratings
ON movies.movie_id = user_ratings.movie_id
GROUP BY  title
HAVING COUNT(rating) > 2
ORDER BY num_ratings DESC, avg_rating DESC;

--Reception of movies rated by at least 3 users
SELECT movies.title, COUNT(rating) AS num_ratings, ROUND(AVG(CAST(rating AS FLOAT)), 2) AS avg_rating,
CASE 
WHEN ROUND(AVG(CAST(rating AS FLOAT)), 2) > 3.5 then 'well-received'
WHEN ROUND(AVG(CAST(rating AS FLOAT)), 2) > 2.3 then 'lukewarm reception'
ELSE 'poor reception'
END AS reception
FROM movies
JOIN user_ratings  
ON movies.movie_id = user_ratings.movie_id
GROUP BY movies.title
HAVING COUNT(rating) > 2
ORDER BY avg_rating DESC;

--Average rating by a franchise
SELECT franchise, ROUND(AVG(CAST(rating AS FLOAT)), 2) AS avg_rating
FROM movies
JOIN user_ratings AS ratings
ON movies.movie_id = ratings.movie_id
WHERE franchise IS NOT NULL
GROUP BY franchise
ORDER BY avg_rating DESC;

--Average of franchises with at least two movies
SELECT  franchise, ROUND(AVG(CAST(rating AS FLOAT)), 2) as avg_rating
FROM movies t1
JOIN user_ratings t3
ON t1.movie_id = t3.movie_id
WHERE (SELECT COUNT(*) FROM movies t2 WHERE t1.franchise = t2.franchise) > 1
GROUP BY franchise
Having COUNT(franchise) > 1;

--Non-franchise movies
SELECT DISTINCT title, director
FROM  movies 
WHERE franchise IS NULL;

--Average rating of non-franchise movies vs franchise movies
SELECT 'avg_nonfranchise', ROUND(AVG(CAST(rating AS FLOAT)), 2) AS avg_rating
FROM movies
JOIN user_ratings
ON movies.movie_id = user_ratings.movie_id
WHERE franchise IS NULL
UNION 
SELECT 'avg_franchise', ROUND(AVG(CAST(rating AS FLOAT)), 2) 
FROM movies
JOIN user_ratings
ON movies.movie_id = user_ratings.movie_id
WHERE franchise IS NOT NULL;

--Average rating of directors with more than one movie 
SELECT DISTINCT director, ROUND(AVG(CAST(rating AS FLOAT)), 2) as avg_rating
FROM movies t1
JOIN user_ratings t3
ON t1.movie_id = t3.movie_id
WHERE (SELECT COUNT(*) FROM movies t2 WHERE t1.director = t2.director) > 1
GROUP BY director;

--Average rating of movies based on length
SELECT '2 hours long and more' AS length, ROUND(AVG(CAST(rating AS FLOAT)), 2) AS avg_rating
FROM movies 
JOIN user_ratings
ON movies.movie_id = user_ratings.movie_id
WHERE running_time > 120
UNION
SELECT 'between 1.5 hours and 2 hours', ROUND(AVG(CAST(rating AS FLOAT)), 2)
FROM movies 
JOIN user_ratings
ON movies.movie_id = user_ratings.movie_id
WHERE running_time >= 90 and running_time < 120;


-- Average rating of dramas
SELECT 'drama' AS genre, ROUND(AVG(CAST(rating AS FLOAT)), 2) AS avg_rating
FROM movies
JOIN user_ratings
ON movies.movie_id = user_ratings.movie_id
WHERE genre LIKE '%Drama%'
UNION
-- Average rating of action movies
SELECT 'action', ROUND(AVG(CAST(rating AS FLOAT)), 2) 
FROM movies
JOIN user_ratings
ON movies.movie_id = user_ratings.movie_id
WHERE genre LIKE '%Action%'
UNION
-- Average rating of superhero movies
SELECT 'superhero', ROUND(AVG(CAST(rating AS FLOAT)), 2) 
FROM movies
JOIN user_ratings
ON movies.movie_id = user_ratings.movie_id
WHERE genre LIKE '%Superhero%'
UNION
-- Average rating of horrors
SELECT 'horror', ROUND(AVG(CAST(rating AS FLOAT)), 2) 
FROM movies
JOIN user_ratings
ON movies.movie_id = user_ratings.movie_id
WHERE genre LIKE '%Horror%';


--English movies vs non-english movies avg rating
SELECT 'English' AS language, ROUND(AVG(CAST(rating AS FLOAT)), 2) AS avg_rating
FROM movies
JOIN user_ratings
ON movies.movie_id = user_ratings.movie_id
WHERE language like '%English%'
GROUP BY language
UNION
SELECT 'Non-English', ROUND(AVG(CAST(rating AS FLOAT)), 2) 
FROM movies
JOIN user_ratings
ON movies.movie_id = user_ratings.movie_id
WHERE language not like '%English%';

--Movies ordered by release year with total number of movies in that year
SELECT DISTINCT title, release_year, COUNT(release_year) 
OVER (PARTITION BY release_year) AS total_year
FROM movies
ORDER BY release_year;

--Average rating and number of all ratings by release year
SELECT DISTINCT  COUNT(release_year) as num_ratings, ROUND(AVG(CAST(rating AS FLOAT)), 2) as avg_rating FROM movies
JOIN user_ratings
ON movies.movie_id = user_ratings.movie_id
GROUP BY release_year;

--Number of ratings by a user
SELECT ur.user_id, username, COUNT(rating) AS num_ratings
FROM user_ratings AS ur
JOIN users AS us
ON ur.user_id = us.user_id
GROUP BY ur.user_id, username
ORDER BY num_ratings DESC;

--Average ratings by user
SELECT ur.user_id, username, ROUND(AVG(CAST(rating AS FLOAT)), 2) AS avg_ratings
FROM user_ratings AS ur
JOIN users AS us
ON ur.user_id = us.user_id
GROUP BY ur.user_id, username
ORDER BY avg_ratings DESC;

--All users who rated movies in the Scream franchise
SELECT DISTINCT users.user_id, username
FROM users
INNER JOIN user_ratings
ON users.user_id = user_ratings.user_id
INNER JOIN movies
ON user_ratings.movie_id = movies.movie_id
WHERE franchise = 'Scream';

-- Reccommendations for users based on similarity in ratings with other users
--User 1:
SELECT  t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
FROM user_ratings t1 INNER JOIN user_ratings t2
ON t1.user_id = 1
AND t2.user_id != 1
INNER JOIN movies t3
ON t2.movie_id = t3.movie_id
AND t3.movie_id NOT IN ( SELECT movies.movie_id
                         FROM movies
						 INNER JOIN user_ratings
						 ON movies.movie_id = user_ratings.movie_id
                         WHERE user_id = 1)
GROUP BY  t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
HAVING AVG(t2.rating) > 3 


--User 2:
SELECT  t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
FROM user_ratings t1 INNER JOIN user_ratings t2
ON t1.user_id = 2
AND t2.user_id != 2
INNER JOIN movies t3
ON t2.movie_id = t3.movie_id
AND t3.movie_id NOT IN ( SELECT movies.movie_id
                         FROM movies
						 INNER JOIN user_ratings
						 ON movies.movie_id = user_ratings.movie_id
                         WHERE user_id = 2)
GROUP BY t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
HAVING AVG(t2.rating) > 3 


--User 3:
SELECT t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
FROM user_ratings t1 INNER JOIN user_ratings t2
ON t1.user_id = 3
AND t2.user_id != 3
INNER JOIN movies t3
ON t2.movie_id = t3.movie_id
AND t3.movie_id NOT IN ( SELECT movies.movie_id
                         FROM movies
						 INNER JOIN user_ratings
						 ON movies.movie_id = user_ratings.movie_id
                         WHERE user_id = 3)
GROUP BY t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
HAVING AVG(t2.rating) > 3 


--User 4:
SELECT t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
FROM user_ratings t1 INNER JOIN user_ratings t2
ON t1.user_id = 4
AND t2.user_id != 4
INNER JOIN movies t3
ON t2.movie_id = t3.movie_id
AND t3.movie_id NOT IN ( SELECT movies.movie_id
                         FROM movies
						 INNER JOIN user_ratings
						 ON movies.movie_id = user_ratings.movie_id
                         WHERE user_id = 4)
GROUP BY t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
HAVING AVG(t2.rating) > 3 

--User 7:
SELECT t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
FROM user_ratings t1 INNER JOIN user_ratings t2
ON t1.user_id = 7
AND t2.user_id != 7
INNER JOIN movies t3
ON t2.movie_id = t3.movie_id
AND t3.movie_id NOT IN ( SELECT movies.movie_id
                         FROM movies
						 INNER JOIN user_ratings
						 on movies.movie_id = user_ratings.movie_id
                         WHERE user_id = 7)
GROUP BY t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
HAVING AVG(t2.rating) > 3 

--User 8:
SELECT t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
FROM user_ratings t1 INNER JOIN user_ratings t2
ON t1.user_id = 8
AND t2.user_id != 8
INNER JOIN movies t3
ON t2.movie_id = t3.movie_id
AND t3.movie_id NOT IN ( SELECT movies.movie_id
                         FROM movies
						 INNER JOIN user_ratings
						 ON movies.movie_id = user_ratings.movie_id
                         WHERE user_id = 8)
GROUP BY t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
HAVING AVG(t2.rating) > 3 

--User 9:
SELECT t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
FROM user_ratings t1 INNER JOIN user_ratings t2
ON t1.user_id = 9
AND t2.user_id != 9
INNER JOIN movies t3
ON t2.movie_id = t3.movie_id
AND t3.movie_id NOT IN ( SELECT movies.movie_id
                         FROM movies
						 INNER JOIN user_ratings
						 ON movies.movie_id = user_ratings.movie_id
                         WHERE user_id = 9)
GROUP BY t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
HAVING AVG(t2.rating) > 3 

--User 10:
SELECT t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
FROM user_ratings t1 INNER JOIN user_ratings t2
ON t1.user_id = 10
AND t2.user_id != 10
INNER JOIN movies t3
ON t2.movie_id = t3.movie_id
AND t3.movie_id NOT IN ( SELECT movies.movie_id
                         FROM movies
						 INNER JOIN user_ratings
						 ON movies.movie_id = user_ratings.movie_id
                         WHERE user_id = 10)
GROUP BY t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
HAVING AVG(t2.rating) > 3 


--User 11:
SELECT t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
FROM user_ratings t1 INNER JOIN user_ratings t2
ON t1.user_id = 11
AND t2.user_id != 11
INNER JOIN movies t3
ON t2.movie_id = t3.movie_id
AND t3.movie_id NOT IN ( SELECT movies.movie_id
                         FROM movies
						 INNER JOIN user_ratings
						 ON movies.movie_id = user_ratings.movie_id
                         WHERE user_id = 11)
GROUP BY t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
HAVING AVG(t2.rating) > 3 

--User 12:
SELECT t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
FROM user_ratings t1 INNER JOIN user_ratings t2
ON t1.user_id = 12
AND t2.user_id != 12
INNER JOIN movies t3
ON t2.movie_id = t3.movie_id
AND t3.movie_id NOT IN ( SELECT movies.movie_id
                         FROM movies
						 INNER JOIN user_ratings
						 on movies.movie_id = user_ratings.movie_id
                         WHERE user_id = 12)
GROUP BY t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
HAVING AVG(t2.rating) > 3 

--User 13:
SELECT t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
FROM user_ratings t1 INNER JOIN user_ratings t2
ON t1.user_id = 13
AND t2.user_id != 13
INNER JOIN movies t3
ON t2.movie_id = t3.movie_id
AND t3.movie_id NOT IN ( SELECT movies.movie_id
                         FROM movies
						 INNER JOIN user_ratings
						 ON movies.movie_id = user_ratings.movie_id
                         WHERE user_id = 13)
GROUP BY t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
HAVING AVG(t2.rating) > 3 















