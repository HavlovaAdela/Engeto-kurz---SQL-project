CREATE TABLE t_adela_havlova_pomocna_evropske_zeme AS
SELECT 
	e.country,
	e.GDP,
	e.gini,
	e.YEAR,
	c.population
FROM economies e
LEFT JOIN countries c
	ON e.country=c.country
WHERE c.continent= 'Europe' AND e.YEAR >2005 AND e.YEAR<2020;


CREATE TABLE t_adela_havlova_sql_project_secondary_final AS
SELECT 
	pez.country,
	pez.population,
	pez.GDP,
	pez.gini,
	pez.YEAR,
	Round((pez2.gini*100/pez.gini)-100,2)AS YEAR_on_year_gini_diff,
	Round((pez2.gdp*100/pez.gdp)-100,2)AS YEAR_on_year_gdp_diff
FROM t_adela_havlova_pomocna_evropske_zeme pez
JOIN t_adela_havlova_pomocna_evropske_zeme pez2
	ON pez2.YEAR= pez.YEAR +1
	AND pez.country=pez2.country;


-- 5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, 
-- projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

CREATE TABLE t_adela_havlova_sjednoceni_primary_secondary AS
SELECT 
	sf.country,
	sf.GDP,
	sf.YEAR,
	sf.YEAR_on_year_gdp_diff,
	pf.YEAR AS 'year2',
	pf.`year-on_year_difference_average_payroll` ,
	pf.year_on_year_diff_average_food 
FROM t_adela_havlova_sql_project_secondary_final sf
JOIN t_adela_havlova_sql_projekt_primary_final pf
	ON sf.YEAR= pf.YEAR;

SELECT * FROM t_adela_havlova_sjednoceni_primary_secondary tahsps
WHERE country='czech republic'
GROUP BY `YEAR` ;

	