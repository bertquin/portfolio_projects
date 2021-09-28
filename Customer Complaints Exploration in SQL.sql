-- CUSTOMER COMPLAINTS DATA EXPLORATION 
-- Dataset acquired from Kaggle.com 
-- -----------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------------------
## 
-- --------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------
## Load the data
SELECT *
FROM portfolio_projects.user_complaints
# Examine the first 5 rows
LIMIT 5;

-- ----------------------------------------------------------------------------------------------------------------
## 1. How does consumer complaints vary with company prouducts?
-- --------------------------------------------------------------------------------------------------------------------
SELECT product, count(issue) as no_of_complaints
FROM portfolio_projects.user_complaints
WHERE issue is not null
GROUP BY product
ORDER BY 2 DESC;

-- --------------------------------------------------------------------------------------------------------------------
## 2. What is the average new complaints filed each day of the month?
-- -------------------------------------------------------------------------------------------------------------------
SELECT date_received, round(count(complaint_id)/30,2) as daily_average_complaints
FROM portfolio_projects.user_complaints
GROUP BY date_received
ORDER BY 1 ASC;

-- -------------------------------------------------------------------------------------------------------------------
## 3. Which customer segment reported the most complaints?
-- --------------------------------------------------------------------------------------------------------------------
SELECT state, count(issue) as issue_counts
FROM portfolio_projects.user_complaints
WHERE state IS NOT NULL
GROUP BY state
ORDER BY issue_counts DESC;

-- -------------------------------------------------------------------------------------------------------------------
## 4. What is the most preferred channel for complaints?
-- --------------------------------------------------------------------------------------------------------------------
SELECT submitted_via, count(DISTINCT complaint_id) as counts
FROM portfolio_projects.user_complaints
WHERE submitted_via IS NOT NULL
GROUP BY submitted_via
ORDER BY 2 DESC;

-- --------------------------------------------------------------------------------------------------------------------
## 5. How many customers in Florida, California, and Texas filed complaints through company site?
-- --------------------------------------------------------------------------------------------------------------------
SELECT state, submitted_via,count(DISTINCT complaint_id) as frequency
FROM portfolio_projects.user_complaints
WHERE state = 'CA' AND submitted_via = 'Web'
UNION  SELECT state, submitted_via,count(DISTINCT complaint_id) as frequency
FROM portfolio_projects.user_complaints
WHERE state = 'TX' AND submitted_via = 'Web'
UNION SELECT state, submitted_via,count(DISTINCT complaint_id) as frequency
FROM portfolio_projects.user_complaints
WHERE state = 'FL' AND submitted_via = 'Web'
ORDER BY frequency DESC;

-- ------------------------------------------------------------------------------------------------------------------
## 6. Let's look at which company recorded the most complaints?
-- ------------------------------------------------------------------------------------------------------------------
SELECT company, COUNT(DISTINCT complaint_id) as customer_counts
FROM portfolio_projects.user_complaints
GROUP BY company
ORDER BY customer_counts DESC
LIMIT 5;

-- --------------------------------------------------------------------------------------------------------------------
## 7. Which company resolved the most customer issues?
-- ---------------------------------------------------------------------------------------------------------------------
SELECT company, count(company_response_to_consumer) as cases_closed
FROM portfolio_projects.user_complaints
WHERE company_response_to_consumer='Closed with explanation'
GROUP BY company 
HAVING count(company_response_to_consumer) >= 100 
ORDER BY cases_closed DESC;

-- ---------------------------------------------------------------------------------------------------------------------
## 8. Which day recorded the most consumer complaint resolution on average?
-- --------------------------------------------------------------------------------------------------------------------
SELECT date_received, count(company_response_to_consumer)/30 as daily_average_resolution_counts
FROM portfolio_projects.user_complaints
WHERE company_response_to_consumer='Closed with explanation'
GROUP BY date_received
ORDER BY daily_average_resolution_counts DESC;

-- ----------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------
