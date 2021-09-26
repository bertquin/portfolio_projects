-- DATA EXPLORATION OF CALIFORNIA HOUSE PRICES
-- Dataset Source: Kaggle

-- ---------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------
# Load the data in
SELECT * 
FROM portfolio_projects.cal_hse_price;

-- ---------------------------------------------------------------------------------------------
## How does price difference vary with the location of a property?
-- -----------------------------------------------------------------------------------------------
SELECT ocean_proximity as location, MAX(median_house_value)- MIN(median_house_value) as price_difference
FROM portfolio_projects.cal_hse_price
GROUP BY location
ORDER BY price_difference DESC;

-- ---------------------------------------------------------------------------------------------------
## What is the cost per room in relation to location?
-- ---------------------------------------------------------------------------------------------------
SELECT ocean_proximity as location, (median_house_value/total_rooms) as cost_per_room, 
(median_house_value/total_bedrooms) as cost_per_bedroom
FROM portfolio_projects.cal_hse_price
GROUP BY location
ORDER BY cost_per_room DESC;

-- ----------------------------------------------------------------------------------------------------
## Let's look at how much the new houses within a hours' drive from the ocean cost?
-- -------------------------------------------------------------------------------------------------------
SELECT ocean_proximity, min(housing_median_age) as new_house, median_house_value as price
FROM portfolio_projects.cal_hse_price
GROUP BY ocean_proximity
ORDER BY ocean_proximity DESC;

-- ---------------------------------------------------------------------------------------------------------
-- Do houses in a densely populated area command higher price than less congested areas?
-- ----------------------------------------------------------------------------------------------------------
SELECT population, median_house_value as price
FROM portfolio_projects.cal_hse_price
WHERE population = (select max(population) 
FROM portfolio_projects.cal_hse_price)
UNION SELECT population, median_house_value as price
FROM portfolio_projects.cal_hse_price
WHERE population = (select MIN(population) 
FROM portfolio_projects.cal_hse_price);

-- -----------------------------------------------------------------------------------------------------------------
-- How does the income per person affect the choice of location of a property?
-- ------------------------------------------------------------------------------------------------------------------
SELECT ocean_proximity as location, round((median_income)/(population),4) as income_per_person
FROM portfolio_projects.cal_hse_price
GROUP BY location
ORDER BY income_per_person DESC;

## ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
