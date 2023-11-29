# Engeto-kurz---SQL-project
Projekt SQL v rámci kurzu Datové analýzy
# Struktura projektu 
- dokumentace
- primary tabulka s datovými podklady pro odpovědi na výzkumné otázky 1.,2.,3.,4. (vč. sql skriptu s odpověďmi)
- secondary tabulka s datovými podklady pro odpovědi na výzkumnou otázku 5.(vč. sql skriptu s odpovědí)
# Zadání projektu - vytvořte si z dostupných dat tabulku, z které zodpovíte následující otázky
# # Výzkumné otázky v rámci primary tabulky
1.Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2.Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3.Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
4.Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
# # Výzkumné otázky v rámci secondary tabulky
5.Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
# Postup tvorby projektu
# # Primary tabulka
- ze zdrojových dat jsem vytvořila primary tabulku - vzhledem k mnoho podkladovým tabulkám s daty jsem vytvořila postupně 4 sloučené tabulky (pomocna_mzdy, prubezna_mzdy, pomocna_potraviny, prubezna_potraviny) a z nich následně tabulku konečnou. V rámci pomocných tabulek jsem potřebovala vytvořit sloupec s meziročními změnami - pro jeho vytvoření jsem použila následující postup -LEFT JOIN jedné tabulky na tu samou tabulku.
# # Secondary tabulka
- ze zdrojových dat jsem vytvořila secondary tabulku-  vytvořila jsem 1 pomocnou tabulku, kde jsem potřebovala vytvořit sloupec s meziročními změnami - pro jeho vytvoření jsem použila následující postup -LEFT JOIN jedné tabulky na tu samou tabulku. Následně jsem vytvořila tabulku finální. V rámci zodpovězení výzkumné otázky jsem pak v rámci skriptu sloučila tabulka primary a secondary.
# Výstupy - Odpovědi na otázky
1. V některých odvětvích a letech mzdy klesají.Nejvíce mzdy klesly v Peněžnictví a pojišťovnictví v roce 2012.
   
2. Za první srovnatelné období, tj. 2006, je možné koupit:
   - nejvíce mléka,tj. 2772 l mléka, pokud jste pracovali v oboru Peněžnictví a pojišťovnictví
   - nejméně mléka,tj. 809 l méka, pokud jste pracovali v oboru Ubytování, stravování a pohostinství
   - nejvíce chleba,tj. 2482 kg chleba , pokud jste pracovali v oboru Peněžnictví a pojišťovnictví
   - nejméně chleba,tj. 724 kg chleba, pokud jste pracovali v oboru Ubytování, stravování a pohostinství

  Za poslední srovnatelné období, tj. 2018, je možné koupit:
   - nejvíce mléka,tj. 2862 l mléka, pokud jste pracovali v oboru Informační a komunikační činnosti
   - nejméně mléka,tj. 972 l méka, pokud jste pracovali v oboru Ubytování, stravování a pohostinství
   - nejvíce chleba,tj. 2340 kg chleba, pokud jste pracovali v oboru Informační a komunikační činnosti
   - nejméně chleba,tj. 795 kg chleba, pokud jste pracovali v oboru Ubytování, stravování a pohostinství

Celkově je vidět, že minimální hodnoty jsou dlouhodobě spojeny s oborem Ubytování, stravování a pohostinství. Maximální hodnoty jsou pak spojené s obory Peněžnictví a pojišťovnictví pro rok 2006 a Informační a komunikační činnosti pro rok 2018. Nezáleží, zda zkoumáme data chleba či mléka, obory zůstávají stejné.

3. Z dat vyplývá, že cena kategorie potravin rajská jablka červená kulatá klesá nejvíce, neeviduje procentuální nárůt, nýbrž procentuální pokles.
   
4. Ne.
   
5. V některých letech lze sledovat souvislost, v některých ne. Nelze tedy tuto souvislost potvrdit ani vyvrátit.
