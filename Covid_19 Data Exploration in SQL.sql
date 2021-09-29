/* COVID-19 Data Exploration */
/* Dataset Source: World Data */

-- ------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------------
## Load the data 
SELECT* FROM portfolio_projects.cv19_deaths
WHERE continent is NOT NULL
ORDER BY continent DESC;

-- -----------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------
## Select the data to be examined
-- ------------------------------------------------------------------------------------------------------------------
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM portfolio_projects.cv19_deaths
WHERE continent IS NOT NULL
ORDER BY location AND date
LIMIT 5;

-- --------------------------------------------------------------------------------------------------------------------
## Let's look at Total Cases and Total Deaths
## Shows the likelihood of dying if someone contracted covid in UK
-- ---------------------------------------------------------------------------------------------------------------------
SELECT location, date, total_cases, new_cases, total_deaths,(total_deaths/total_cases)*100 as DeathPercent
FROM portfolio_projects.cv19_deaths
WHERE continent IS NOT NULL AND location LIKE '%kingdom%'
ORDER BY location AND date;

-- -----------------------------------------------------------------------------------------------------------------------
## Total Cases versus Population
## Shows what percentage of population is infected with Covid
-- -----------------------------------------------------------------------------------------------------------------------
SELECT location, date, total_cases, population, (total_cases/population)*100 as percent_population_infected
FROM portfolio_projects.cv19_deaths
GROUP BY location
ORDER BY percent_population_infected DESC;

-- -----------------------------------------------------------------------------------------------------------------------
##  Countries with Highest Infection Rate compared to Population
-- ----------------------------------------------------------------------------------------------------------------------
SELECT location, population, MAX(total_cases) as highest_infection_counts, 
MAX((total_cases/population)) as percent_pop_infected
FROM portfolio_projects.cv19_deaths
GROUP BY location
ORDER BY percent_pop_infected DESC;

-- -----------------------------------------------------------------------------------------------------------------------
## Countries with highest death count per population
-- ----------------------------------------------------------------------------------------------------------------------
SELECT location, Max(CONVERT(total_deaths, UNSIGNED INT)) as total_death_count
FROM portfolio_projects.cv19_deaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY total_death_count DESC;

-- ----------------------------------------------------------------------------------------------------------------------
## Show Continent with the Highest Death Counts per Population
-- ----------------------------------------------------------------------------------------------------------------------
SELECT continent, MAX(CONVERT(total_deaths, UNSIGNED INT)) as total_death_counts
FROM portfolio_projects.cv19_deaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY total_death_counts DESC;

-- -----------------------------------------------------------------------------------------------------------------------
## Look at the numbers across the world
-- ----------------------------------------------------------------------------------------------------------------------
SELECT SUM(new_cases) as total_cases, SUM(CONVERT(new_deaths, UNSIGNED INT)) as total_deaths, 
SUM(CONVERT(new_deaths, UNSIGNED INT))/SUM(New_Cases)*100 as DeathPercentage
FROM portfolio_projects.cv19_deaths
WHERE continent IS NOT NULL
ORDER BY total_cases, total_deaths;

-- ----------------------------------------------------------------------------------------------------------------------
## Total Population versus Vaccinations
## Displays Percentage of Population that has recieved at least one Covid Vaccine
-- -----------------------------------------------------------------------------------------------------------------------
SELECT d.continent, d.location, d.date, d.population, sum(v.new_vaccinations) as total_new_vaccinations,
round(SUM(v.new_vaccinations)/SUM(d.population)*100,2) as percent_people_vaccinated
FROM cv19_deaths d INNER JOIN cv19_vac v
ON d.location = v.location
AND d.date = v.date
WHERE d.continent IS NOT NULL
ORDER BY d.location;

-- ---------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------



