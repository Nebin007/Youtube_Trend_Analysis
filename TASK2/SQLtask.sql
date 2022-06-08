/*Creating the table*/
CREATE TABLE categories ( category_id INT PRIMARY KEY, category_id_lvl_0 INT, category_id_lvl_1 INT, category_id_lvl_2 INT, 
category_title_lvl_0 VARCHAR(30), category_title_lvl_1 VARCHAR(30),category_title_lvl_2 VARCHAR(30));

/*Loading the dataset to database*/
LOAD DATA INFILE 'categories.csv'
 INTO TABLE categories
 FIELDS TERMINATED BY ';'
 ENCLOSED BY '"'
 LINES TERMINATED BY '\n'
 IGNORE 1 ROWS;
 
/* Find number of unique category ids */
SELECT COUNT(DISTINCT category_id_lvl_0)+ 
COUNT(DISTINCT category_id_lvl_1)+ 
COUNT(DISTINCT category_id_lvl_2) AS "Sum of Unique categories" FROM categories;

/*Find Total Categories with & */
SELECT (SELECT COUNT(DISTINCT category_title_lvl_0) 
FROM categories
WHERE category_title_lvl_0 LIKE "%&%") +
(SELECT COUNT(DISTINCT category_title_lvl_1) 
FROM categories
WHERE category_title_lvl_1 LIKE "%&%") +
(SELECT COUNT(DISTINCT category_title_lvl_2) 
FROM categories
WHERE category_title_lvl_2 LIKE "%&%")
AS "Total Categories with &";


/*Find sum of categories for each category*/
SELECT category_id_lvl_0, 
COUNT(DISTINCT category_id_lvl_1) AS "Total lvl 1",
COUNT(DISTINCT category_id_lvl_2) AS "Total lvl 2"
FROM categories GROUP by category_id_lvl_0;

/*List all categories that have only level 0 category and no subcategories*/
SELECT * FROM categories 
WHERE category_id_lvl_1 = 0 
AND category_id_lvl_2 = 0
AND category_id_lvl_0 <> 0;

