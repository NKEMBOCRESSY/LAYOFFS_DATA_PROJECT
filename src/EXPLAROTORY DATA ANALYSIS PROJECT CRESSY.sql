-- EXPLAROTORY DATA ANALYSIS PROJECT
-- The data used are data obtained after the data cleaning project then we explore them

SELECT * 
FROM world_layoffs_1.layoffs_staging2;

SELECT MIN(total_laid_off),MIN(percentage_laid_off)
FROM world_layoffs_1.layoffs_staging2;

SELECT MAX(total_laid_off),MAX(percentage_laid_off)
FROM world_layoffs_1.layoffs_staging2;

-- Looking at Percentage to see how big these layoffs were
SELECT MAX(percentage_laid_off),  MIN(percentage_laid_off)
FROM world_layoffs_1.layoffs_staging2
WHERE  percentage_laid_off IS NOT NULL;

-- Which companies had 1 which is basically 100 percent of they company laid off
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE  percentage_laid_off = 1;

SELECT *
FROM world_layoffs_1.layoffs_staging2
WHERE  percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;
-- COMPANY WITH THE MOST LAYOFFS
SELECT company,SUM(total_laid_off)
FROM world_layoffs_1.layoffs_staging2
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;

SELECT industry,SUM(total_laid_off)
FROM world_layoffs_1.layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC
LIMIT 10;


SELECT YEAR(`date`),SUM(total_laid_off)
FROM world_layoffs_1.layoffs_staging2
GROUP BY YEAR (`date`)
ORDER BY 2 DESC;


SELECT company,SUM(percentage_laid_off)
FROM world_layoffs_1.layoffs_staging2
GROUP BY company
ORDER BY 2 DESC
;

SELECT industry,SUM(percentage_laid_off)
FROM world_layoffs_1.layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC
;
SELECT YEAR(`date`),SUM(percentage_laid_off)
FROM world_layoffs_1.layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 2 DESC
;


SELECT stage, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;


-- by location
SELECT location, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY location
ORDER BY 2 DESC;


SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY `MONTH`
HAVING `MONTH` IS NOT NULL
ORDER BY `MONTH` ASC;

-- ALTENATIVELY
SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY SUBSTRING(`date`, 1, 7)
ORDER BY SUBSTRING(`date`, 1, 7) ASC
;


-- Rolling Total of Layoffs Per Month
SELECT*
FROM world_layoffs.layoffs_staging2;

WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off) AS Total_off
FROM world_layoffs_1.layoffs_staging2
GROUP BY `MONTH`
HAVING `MONTH` IS NOT NULL
ORDER BY `MONTH` ASC
)
SELECT  `MONTH`, SUM(Total_off)
FROM Rolling_Total
GROUP BY `MONTH`  --  Add GROUP BY here
ORDER BY `MONTH` ASC;

-- altenatively
WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off) AS Total_off
FROM world_layoffs_1.layoffs_staging2
GROUP BY `MONTH`
HAVING `MONTH` IS NOT NULL
ORDER BY `MONTH` ASC
)
SELECT  `MONTH`,Total_off,
SUM(Total_off) OVER(ORDER BY `MONTH`) AS Rolling_total
FROM Rolling_Total;




WITH Company_Year(company,years, total_laid_off) AS 
(
  SELECT company, YEAR(`date`) AS years, SUM(total_laid_off) AS total_off
  FROM world_layoffs_1.layoffs_staging2
  GROUP BY company, YEAR(`date`)
)
, Company_Year_Rank AS (
  SELECT company, years, total_laid_off, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM Company_Year
)
SELECT company, years, total_laid_off, ranking
FROM Company_Year_Rank
WHERE ranking <= 3
AND years IS NOT NULL
ORDER BY years ASC, total_laid_off DESC;