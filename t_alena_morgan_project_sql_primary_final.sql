CREATE OR REPLACE TABLE t_alena_morgan_project_sql_primary_final
	SELECT
		cp.industry_branch_code,
	    cpib.name,
	    cp.payroll_year,
	    AVG(value) AS average_value,
	    NULL AS product_value,
	    NULL AS category_code,
	    NULL AS category_name,
	    NULL AS date_from,
	    NULL AS date_to
	FROM czechia_payroll cp 
	INNER JOIN czechia_payroll_industry_branch cpib
		ON cpib.code = cp.industry_branch_code
	WHERE 1=1
		AND value_type_code = 5958
		AND calculation_code = 200
		AND payroll_year >=2006
		AND payroll_year <=2018
	GROUP BY 
    	payroll_year, industry_branch_code
    UNION 
    SELECT
	    NULL AS industry_branch_code,
	    NULL AS name,
	    NULL AS payroll_year,
	    NULL AS average_value,
	    cp.value AS product_value,
	    cp.category_code,
	    cpc.name AS category_name,
	    cp.date_from,
	    cp.date_to
	FROM
	    czechia_price cp
	INNER JOIN czechia_price_category cpc 
		ON cpc.code=cp.category_code
	WHERE 1=1
	    AND region_code IS NULL
	    AND date_from >= '2006-01-01'
		AND date_to <= '2018-12-31'
	ORDER BY industry_branch_code, payroll_year, date_from;  