## Visuals From covid_deaths data set##

## using filter to find the total deaths in Albania for the month of March through April 

covid_deaths %>% filter(location=='Albania', date >= '2020-3-01' & date <= '2020-4-30') %>% 
  ggplot()+
    geom_point(mapping=aes(x=date,y=total_deaths))+
    labs(title='Total Deaths for March and April', x='Date', y='Total Deaths')

## same as above but as a line graph

covid_deaths %>% filter(location=='Albania', date >= '2020-3-01' & date <= '2020-4-30') %>% 
  ggplot()+
  geom_line(mapping=aes(x=date,y=total_deaths))+
  labs(title='Total Deaths for March and April', x='Date', y='Total Deaths')

## total deaths in Albania for March & April using geom_point and smooth

covid_deaths %>% filter(location=='Albania', date >= '2020-3-01' & date <= '2020-4-30') %>% 
  ggplot()+
  geom_point(mapping=aes(x=date,y=total_deaths))+
  geom_smooth(mapping=aes(x=date,y=total_deaths))+
  labs(title='Total Deaths for March and April', x='Date', y='Total Deaths')

## total deaths in Albania for the month of March through April with color blue 

covid_deaths %>% filter(location=='Albania', date >= '2020-3-01' & date <= '2020-4-30') %>% 
  ggplot()+
  geom_point(mapping=aes(x=date,y=total_deaths), color='blue')

## total world wide deaths by dates March 2020

covid_deaths %>% filter(date >= '2020-3-01' & date <= '2020-3-31') %>% 
  ggplot()+
  geom_point(mapping=aes(x=date,y=total_deaths), color='blue')

## using facet_wrap to separate each continent

covid_deaths %>% filter(date >= '2020-3-01' & date <= '2020-4-30') %>% 
  ggplot()+
  geom_point(mapping=aes(x=date,y=total_deaths), color='blue')+
  facet_wrap(~continent)

## total deaths by continent using bar graph

ggplot(covid_deaths, aes(new_deaths))+
  geom_bar(aes(continent))+
  labs(title='Total Death by Continent', x='Continent', y='Total Death by')

## merge coivd_deaths and covid_vaccinations horizontally

covid_deaths_and_vaccinations<-cbind(covid_deaths, covid_vaccinations)





