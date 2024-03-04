/* 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

   4. Has there been a year in which the year-on-year increase in food prices was significantly higher than wage growth (greater than 10%)?
*/

WITH avg_y_salary AS (
	SELECT
	    AVG(average_value) AS avg_salary,
	    payroll_year 
	FROM
	    t_alena_morgan_project_sql_primary_final
	WHERE
	    average_value IS NOT NULL
	GROUP BY
	    payroll_year
),
avg_y_product_value AS (    
	SELECT
	    AVG(product_value) AS avg_product_value,
	    DATE_FORMAT(date_from, '%Y') AS year
	FROM
	    t_alena_morgan_project_sql_primary_final
	WHERE 1=1
	    AND product_value IS NOT NULL
	GROUP BY
	    YEAR
)
SELECT
	year,
	CASE
        WHEN LAG(aypv.avg_product_value) OVER (ORDER BY aypv.year) IS NULL THEN 'First year'
        ELSE ROUND((aypv.avg_product_value - LAG(aypv.avg_product_value) 
            OVER (ORDER BY aypv.year)) / LAG(aypv.avg_product_value) OVER (ORDER BY aypv.year) * 100, 1)
    END AS food_price_increase,
    CASE
        WHEN LAG(ays.avg_salary) OVER (ORDER BY ays.payroll_year) IS NULL THEN 'First year'
        ELSE ROUND((ays.avg_salary - LAG(ays.avg_salary) 
    		OVER (ORDER BY ays.payroll_year)) / LAG(ays.avg_salary) OVER (ORDER BY ays.payroll_year) * 100, 1)
    END AS salary_growth,
    CASE
        WHEN LAG(aypv.avg_product_value) OVER (ORDER BY aypv.year) IS NULL THEN 'First year'
        ELSE ROUND(((aypv.avg_product_value - LAG(aypv.avg_product_value) OVER (ORDER BY aypv.year)) / LAG(aypv.avg_product_value) OVER (ORDER BY aypv.year) * 100) -
             ((ays.avg_salary - LAG(ays.avg_salary) OVER (ORDER BY ays.payroll_year)) / LAG(ays.avg_salary) OVER (ORDER BY ays.payroll_year) * 100), 1)
    END AS food_price_vs_salary_growth -- indicates whether the increase in food prices is higher (positive) or lower (negative) than the increase in salaries 
FROM avg_y_salary ays
LEFT JOIN avg_y_product_value aypv
	ON ays.payroll_year = aypv.year; 