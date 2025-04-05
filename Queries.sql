-- IMDB Movie Analysis

--Create Database
CREATE DATABASE moviesdb1;
USE moviesdb1;

--Create Tables

-- Movies Table
CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(255),
    industry VARCHAR(255),
    release_year INT,
    imdb_rating FLOAT,
    studio VARCHAR(255),
    language_id INT
);

-- Movie Actor Table
CREATE TABLE movie_actor (
    movie_id INT,
    actor_id INT,
    PRIMARY KEY (movie_id, actor_id)
);

-- Actors Table
CREATE TABLE actors (
    actor_id INT PRIMARY KEY,
    name VARCHAR(255),
    birth_year INT
);

-- Financials Table
CREATE TABLE financials (
    movie_id INT PRIMARY KEY,
    budget FLOAT,
    revenue FLOAT,
    unit VARCHAR(10),
    currency VARCHAR(10)
);

-- Languages Table
CREATE TABLE languages (
    language_id INT PRIMARY KEY,
    name VARCHAR(255)
);

--Load Data

-- Load Movies Data
LOAD DATA INFILE 'movies.csv'
INTO TABLE movies
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(movie_id, title, industry, release_year, imdb_rating, studio, language_id);

-- Load Movie Actor Data
LOAD DATA INFILE 'movie_actor.csv'
INTO TABLE movie_actor
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(movie_id, actor_id);

-- Load Actors Data
LOAD DATA INFILE 'actors.csv'
INTO TABLE actors
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(actor_id, name, birth_year);

-- Load Financials Data
LOAD DATA INFILE 'financials.csv'
INTO TABLE financials
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(movie_id, budget, revenue, unit, currency);

-- Load Languages Data
LOAD DATA INFILE 'languages.csv'
INTO TABLE languages
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(language_id, name);

--Add Foreign Keys
ALTER TABLE movies
ADD CONSTRAINT fk_movies_languages FOREIGN KEY (language_id) REFERENCES languages(language_id);

ALTER TABLE movie_actor
ADD CONSTRAINT fk_movie_actor_movie FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
ADD CONSTRAINT fk_movie_actor_actor FOREIGN KEY (actor_id) REFERENCES actors(actor_id);

ALTER TABLE financials
ADD CONSTRAINT fk_financials_movie FOREIGN KEY (movie_id) REFERENCES movies(movie_id);

-- Queries

-- Q1: Print all movie titles and release year for all Marvel Studios movies?
SELECT title, release_year FROM movies
WHERE studio = 'Marvel Studios';

-- Q2: Print all movies that have Avenger in their name?
SELECT * FROM movies
WHERE title LIKE '%Avenger%';

-- Q3: Print the year in which “The Godfather” movie was released?
SELECT release_year FROM movies
WHERE title = 'The Godfather';

-- Q4: Print all distinct movie studios in Bollywood industry?
SELECT DISTINCT studio FROM movies
WHERE industry = 'Bollywood';

-- Q5: Print all movies in the order of their release year (latest first) ?
SELECT * FROM movies
ORDER BY release_year DESC;

-- Q6: Print all movies released in the year 2022?
SELECT * FROM movies
WHERE release_year = 2022;

-- Q7: Print all the movies released after 2020?
SELECT * FROM movies
WHERE release_year > 2020;

-- Q8: Print all movies after the year 2020 that have more than 8 rating?
SELECT * FROM movies
WHERE release_year > 2020 AND imdb_rating > 8;

-- Q9: Select all movies that are by Marvel studios and Hombale Films?
SELECT * FROM movies
WHERE studio IN ('Marvel Studios', 'Hombale Films');

-- Q10: Q.10) Select all THOR movies by their release year?
SELECT title, release_year FROM movies
WHERE title LIKE '%thor%'
ORDER BY release_year ASC;

-- Q11:  Select all movies that are not from Marvel Studios?
SELECT * FROM movies
WHERE studio != 'Marvel Studios';

-- Q12: How many movies were released between 2015 and 2022?
SELECT COUNT(*)
FROM movies
WHERE release_year BETWEEN 2015 AND 2022;

-- Q13: Print the max and min movie release year?
SELECT MIN(release_year) AS min_year, MAX(release_year) AS max_year
FROM movies;

-- Q14: Print a year and how many movies were released in that year starting with the latest year?
SELECT release_year, COUNT(*) AS movies_count
FROM movies
GROUP BY release_year
ORDER BY release_year DESC;

-- Q15: Print profit % for all the movies
SELECT *,
       (revenue - budget) AS profit,
       ((revenue - budget) * 100 / budget) AS profit_pct
FROM financials;

-- Q16: Show all the movies with their language names
SELECT m.title, l.name
FROM movies m
JOIN languages l
ON m.language_id = l.language_id;

-- Q17: Show all Telugu movie names (assuming you don’t know the language id for Telugu)
SELECT m.title, l.name
FROM movies m
JOIN languages l
ON m.language_id = l.language_id
WHERE l.name = 'Telugu';

-- Q18: Show the language and number of movies released in that language
SELECT l.name, COUNT(m.title) AS total_movies
FROM movies m
JOIN languages l
ON m.language_id = l.language_id
GROUP BY l.name
ORDER BY total_movies DESC;

-- Q19: Generate a report of all Hindi movies sorted by their revenue amount in millions
SELECT m.title, f.revenue, f.currency, f.unit,
       CASE
           WHEN f.unit = 'Thousands' THEN ROUND(f.revenue / 1000, 2)
           WHEN f.unit = 'Billions' THEN ROUND(f.revenue * 1000, 2)
           ELSE f.revenue
       END AS revenue_millions
FROM movies m
JOIN financials f
ON m.movie_id = f.movie_id
JOIN languages l
ON m.language_id = l.language_id
WHERE l.name = 'Hindi'
ORDER BY revenue_millions DESC;

-- Q20: Select all the movies with minimum and maximum release year
SELECT title, release_year
FROM movies
WHERE release_year IN (
    (SELECT MAX(release_year) FROM movies),
    (SELECT MIN(release_year) FROM movies)
)
ORDER BY release_year DESC;

-- Q21: Select all the rows from the movies table whose imdb_rating is higher than the average rating
SELECT *
FROM movies
WHERE imdb_rating > (SELECT AVG(imdb_rating) FROM movies)
ORDER BY imdb_rating DESC;

-- Q22: Select all Hollywood movies released after the year 2000 that made more than 500 million $ profit
WITH x AS (
    SELECT * FROM movies
    WHERE industry = 'Hollywood'
),
y AS (
    SELECT *, ((revenue - budget) * 100 / budget) AS percentage_profit
    FROM financials
    WHERE ((revenue - budget) * 100 / budget) > 500
)
SELECT x.movie_id, x.title, x.release_year, y.percentage_profit
FROM x
JOIN y
ON x.movie_id = y.movie_id
WHERE x.release_year > 2000;
