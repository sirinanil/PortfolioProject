-- Looking at Death Percentage
SELECT location, date, total_cases, new_cases, total_deaths, population, ROUND((total_deaths / total_cases) * 100, 3) AS death_persentage
FROM coviddeaths
WHERE location = 'Turkey'
ORDER BY 1, 2;

-- Shows what persentage of population got covid
SELECT location, date, total_cases, population, ROUND((total_cases / population) * 100, 3) AS covid_persentage
FROM coviddeaths
WHERE location = 'Turkey'
ORDER BY 1, 2;

-- Highest infection rate compared to population
SELECT continent, location, MAX(total_cases) AS max_cases, population, ROUND(MAX(total_cases / population) * 100, 3) AS persent_population_infected
FROM coviddeaths
GROUP BY continent, location, population
ORDER BY persent_population_infected DESC;

-- Showing the countries with the highest death count per population
SELECT continent, location, MAX(CAST(total_deaths AS SIGNED)) AS max_deaths
FROM coviddeaths
WHERE continent IS NOT NULL -- Because when it is null, it shows a group like World, or Europe
GROUP BY continent, location
ORDER BY max_deaths DESC;

SELECT location, MAX(CAST(total_deaths AS SIGNED)) AS max_deaths
FROM coviddeaths
WHERE continent IS NULL 
GROUP BY location
ORDER BY max_deaths DESC;

-- Global Numbers
SELECT date, SUM(new_cases) AS total_new_cases, SUM(new_deaths) AS total_new_deaths,
	   ROUND((SUM(new_deaths) / SUM(new_cases)) * 100, 3) AS new_death_persentage
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2;

-- Total Population vs Vaccinations
SELECT cdeath.continent, cdeath.location, cdeath.date, cdeath.population, cvacci.new_vaccinations,
	   SUM(cvacci.new_vaccinations) OVER (PARTITION BY cdeath.location ORDER BY cdeath.location, cdeath.date) AS rolling_total_vaccinations
FROM coviddeaths AS cdeath, covidvaccinations AS cvacci
WHERE cdeath.location = cvacci.location AND cdeath.date = cvacci.date AND cdeath.continent IS NOT NULL
ORDER BY 2,3;

-- CTE 
WITH popvsvac (continent, location, date, population, new_vaccinations, rolling_total_vaccinations) AS ( 
SELECT cdeath.continent, cdeath.location, cdeath.date, cdeath.population, cvacci.new_vaccinations,
	   SUM(cvacci.new_vaccinations) OVER (PARTITION BY cdeath.location ORDER BY cdeath.location, cdeath.date) AS rolling_total_vaccinations
FROM coviddeaths AS cdeath, covidvaccinations AS cvacci
WHERE cdeath.location = cvacci.location AND cdeath.date = cvacci.date AND cdeath.continent IS NOT NULL
ORDER BY 2,3)

SELECT *, ROUND((rolling_total_vaccinations / population) * 100, 3) AS vaccinated_persentage
FROM popvsvac;










