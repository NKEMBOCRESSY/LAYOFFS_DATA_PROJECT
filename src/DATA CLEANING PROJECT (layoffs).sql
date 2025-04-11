-- DATA CLEANING PROJECT
-- https://www.kaggle.com/datasets/swaptr/layoffs-2022

-- STEPS
-- 01. Remove duplicate
-- Standardize the data
-- Remove null values
-- remove unnecessary rows or column
 
 
USE world_layoffs_1;
 DROP TABLE layoffs_staging;
 
 USE world_layoffs_1;
 CREATE TABLE layoffs_staging
 LIKE layoffs;

SELECT*
FROM layoffs_staging;

INSERT layoffs_staging
SELECT*
FROM layoffs;

SELECT*
FROM layoffs_staging;

-- Remove duplicate
SELECT*,
ROW_NUMBER() OVER (
PARTITION BY company,location,industry,total_laid_off, percentage_laid_off, `date`, stage,country,funds_raised_millions) AS Row_num
FROM  world_layoffs_1.layoffs_staging;

WITH dupliacte_cte AS(
SELECT*,
ROW_NUMBER() OVER (
PARTITION BY company,location,industry,total_laid_off, percentage_laid_off, `date`, stage,country,funds_raised_millions) AS Row_num
FROM  world_layoffs_1.layoffs_staging
)
SELECT* 
FROM dupliacte_cte
WHERE Row_num > 1;

SELECT*
FROM  world_layoffs_1.layoffs_staging
WHERE company = 'Casper';


-- IT will not delete until you create the new table
WITH dupliacte_cte AS(
SELECT*,
ROW_NUMBER() OVER (
PARTITION BY company,location,industry,total_laid_off, percentage_laid_off, `date`, stage,country,funds_raised_millions) AS Row_num
FROM  world_layoffs_1.layoffs_staging
)
DELETE
FROM dupliacte_cte
WHERE Row_num > 1;






CREATE TABLE `layoffs_staging2` (
`company`text ,
`location` text, 
`industry` text ,
`total_laid_off` int,
`percentage_laid_off` text ,
`date`text, 
`stage` text ,
`country` text, 
`funds_raised_millions` int,
`row_num` INT
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT*
FROM  world_layoffs_1.layoffs_staging2


INSERT INTO layoffs_staging2
SELECT*,
ROW_NUMBER() OVER (
PARTITION BY company,location,industry,total_laid_off, percentage_laid_off, `date`, stage,country,funds_raised_millions) AS Row_num
FROM  world_layoffs_1.layoffs_staging;

SELECT*
FROM  world_layoffs_1.layoffs_staging2
WHERE Row_num >1;

-- delete duplicate
DELETE
FROM  world_layoffs_1.layoffs_staging2
WHERE Row_num >1;

SELECT*
FROM  world_layoffs_1.layoffs_staging2
WHERE Row_num >1;

SELECT*
FROM  world_layoffs_1.layoffs_staging2

-- Standardizing data(finding issues in data and fxing them)
SELECT company,TRIM(company)
FROM  world_layoffs_1.layoffs_staging2;

UPDATE layoffs_staging2
SET company =  TRIM(company);

SELECT DISTINCT industry
FROM  world_layoffs_1.layoffs_staging2
ORDER BY 1;


SELECT*
FROM  world_layoffs_1.layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto';

SELECT DISTINCT industry
FROM  world_layoffs_1.layoffs_staging2;


SELECT DISTINCT location
FROM  world_layoffs_1.layoffs_staging2
order by 1;

SELECT DISTINCT country
FROM  world_layoffs_1.layoffs_staging2
order by 1;

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM  world_layoffs_1.layoffs_staging2
order by 1;


UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';



SELECT `date`,
str_to_date(`date`, '%m/%d/%Y')
FROM  world_layoffs_1.layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = str_to_date(`date`, '%m/%d/%Y');

SELECT `date`
FROM  world_layoffs_1.layoffs_staging2;


-- DO THIS I A WORKING TABLE
  ALTER TABLE layoffs_staging2
  MODIFY COLUMN `date` DATE;
  
  
SELECT *
FROM layoffs_staging2;



-- NULLS/BLANK VALUES
SELECT *
FROM layoffs_staging2 
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

SELECT*
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';


SELECT*
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
    AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;
  

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL)
AND t2.industry IS NOT NULL;

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%';


SELECT *
FROM layoffs_staging2 
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging2 
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

ALTER table layoffs_staging2 
DROP COLUMN row_num;

SELECT *
FROM layoffs_staging2 
