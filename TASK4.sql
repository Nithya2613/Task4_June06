CREATE TABLE users (
    identifierHash BIGINT,
    type VARCHAR(50),
    country VARCHAR(100),
    language VARCHAR(10),
    socialNbFollowers INT,
    socialNbFollows INT,
    socialProductsLiked INT,
    productsListed INT,
    productsSold INT,
    productsPassRate FLOAT,
    productsWished INT,
    productsBought INT,
    gender CHAR(1),
    civilityGenderId INT,
    civilityTitle VARCHAR(10),
    hasAnyApp TINYINT(1),
    hasAndroidApp TINYINT(1),
    hasIosApp TINYINT(1),
    hasProfilePicture TINYINT(1),
    daysSinceLastLogin INT,
    seniority INT,
    seniorityAsMonths FLOAT,
    seniorityAsYears FLOAT,
    countryCode VARCHAR(10)
);
SELECT * FROM users LIMIT 10;

#SELECT, WHERE, ORDER BY, GROUP BY
#Display TOTAL USERS from each country
SELECT country, COUNT(*) AS total_users
FROM users
GROUP BY country
ORDER BY total_users DESC;
#Show all users with more than 100 followers (WHERE + ORDER BY)
SELECT identifierHash, socialNbFollowers
FROM users
WHERE socialNbFollowers > 100
ORDER BY socialNbFollowers DESC;

#Subqueries
#Find users who sold above average number of products
SELECT identifierHash, productsSold
FROM users
WHERE productsSold > (
    SELECT AVG(productsSold) FROM users
);

#Aggregate Functions(SUM,AVG)
#Average followers per gender
SELECT gender, AVG(socialNbFollowers) AS avg_followers
FROM users
GROUP BY gender;
#Total products sold by users from the US
SELECT SUM(productsSold) AS total_sold_us
FROM users
WHERE countryCode = 'us';

#Create views for analysis
#Create a view for active users (last login ≤ 15 days)
CREATE VIEW active_users AS
SELECT identifierHash, daysSinceLastLogin, productsSold
FROM users
WHERE daysSinceLastLogin <= 15;
SELECT * FROM active_users;

#Index Optimization
#To improve performance of queries on countryCode and gender, create indexes:
CREATE INDEX idx_country_gender ON users (countryCode, gender);

#Users who listed more than 50 products
SELECT identifierHash, productsListed
FROM users
WHERE productsListed > 50;
#Gender-wise product buying trend
SELECT gender, SUM(productsBought) AS total_bought
FROM users
GROUP BY gender;