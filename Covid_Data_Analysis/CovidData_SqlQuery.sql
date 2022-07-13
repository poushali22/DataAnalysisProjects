/*
Covid 19 Data Exploration 
Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/
select * from [Portfolio Project]..CovidDeaths
order by 3,4

-- select the data that we are going to be using

select location, date, total_cases, new_cases, total_deaths, population
from [Portfolio Project]..CovidDeaths
order by 1,2;

-- Looking at Total cases vs Total deaths
-- Shows likelihood of dying if you contract covid in your country

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from [Portfolio Project]..CovidDeaths
where location like '%india%'
order by 1,2;

-- Looking at Total cases vs Population
-- Shows what percentage of population infected with Covid

select location, date, total_cases, population, (total_cases/population)*100 as CovidPercentage
from [Portfolio Project]..CovidDeaths
where location like '%india%'
order by 1,2;

-- Looking at countries with highest infection rate compared to population

select location, population, max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as 
PercentPopulationInfected
from [Portfolio Project]..CovidDeaths
group by location,population
order by PercentPopulationInfected desc

-- Showing countries with Highest Death Count per Population

select location, max(cast(total_deaths as int)) as TotalDeathCount -- we had to change the datatype of the total_death column
from [Portfolio Project]..CovidDeaths
where continent is not null
group by location
order by TotalDeathCount desc

--Let's break things down by continent
-- the below code gives wrong result, the north america continent is only including USA so we are changing the code a bit
--select continent, max(cast(total_deaths as int)) as TotalDeathCount 
--from [Portfolio Project]..CovidDeaths
--where continent is not null
--group by continent
--order by TotalDeathCount desc

select location, max(cast(total_deaths as int)) as TotalDeathCount 
from [Portfolio Project]..CovidDeaths
where continent is null
group by location
order by TotalDeathCount desc


-- Global Numbers

select date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths,
sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage 
from [Portfolio Project]..CovidDeaths
where continent is not null
group by date
order by 1,2;

-- total number of death and percentage

select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths,
sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage 
from [Portfolio Project]..CovidDeaths
where continent is not null
order by 1,2;



--- Looking at Total Population vs Vaccinations

select dea.continent, dea.location, dea.date, vac.new_vaccinations
from [Portfolio Project]..CovidDeaths dea
join [Portfolio Project]..CovidVaccinations vac
	on dea.location=vac.location 
	and dea.date=vac.date
where dea.continent is not null
order by 2,3

--using windows function to make rolling count. We are using CTE also here

With PopvsVac (Continent,location, date, population, new_vaccinations,RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) over 
(Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from [Portfolio Project]..CovidDeaths dea
join [Portfolio Project]..CovidVaccinations vac
	on dea.location=vac.location 
	and dea.date=vac.date
where dea.continent is not null
)
Select *, (RollingPeopleVaccinated/population)*100 -- this gives us a rolling percentage
From PopvsVac;

-- Using CTE to perform Calculation on Partition By in previous query
With PopvsVac (Continent,location, date, population, new_vaccinations,RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) over 
(Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from [Portfolio Project]..CovidDeaths dea
join [Portfolio Project]..CovidVaccinations vac
	on dea.location=vac.location 
	and dea.date=vac.date
where dea.continent is not null
)
Select location, population,
Max((RollingPeopleVaccinated/population)*100) as VaccinationPercentage  -- this gives us a the total vaccination in each counrty
From PopvsVac
group by location,population
order by VaccinationPercentage desc ;

-- Temp Table to perform Calculation on Partition By in previous query
Drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)
Insert into #PercentPopulationVaccinated

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) over 
(Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from [Portfolio Project]..CovidDeaths dea
join [Portfolio Project]..CovidVaccinations vac
	on dea.location=vac.location 
	and dea.date=vac.date
where dea.continent is not null

Select *, (RollingPeopleVaccinated/population)*100 -- this gives us a rolling percentage
From #PercentPopulationVaccinated;


-- Creating view to store data for later visualizations

use [Portfolio Project]
Create View PercentPopulationVaccinated as
(select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) over 
(Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from [Portfolio Project]..CovidDeaths dea
join [Portfolio Project]..CovidVaccinations vac
	on dea.location=vac.location 
	and dea.date=vac.date
where dea.continent is not null)
