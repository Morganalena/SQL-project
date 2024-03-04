/*  2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první 
 		a poslední srovnatelné období v dostupných datech cen a mezd? 
 		
 	2. How many liters of milk and kilograms of bread can be bought in the first 
 		and last comparable periods in the available price and wage data?
 */ 
WITH bread_milk AS (   
	SELECT
		category_code,
		category_name,
		ROUND(AVG(product_value),2) AS average_value,
		YEAR(date_from) AS date_year
	FROM t_alena_morgan_project_sql_primary_final tampspf 
	WHERE 1=1
		AND category_code IS NOT NULL
		AND category_code IN (111301, 114201)
		AND YEAR(date_from) IN (2006, 2018)
	GROUP BY category_code, date_format(date_from, '%Y')
	ORDER BY category_code, date_from
)
SELECT
    date_year,
	category_name,
    average_value AS average_category_value,
	ROUND(AVG(averagea_salary_value),2) AS average_salary,
	ROUND((AVG(averagea_salary_value)/average_value),0) AS amount_of_products
FROM bread_milk
INNER JOIN (SELECT 
				payroll_year,
				ROUND(SUM(average_value) / COUNT(*),0) AS averagea_salary_value
			FROM
			  (SELECT
			        industry_branch_code,
			        payroll_year,
			        average_value
			    FROM t_alena_morgan_project_sql_primary_final tampspf 
			    WHERE industry_branch_code IS NOT NULL
			        AND payroll_year IN (2006, 2018)
			    GROUP BY industry_branch_code, payroll_year) AS subquery
			GROUP BY payroll_year) AS subquery2  
ON date_year = subquery2.payroll_year
GROUP BY category_name, date_year;