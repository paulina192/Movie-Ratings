-- Recommendations for users based on similarity in ratings with other users
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
ORDER BY release_year


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
HAVING AVG(t2.rating) > 3.5 

--User 5:
SELECT t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
FROM user_ratings t1 INNER JOIN user_ratings t2
ON t1.user_id = 5
AND t2.user_id != 5
INNER JOIN movies t3
ON t2.movie_id = t3.movie_id
AND t3.movie_id NOT IN ( SELECT movies.movie_id
                         FROM movies
			 INNER JOIN user_ratings
			 ON movies.movie_id = user_ratings.movie_id
                         WHERE user_id = 5)
GROUP BY t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
HAVING AVG(t2.rating) > 3.5 

--User 6:
SELECT t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
FROM user_ratings t1 INNER JOIN user_ratings t2
ON t1.user_id = 6
AND t2.user_id != 6
INNER JOIN movies t3
ON t2.movie_id = t3.movie_id
AND t3.movie_id NOT IN ( SELECT movies.movie_id
                         FROM movies
			 INNER JOIN user_ratings
			 ON movies.movie_id = user_ratings.movie_id
                         WHERE user_id = 6)
GROUP BY t3.title, t3.director, t3.genre, t3.running_time, t3.language, t3.release_year
HAVING AVG(t2.rating) > 3 
ORDER BY running_time	

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
ORDER BY running_time 

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
HAVING AVG(t2.rating) > 3.5 

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
ORDER BY release_year DESC;

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
ORDER BY running_time

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
			 ON movies.movie_id = user_ratings.movie_id
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
ORDER BY release_year DESC;
