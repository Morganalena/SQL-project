CREATE OR REPLACE TABLE t_alena_morgan_project_sql_secondary_final AS
	SELECT
		e.country,
		e.GDP,
		e.gini,
		e.population,
		e.year 
	FROM
		economies e,
		countries c 
	WHERE 1=1
		AND c.country = e.country
		AND YEAR >= 2006 AND YEAR <= 2018 
		AND c.continent = 'Europe'