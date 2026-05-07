/*
This script cleans a raw dataset of global layoffs (2020-2023). 
The goal is to provide a reliable dataset for later Exploratory Data Analysis (EDA).
*/


-- 1. Create Staging Environment to Preserve Raw Data in Case of Errors
CREATE TABLE layoffs_staging
LIKE layoffs;

INSERT layoffs_staging
SELECT *
FROM layoffs;

-- 2. Identify and Remove Duplicates
-- Since the data lacks a unique ID, I used ROW_NUMBER() to identify identical rows.
-- I created a second staging table to filter and delete duplicates safely.

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

-- Deleting rows where the same data appears more than once.
DELETE
FROM layoffs_staging2
WHERE row_num > 1;

-- 3. Standardizing Data
-- Fixing inconsistent strings and formatting issues.

-- Trim trailing spaces from company names
UPDATE layoffs_staging2
SET company = TRIM(company);

-- Consolidate variations of 'Crypto' industry
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Standardize 'United States' (removing trailing periods)
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- Convert 'date' column from text to a proper DATE format
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- 4. Handling Nulls & Blank Values
-- Filling in 'industry' gaps by looking at other entries for the same company.

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- 5. Final Cleanup
-- Removing data that is too incomplete to be useful for analysis.
DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Drop the row_num column used for duplicate detection
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

-- Final check of the cleaned data
SELECT *
FROM layoffs_staging2;
