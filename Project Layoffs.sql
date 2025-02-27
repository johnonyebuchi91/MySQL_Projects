DROP TABLE IF EXISTS layoffs_1;
CREATE TABLE layoffs_1
LIKE world_layoffs;

INSERT INTO layoffs_1
SELECT*
FROM world_layoffs;

SELECT*
FROM layoffs_1;

SELECT*,
ROW_NUMBER() OVER(PARTITION BY company, 
location, industry, total_laid_off, percentage_laid_off,
 `date`, stage, country, 
 funds_raised
 ORDER BY company) AS Row_Num
FROM layoffs_1;

WITH duplicate_cte AS (
SELECT*,
ROW_NUMBER() OVER(
PARTITION BY company, 
location, industry, total_laid_off, percentage_laid_off,
 `date`, stage, country, 
 funds_raised
 ORDER BY company) AS Row_Num
FROM layoffs_1
)
SELECT*
FROM duplicate_cte
WHERE Row_Num > 1;

CREATE TABLE `layoffs_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` text,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised` int DEFAULT NULL,
  `Row_Num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_2
SELECT*,
ROW_NUMBER() OVER(
PARTITION BY company, 
location, total_laid_off, percentage_laid_off,
 `date`, stage, country, 
 funds_raised) AS Row_Num
FROM layoffs_1;

DELETE
FROM layoffs_2
WHERE Row_Num > 1;

SELECT*
FROM layoffs_2;

SELECT company, (trim(company))
From layoffs_2;

UPDATE layoffs_2
SET company = TRIM(company);

SELECT DISTINCT (industry)
FROM layoffs_2
ORDER BY 1;

SELECT DISTINCT (country)
FROM layoffs_2
ORDER BY 1;

SELECT `date`, 
str_to_date(`date`, '%m/%d/%Y')
FROM layoffs_2;

UPDATE layoffs_2
SET `date` = str_to_date(`date`, '%m/%d/%Y');

SELECT `date`
FROM layoffs_2;

ALTER TABLE layoffs_2
MODIFY COLUMN `date` DATE;

SELECT COUNT(percentage_laid_off) AS Null_Percentage
FROM layoffs_2
WHERE percentage_laid_off is null;

SELECT COUNT(total_laid_off) AS Null_Total
FROM layoffs_2
WHERE total_laid_off is null;

SELECT DISTINCT percentage_laid_off,total_laid_off
FROM layoffs_2;

SELECT COUNT(percentage_laid_off)
FROM layoffs_2
WHERE percentage_laid_off = ''
;

SELECT COUNT(total_laid_off)
FROM layoffs_2
WHERE total_laid_off = '';

SELECT*
FROM layoffs_2
WHERE percentage_laid_off = ''
AND total_laid_off = ''
;

SELECT COUNT(industry)
FROM layoffs_2
WHERE industry = NULL
;

UPDATE layoffs_2
SET industry = null
WHERE industry = '';


SELECT DISTINCT company, industry
FROM Layoffs_2
where industry = ''
or industry is null;


SELECT*
FROM layoffs_2
WHERE company = 'Appsmith';

SELECT*
FROM layoffs_2
WHERE total_laid_off = ''
AND percentage_laid_off = '';


UPDATE layoffs_2
SET total_laid_off = null
WHERE total_laid_off = '';

UPDATE layoffs_2
SET percentage_laid_off = null
WHERE percentage_laid_off = '';

SELECT DISTINCT(company), percentage_laid_off, total_laid_off
FROM layoffs_2
WHERE percentage_laid_off is NULL
AND total_laid_off is NULL;

DELETE 
FROM layoffs_2
WHERE percentage_laid_off is NULL
AND total_laid_off is NULL;

SELECT*
FROM layoffs_2;

ALTER TABLE layoffs_2
DROP COLUMN Row_Num;