# IMDB-Movie-Analysis-
[Dataset Link](https://docs.google.com/spreadsheets/d/1in1xkssJYKpXloGGQaMTcfaAwYx3mSoM/edit?gid=839469216#gid=839469216)

## Database Structure

The database consists of the following tables:

1. **`movies`**: Stores movie details such as the title, release year, IMDb rating, studio, and language.
2. **`actors`**: Stores actor details, including their name and birth year.
3. **`movie_actor`**: A relationship table that connects movies to actors.
4. **`financials`**: Stores financial data for each movie, including budget, revenue, and currency.
5. **`languages`**: Stores language details used in the movies.

### Table Schemas

#### `movies` Table
- `movie_id` (INT): Primary key, unique identifier for each movie.
- `title` (VARCHAR): The movie's title.
- `industry` (VARCHAR): The movie industry (e.g., Hollywood, Bollywood).
- `release_year` (INT): The year the movie was released.
- `imdb_rating` (FLOAT): The IMDb rating of the movie.
- `studio` (VARCHAR): The studio that produced the movie.
- `language_id` (INT): Foreign key linking to the `languages` table.

#### `actors` Table
- `actor_id` (INT): Primary key, unique identifier for each actor.
- `name` (VARCHAR): The actor's name.
- `birth_year` (INT): The actor's birth year.

#### `movie_actor` Table
- `movie_id` (INT): Foreign key referencing `movies.movie_id`.
- `actor_id` (INT): Foreign key referencing `actors.actor_id`.

#### `financials` Table
- `movie_id` (INT): Foreign key referencing `movies.movie_id`.
- `budget` (FLOAT): The budget of the movie.
- `revenue` (FLOAT): The revenue earned by the movie.
- `unit` (VARCHAR): The unit of the financial values (e.g., Thousands, Millions, Billions).
- `currency` (VARCHAR): The currency of the financial values.

#### `languages` Table
- `language_id` (INT): Primary key, unique identifier for each language.
- `name` (VARCHAR): The name of the language.

## Data Loading

- `movies.csv`: Contains movie details.
- `movie_actor.csv`: Contains relationships between movies and actors.
- `actors.csv`: Contains actor details.
- `financials.csv`: Contains movie financial details.
- `languages.csv`: Contains language details.

## Foreign Keys
- `movies.language_id` references `languages.language_id`.
- `movie_actor.movie_id` references `movies.movie_id`.
- `movie_actor.actor_id` references `actors.actor_id`.
- `financials.movie_id` references `movies.movie_id`.

## Queries
1. **Marvel Studios Movies**: Lists all movies produced by Marvel Studios.
2. **Movies with "Avenger" in Title**: Lists all movies with "Avenger" in their title.
3. **The Godfather Release Year**: Retrieves the release year of "The Godfather."
4. **Bollywood Studios**: Lists all distinct movie studios in the Bollywood industry.
5. **Movies by Release Year**: Lists all movies in descending order by their release year.
6. **Movies Released in 2022**: Lists all movies released in the year 2022.
7. **Movies with IMDB Rating Above 8 (Post-2020)**: Lists movies released after 2020 with an IMDb rating greater than 8.
8. **Movies by Marvel Studios & Hombale Films**: Lists movies from either Marvel Studios or Hombale Films.
9. **THOR Movies**: Lists all movies with "Thor" in the title, ordered by release year.
10. **Non-Marvel Studios Movies**: Lists all movies that are not from Marvel Studios.
11. **Movies Between 2015-2022**: Counts movies released between 2015 and 2022.
12. **Minimum and Maximum Movie Release Year**: Retrieves the earliest and latest movie release years.
13. **Movies Released by Year**: Counts movies released each year, starting from the latest year.
14. **Profit Calculation**: Calculates the profit and profit percentage for each movie.
15. **Movies with Language Names**: Shows movie titles alongside their language names.
16. **Telugu Movies**: Lists movies in the Telugu language.
17. **Movies Count by Language**: Counts the number of movies released in each language.
18. **Hindi Movies Sorted by Revenue**: Lists Hindi movies sorted by their revenue in millions.
19. **Movies with Minimum and Maximum Release Year**: Lists movies released in the earliest and latest years.
20. **Movies Above Average IMDb Rating**: Lists movies with an IMDb rating higher than the average rating.
21. **Hollywood Movies After 2000 with High Profit**: Lists Hollywood movies after 2000 that earned more than 500% profit.

## Usage
1. Ensure you have a MySQL server set up.
2. Create the database and tables using the provided SQL script.
3. Import the data using the `LOAD DATA INFILE` commands (ensure your CSV files are correctly formatted and accessible).
4. Use the queries to analyze the movie data as per your requirements.
