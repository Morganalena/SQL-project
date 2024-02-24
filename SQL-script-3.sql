/* 3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
 
   3. Which food category is increasing in price the slowest (it has the lowest percentage year-on-year increase)?
*/
WITH average_product_value AS (
	SELECT
		avg(product_value) AS a_value,
		category_code,
		category_name,
		date_format(date_from, '%Y') AS date_from1
	FROM t_alena_morgan_project_sql_primary_final tampspf 
	WHERE region_code IS NULL 
		AND product_value IS NOT NULL
	GROUP BY category_code, date_from1 
	ORDER BY category_code, date_from1
),
yoy_increase AS (
	SELECT
		apv.category_code,
	    apv.category_name,
	    apv.date_from1,
	    apv.a_value,
	    (apv.a_value - LAG(apv.a_value) 
	    	OVER (PARTITION BY apv.category_code ORDER BY apv.date_from1)) / LAG(apv.a_value) 
	    	OVER (PARTITION BY apv.category_code ORDER BY apv.date_from1) * 100 AS year_over_year_increase
	FROM average_product_value apv
)
SELECT
    round(avg(year_over_year_increase),1) AS average_yoy_increase, -- results IN %
	category_name
FROM
    yoy_increase yi
GROUP BY category_code
ORDER BY average_yoy_increase;