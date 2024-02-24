/* 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
 
   1. Over the years, are wages rising in all industries, or falling in some?
 */
-- from primary table
WITH avg_salary AS (
    SELECT
        industry_branch_code,
		name,
    	payroll_year,
        ROUND(AVG(averagea_value), 2) AS avg_salary, -- děleno počtem čtvrdletí, aby byl spočten průměr kvartálních průměrů
        LAG(ROUND(AVG(averagea_value), 2)) OVER (PARTITION BY industry_branch_code ORDER BY payroll_year) AS prev_year_avg_salary
    FROM
        t_alena_morgan_project_SQL_primary_final
    WHERE
        payroll_year IS NOT NULL
    GROUP BY
        industry_branch_code, payroll_year 
    ORDER BY
        industry_branch_code, payroll_year 	-- v roce 2021 jsou započítány pouze 2 čtvrtdletí
)
SELECT
    industry_branch_code,
	name,
	payroll_year,
    avg_salary,
    CASE
        WHEN prev_year_avg_salary IS NULL THEN 'First year'
        WHEN avg_salary > prev_year_avg_salary THEN 'Increase'
        WHEN avg_salary < prev_year_avg_salary THEN 'Decrease'
        ELSE 'No Change'
    END AS trend
FROM
    avg_salary;