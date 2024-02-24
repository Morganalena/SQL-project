/* 5. Má výška HDP vliv na změny ve mzdách a cenách potravin? 
Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách 
ve stejném nebo následujícím roce výraznějším růstem?

   5. Does the level of GDP affect changes in wages and food prices?
In other words, if the GDP increases significantly in one year, it will be reflected in food prices or wages
in the same or the following year by more significant growth? 
 */	

WITH GDP_data AS (
    SELECT
        GDP,
        year
    FROM
        t_alena_morgan_project_sql_secondary_final
    WHERE
        country = 'Czech Republic'
),
avg_y_salary AS (
    SELECT
        AVG(averagea_value) AS avg_salary,
        payroll_year 
    FROM
        t_alena_morgan_project_sql_primary_final
    WHERE
        averagea_value IS NOT NULL
    GROUP BY
        payroll_year
),
avg_y_product_value AS (
    SELECT
        avg(product_value) AS avg_product_value,
        date_format(date_from, '%Y') AS year
    FROM
        t_alena_morgan_project_sql_primary_final
    WHERE
        region_code IS NULL 
        AND product_value IS NOT NULL
    GROUP BY
        year
),
y_changes AS (
	SELECT
		gdpd.YEAR,
		gdpd.GDP,
		ays.avg_salary,
		aypv.avg_product_value,
		round(((gdpd.GDP - LAG(gdpd.GDP) OVER (ORDER BY gdpd.year)) / LAG(gdpd.GDP) 
			OVER (ORDER BY gdpd.year) * 100), 1) AS gdp_growth,
	    round(((ays.avg_salary - LAG(ays.avg_salary) OVER (ORDER BY ays.payroll_year)) / LAG(ays.avg_salary) 
	    	OVER (ORDER BY ays.payroll_year) * 100), 1) AS salary_growth,
	    round(((aypv.avg_product_value - LAG(aypv.avg_product_value) 
	    	OVER (ORDER BY aypv.year)) / LAG(aypv.avg_product_value) OVER (ORDER BY aypv.year) * 100), 1) AS food_price_increase
	FROM GDP_data gdpd
	LEFT JOIN avg_y_salary ays
		ON gdpd.year = ays.payroll_year
	LEFT JOIN avg_y_product_value aypv
		ON gdpd.year = aypv.YEAR
)
SELECT 
	YEAR,
	gdp_growth,
	salary_growth,
	food_price_increase,
	CASE
		WHEN gdp_growth > salary_growth AND gdp_growth > food_price_increase THEN 'GDP > salaries and food prices'
		WHEN salary_growth > gdp_growth AND salary_growth > food_price_increase THEN 'salaries > GDP and food prices'
		WHEN food_price_increase > gdp_growth AND food_price_increase > salary_growth THEN 'food prices > GDP and salaries'
		ELSE 'No trend'
	END AS trends
FROM y_changes
WHERE gdp_growth IS NOT NULL 