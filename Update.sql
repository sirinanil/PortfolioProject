-- Columns was all text when I first imported them. So here is some converting queries.

UPDATE coviddeaths
SET date = STR_TO_DATE(date, '%m/%d/%Y');

UPDATE covidvaccinations
SET date = STR_TO_DATE(date, '%m/%d/%Y');

-- Update empty text values to NULL, then convert to integer
UPDATE coviddeaths
SET total_cases = NULLIF(total_cases, '');
UPDATE coviddeaths
SET total_cases = CONVERT(total_cases, SIGNED);

UPDATE coviddeaths
SET new_cases = NULLIF(new_cases, '');
UPDATE coviddeaths
SET new_cases = CONVERT(new_cases, SIGNED);

UPDATE coviddeaths
SET total_deaths = NULLIF(total_deaths, '');
UPDATE coviddeaths
SET total_deaths = CONVERT(total_deaths, SIGNED);

UPDATE coviddeaths
SET population = NULLIF(population, '');
UPDATE coviddeaths
SET population = CONVERT(population, SIGNED);

UPDATE coviddeaths
SET continent = NULLIF(continent, '');

UPDATE coviddeaths
SET new_deaths = NULLIF(new_deaths, '');
UPDATE coviddeaths
SET new_deaths = CONVERT(new_deaths, SIGNED);

UPDATE covidvaccinations
SET new_vaccinations = NULLIF(new_vaccinations, '');
UPDATE covidvaccinations
SET new_vaccinations = CONVERT(new_vaccinations, SIGNED);














