# LAYOFFS_DATA_PROJECT
Data Cleaning and Exploratory Data Analysis Project
Overview
This project involves cleaning and analyzing a dataset related to layoffs in 2022. The dataset is sourced from Kaggle and contains information on company layoffs, including company name, location, industry, total layoffs, percentage of layoffs, date of the layoffs, stage, country, and funds raised.

#The project is divided into two major sections:

(a).Data Cleaning: This phase focuses on cleaning the data by removing duplicates, handling missing or null values, and standardizing data.
(b).Exploratory Data Analysis (EDA): In this phase, the cleaned data is analyzed to gain insights, identify trends, and create summaries.

#Steps and Implementation
Data Cleaning
01.Remove Duplicates:
Duplicate records are removed using the ROW_NUMBER() function to partition the data based on relevant columns.
Duplicates are deleted by identifying records with a Row_num > 1.

02.Standardize the Data:
Data is standardized by trimming unwanted spaces and fixing inconsistent entries (e.g., normalizing industry names like "Crypto").
Date format standardization: The date column is converted to a proper date format (YYYY-MM-DD).

03.Handling Null or Blank Values:
Records with null or blank values for essential columns like total_laid_off and percentage_laid_off are either updated or deleted as necessary.
Industry information is corrected by updating null or blank values based on related company data.

04.Column Modifications:
Unnecessary columns, like row_num, are dropped after processing.
Data types of columns (e.g., date) are adjusted for consistency.


#Exploratory Data Analysis
After the data cleaning, the dataset is analyzed to extract meaningful insights:

01.Summary Statistics:
The minimum and maximum values of layoffs (both total and percentage) are calculated.
The companies with the highest layoffs are identified.

02.Trends and Analysis:
Companies with 100% layoffs are filtered to explore extreme cases.
The number of layoffs by industry, country, and location is aggregated to identify trends.

03.Time-based Analysis:
The total layoffs per year and per month are calculated, providing insights into seasonal trends.

04.Rolling Total of Layoffs:
A rolling total of layoffs per month is calculated to identify any potential trends over time.

05.Top Companies by Layoffs per Year:
The top three companies with the most layoffs each year are identified.
