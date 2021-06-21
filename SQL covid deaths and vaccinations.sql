-- cleaning data: some columns with numbers were nvarchar. they were converted to numeric.
-- cleaned 11 other columns the same way. not showing for brevity.

  alter table PortfolioProject..covid_deaths alter column new_deaths numeric

-- selecting specific data to use

Select 
  location, date, total_cases, new_cases, total_deaths, population
From 
  PortfolioProject..covid_deaths;

-- selecting specific country

Select 
  location, date, total_cases, new_cases, total_deaths, population
From 
  PortfolioProject..covid_deaths
Where 
  location='Albania';

-- selecting the month February 2020 (only 6 days in the dataset)

Select location, date, total_cases, new_cases, total_deaths, population
From 
  PortfolioProject..covid_deaths
Where 
  date>='2020-02-24' and date<='2020-02-29';

-- death percentage of those infeced per day in United States

Select location, date, total_cases, total_deaths, population, (total_deaths/total_cases) *100 As daily_death_percentage
From 
  PortfolioProject..covid_deaths
Where 
  location = 'United States';

-- percentage of population that has covid on a given day in the United States

Select 
  location, date, total_cases, population, (total_cases/population) *100 As daily_case_percentage
From
  PortfolioProject..covid_deaths
Where 
  location = 'United States';

-- highest case percentage in August 2020 by country using Max function

Select 
  location, population, Max(total_cases/population) *100 As highest_daily_case_percentage
From 
  PortfolioProject..covid_deaths
Where 
  date >='2020-08-01' and date<='2020-08-31'
Group By 
  location, population
Order by 
  highest_daily_case_percentage desc;

-- highest case percentage in August 2020 by country without an aggregate function

Select 
  location, population, total_cases/population *100 As highest_daily_case_percentage
From 
  PortfolioProject..covid_deaths
Where 
  date ='2020-08-31'
Order by 
  highest_daily_case_percentage desc;

-- total deaths worldwide

Select 
  Sum(new_cases) As total_cases, Sum(new_deaths) As total_deaths_worldwide, (Sum(new_deaths)/Sum(new_cases))*100 As death_percentage
From 
  PortfolioProject..covid_deaths
Where continent is not null

-- total number of deaths per location (country)
-- continent is not null because continents show up in the location column too
-- when they do, they are null in the continent column

Select 
  location, population, Max(total_deaths) as total_deaths
From 
  PortfolioProject..covid_deaths
Where 
  continent is not null
Group By 
  location, population;

-- total deaths in the month of August

Select 
  location, Sum(new_deaths) As deaths 
From 
  PortfolioProject..covid_deaths
Where 
  date>='2020-08-01' and date<='2020-08-31'
Group By 
  location;

-- total deaths up until the end of August

Select 
  location, Max(total_deaths) As deaths 
From 
  PortfolioProject..covid_deaths
Where 
  date='2020-08-31'
Group By 
  location;

-- total deaths per continent grouped by continent

Select 
  continent, Sum(new_deaths) as all_deaths
From  
  PortfolioProject..covid_deaths
Where 
  continent is not null
Group by 
  continent
Order by 
  all_deaths desc;

-- total deaths per continent grouped by location 

Select 
  location, Max(total_deaths) as all_deaths
From 
  PortfolioProject..covid_deaths
Where 
  continent is null and location<>'World' and location <> 'International' and location <> 'European Union' 
Group by 
  location
Order By 
  all_deaths desc

-- continents with over 600,000 deaths using Having function

Select 
  continent, Sum(new_deaths) as all_deaths
From 
  PortfolioProject..covid_deaths
Where 
  continent is not null
Group by 
  continent
Having 
  Sum(new_deaths) > 600000
Order by 
  all_deaths desc;

-- joining covid_deaths and covid_vaccinations tables

Select covid_deaths.location, covid_vaccinations.date, covid_deaths.population, covid_vaccinations.total_vaccinations
From 
  PortfolioProject..covid_deaths
  Join PortfolioProject..covid_vaccinations 
  On covid_deaths.location = covid_vaccinations.location
Where 
  total_vaccinations is not null;

-- using join: total vaccinations by location in descending order

Select 
  covid_deaths.location, Max(covid_vaccinations.total_vaccinations) As total_vaccinations
From PortfolioProject..covid_deaths
  Join PortfolioProject..covid_vaccinations  
  On covid_deaths.location = covid_vaccinations.location
Where 
  total_vaccinations is not null
Group By 
  covid_deaths.location
Order By 
  total_vaccinations desc;

-- total vaccinations for the month of March 2021 by location

Select 
  covid_deaths.location, Max(covid_vaccinations.total_vaccinations) As total_vaccinations
From 
  PortfolioProject..covid_deaths
Join 
  PortfolioProject..covid_vaccinations  
  On covid_deaths.location = covid_vaccinations.location
Where 
  total_vaccinations is not null And covid_vaccinations.date='2021-03-31' 
Group By 
  covid_deaths.location
Order By 
  total_vaccinations desc;

-- total percent of each countries' vaccinated population 

Select 
  covid_deaths.location, Max(covid_vaccinations.people_fully_vaccinated) As people_fully_vaccinated, covid_deaths.population, 
  Max(covid_vaccinations.people_fully_vaccinated/covid_deaths.population)*100 As percent_vaccinated
From 
  PortfolioProject..covid_deaths
  Join PortfolioProject..covid_vaccinations
  On covid_deaths.location = covid_vaccinations.location
Where 
  people_fully_vaccinated is not null and covid_deaths.continent is not null
Group By 
  covid_deaths.location, covid_deaths.population 
Order By 
  location;

-- total percent of each countries' vaccinated population with dates

Select 
  covid_deaths.location, covid_vaccinations.date, Max(covid_vaccinations.people_fully_vaccinated) As people_fully_vaccinated, covid_deaths.population, 
  Max(covid_vaccinations.people_fully_vaccinated/covid_deaths.population)*100 As percent_vaccinated
From 
  PortfolioProject..covid_deaths
  Join PortfolioProject..covid_vaccinations
  On covid_deaths.location = covid_vaccinations.location
Where 
  people_fully_vaccinated is not null and covid_deaths.continent is not null
Group By 
  covid_deaths.location, covid_vaccinations.date, covid_deaths.population 
Order By 
  location;



