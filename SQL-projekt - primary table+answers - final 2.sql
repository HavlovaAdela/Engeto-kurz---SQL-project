CREATE TABLE t_adela_havlova_pomocna_mzdy AS
SELECT
	cp.industry_branch_code,
	cp.payroll_year,
	ROUND(AVG(cp.value),0) AS average_payroll_value,
	cpib.name AS industry_branch_name
FROM czechia_payroll cp
JOIN czechia_payroll_industry_branch cpib 
	ON cp.industry_branch_code=cpib.code
WHERE cp.value_type_code =5958 AND cp.unit_code =200 AND cp.calculation_code =200 AND cp.industry_branch_code IS NOT NULL AND cp.payroll_year >2005 AND cp.payroll_year <2019
    GROUP BY cp.payroll_year , cp.industry_branch_code ;
   

CREATE TABLE t_adela_havlova_prubezna_mzdy AS
SELECT 
	pm.industry_branch_code ,
	pm.industry_branch_name,
	pm.payroll_year,
	pm2.payroll_year AS next_payroll_year,
	pm.average_payroll_value,
	pm2.average_payroll_value AS next_year_average_payroll_value,
	round((pm2.average_payroll_value*100/pm.average_payroll_value)-100,2) AS 'year-on_year_difference_average_payroll'
FROM t_adela_havlova_pomocna_mzdy pm  
LEFT JOIN t_adela_havlova_pomocna_mzdy pm2
	ON pm2.payroll_year =pm.payroll_year +1
	AND pm.industry_branch_code=pm2.industry_branch_code  ;


CREATE TABLE t_adela_havlova_pomocna_potraviny AS
SELECT 
	ROUND(AVG(cp.value),3) AS average_food_value,
	cp.category_code, 
	YEAR(cp.date_from)AS'year',
	cpc.name AS food_name,
	cpc.price_unit AS food_unit
FROM czechia_price cp
JOIN czechia_price_category cpc 
	ON cp.category_code=cpc.code
GROUP BY YEAR(cp.date_from ), cp.category_code ;



CREATE TABLE t_adela_havlova_prubezna_potraviny AS
SELECT 
	pp.category_code ,
	pp.food_name,
	pp.food_unit,
	pp.year,
	pp2.year AS next_food_year,
	pp.average_food_value,
	pp2.average_food_value AS next_year_average_food_value,
	Round((pp2.average_food_value*100/pp.average_food_value)-100,2) AS 'year_on_year_diff_average_food'
FROM t_adela_havlova_pomocna_potraviny pp 
LEFT JOIN t_adela_havlova_pomocna_potraviny pp2
	ON pp2.year =pp.year +1
	AND pp.category_code=pp2.category_code  ;

SELECT * FROM t_adela_havlova_prubezna_potraviny tahpp ;


CREATE TABLE  t_adela_havlova_SQL_projekt_primary_final AS
SELECT 
 	tpm.industry_branch_name,
 	tpp.`year`,
 	tpp.food_name,
 	tpm.average_payroll_value ,
 	tpm.`year-on_year_difference_average_payroll` ,
 	tpp.average_food_value ,
 	tpp.food_unit,
 	tpp.year_on_year_diff_average_food 
FROM t_adela_havlova_prubezna_mzdy tpm 
JOIN t_adela_havlova_prubezna_potraviny tpp 
	ON tpm.payroll_year =tpp.year ;

SELECT * FROM t_adela_havlova_sql_projekt_primary_final;

-- 1. otázka - Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
SELECT 
	industry_branch_name ,
	`year` ,
	`year-on_year_difference_average_payroll` 
FROM t_adela_havlova_sql_projekt_primary_final
WHERE `year-on_year_difference_average_payroll` <0
GROUP BY industry_branch_name,`year` 
ORDER BY `year-on_year_difference_average_payroll` asc;

-- 2. otázka -Kolik je možné si koupit litrů mléka a kilogramů chleba za první (2006) a poslední (2018) srovnatelné období v dostupných datech cen a mezd?

SELECT 
	food_name,
	`year` , 
	average_payroll_value ,
	average_food_value,
	ROUND(average_payroll_value /average_food_value,0) AS number_of_items,
	food_unit
FROM t_adela_havlova_sql_projekt_primary_final
WHERE (food_name = 'Chléb konzumní kmínový'OR food_name = 'Mléko polotučné pasterované') AND (`year`=2006 OR `year`=2018) 
GROUP BY `year`, food_name  ;

-- 3. otázka - Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

SELECT 
	food_name  ,
	`year` , 
	year_on_year_diff_average_food 
FROM t_adela_havlova_sql_projekt_primary_final
WHERE year_on_year_diff_average_food >0
GROUP BY food_name
ORDER BY year_on_year_diff_average_food ASC
LIMIT 1;


-- 4. otázka - Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

SELECT 
	`year` , 
	ROUND(AVG(year_on_year_diff_average_food),2) AS year_on_year_food_overall_diff
FROM t_adela_havlova_sql_projekt_primary_final
GROUP BY `year` 
HAVING year_on_year_food_overall_diff>10;