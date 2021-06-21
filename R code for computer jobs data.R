##From computer_jobs data set##

## removing trailing numbers from Ratings column (convert char to numeric)

computer_jobs$Rating <- as.numeric(computer_jobs$Rating)

## converting columns with numbers to numeric datatype (convert char to numeric)

computer_jobs$Year_Founded <- as.numeric(computer_jobs$Year_Founded)
computer_jobs$Min_Salary_Estimate_thousands_of_USD <- as.numeric(computer_jobs$Min_Salary_Estimate_thousands_of_USD)
computer_jobs$Max_Salary_Estimate_thousands_of_USD <- as.numeric(computer_jobs$Max_Salary_Estimate_thousands_of_USD)

## counting unique number of each job and naming new column

View(computer_jobs %>% count(Job_Title, name='count_of_job_title'))

## plotting Rating and Year_Founded with a pipe

computer_jobs %>%
  ggplot()+
  geom_point(mapping=aes(x=Year_Founded,y=Rating))

## plotting Rating and Year_Founded without a pipe

ggplot(data=computer_jobs)+
  geom_point(mapping=aes(x=Year_Founded,y=Rating))
  
ggplot(computer_jobs)+
  geom_smooth(mapping=aes(x=Year_Founded,y=Rating))

## plotting two geoms together

ggplot(computer_jobs)+
  geom_point(mapping=aes(x=Year_Founded,y=Rating))+
  geom_smooth(mapping=aes(x=Year_Founded,y=Rating))

## visual of state vs max salary as a scatterplot 

ggplot(computer_jobs)+
  geom_point(mapping=aes(x=Max_Salary_Estimate_thousands_of_USD,y=Location_State))

## adding labels to the visual

ggplot(computer_jobs)+
  geom_point(mapping=aes(x=Year_Founded,y=Rating))+
  labs(title='Ratings Compared to Year Founded', 
  subtitle='Data From Computer Jobs', x='Founding Year', y='Company Ratings')

