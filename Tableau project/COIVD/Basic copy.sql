select * 
from Portfolio_project.covid_deaths;

select * 
from Portfolio_project.covid_vacc;

--
select Location, date, total_cases, new_cases, total_deaths,population
from covid_deaths
order by 1;

--
select Location, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_rate 
from covid_deaths
order by 1;

--
select Location, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_rate 
from covid_deaths
where location like"AUS%"
order by 1;
--
select location, MAX(total_cases) as Infectious_Count, MAX((total_cases/population)) as Infectious_Rate
from covid_deaths
group by location, population
order by Infectious_Rate desc;

--

select location, MAX(total_Deaths/population) as Death_rate
from covid_deaths 
where continent is not null
group by location
order by Death_rate desc;

--

select continent, MAX(cast(Total_deaths as UNSIGNED int)) as TotalDeathCount
From Covid_deaths
Where continent is not null 
Group by continent
order by TotalDeathCount desc;

--
 Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as UNSIGNED int)) as total_deaths, SUM(cast(new_deaths as UNSIGNED int))/SUM(New_Cases)*100 as DeathPercentage
From covid_deaths
where continent is not null 
order by 1,2;

--

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as UNSIGNED int)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From covid_deaths as dea
Join covid_vacc as vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3;

--

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as UNSIGNED int)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From covid_deaths as dea
Join covid_vacc as vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac;

-- temp trabe


DROP Table if exists PercentPopulationVaccinated;
Create Table PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population int,
New_vaccinations int,
RollingPeopleVaccinated int
);

Insert into PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as UNSIGNED INT)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From covid_deaths as dea
Join covid_vacc as vac
	On dea.location = vac.location
	and dea.date = vac.date;

Select *, (RollingPeopleVaccinated/Population)*100
From PercentPopulationVaccinated;

--

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as UNSIGNED INT)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From covid_deaths as dea
Join covid_vacc as vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null;

