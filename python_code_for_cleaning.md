# importing pands

import pandas as pd

# importing data to be cleaned

df = pd.read_excel('uncleaned_computer_jobs.xlsx')

# checking for null values

df.isnull().sum()

# removing unnecessary columns

df.drop('Job Description', axis=1, inplace=True)

# replacing spaces in column names with underscores

df.columns=df.columns.str.replace(' ', '_')

# adding "_USD" to Salary_Estimate 

df.rename(columns={'Salary_Estimate':'Salary_Estimate_USD'}, inplace=True)

# removing dollar sign from Salry_Estimate_USD column

df.Salary_Estimate_USD = df.Salary_Estimate_USD.str.replace('$', '', regex=True)

# adding "_USD" to Revenue

df.rename(columns={'Revenue':'Revenue_USD'}, inplace=True)

# removing dollar sign from Revenue_USD column

df.Revenue_USD = df.Revenue_USD.str.replace('$', '', regex=True)

# removing "(USD)" from Revenue_USD column

df.Revenue_USD = df.Revenue_USD.str.replace(r" \(.*\)","")

# replacing NaN with "Unknown/Non-Applicable" in Revenue column

df.Revenue_USD.fillna('Unknown/Non-Applicable', inplace=True)

# renaming Size to Number_of_Emlpoyees

df.rename(columns={'Size':'Number_of_Emlpoyees'}, inplace=True)

# remvoing "employees" string from Number_of_Emlpoyees column

df.Number_of_Emlpoyees = df.Number_of_Emlpoyees.str.replace('employees', '')

# splitting salary from "(Glassdoor)" from Salary_Estimate_USD column

df[['Salary_Estimate_USD', 'Salary_Estimate_Source']]=df.Salary_Estimate_USD.str.split(' ', n=1, expand=True)

# removing parenthesis from Salary_Estimate_Source column

df.Salary_Estimate_Source = df.Salary_Estimate_Source.str.replace('(','')
df.Salary_Estimate_Source = df.Salary_Estimate_Source.str.replace(')','')

# updating index of Salary_Estimate_Source Part 1: gather columns

df.columns

# updating index of Salary_Estimate_Source Part 2: move Salary_Estimate_Source after Salary_Estimate

df = df.reindex(columns=[
       'index', 'Job_Title', 'Salary_Estimate_USD', 'Salary_Estimate_Source', 
       'Company_Name', 'Rating', 'Location', 'Headquarters', 'Number_of_Emlpoyees', 'Founded',
       'Type_of_ownership', 'Industry', 'Sector', 'Revenue_USD', 'Competitors'])

# remvoing "est." from Salary_Estimate_Source column

df.Salary_Estimate_Source = df.Salary_Estimate_Source.str.replace('est.', '')

# splitting Location into Location_City and Location_State

df[['Location_City', 'Location_State']]=df.Location.str.split(',', n=1, expand=True) 

# removing column Location and reordering columns Location_City and Location_State

df.drop('Location', axis =1, inplace = True)

df = df.reindex(columns=[
       'index', 'Job_Title', 'Salary_Estimate_USD', 'Salary_Estimate_Source', 
       'Company_Name', 'Rating', 'Location_City', 'Location_State', 'Headquarters', 
       'Number_of_Emlpoyees', 'Founded', 'Type_of_ownership', 'Industry', 'Sector', 
       'Revenue_USD', 'Competitors'])
       
# splitting Headquarters into Headquarters_City and Headquarters_State/Country
# removing column Location and reordering columns Headquarters_City and Headquarters_State/Country

df[['Headquarters_City', 'Headquarters_State/Country']]=df.Headquarters.str.split(',', n=1, expand=True); 

df.drop('Headquarters', axis =1, inplace = True);

df = df.reindex(columns=[
       'index', 'Job_Title', 'Salary_Estimate_USD', 'Salary_Estimate_Source', 
       'Company_Name', 'Rating', 'Location_City', 'Location_State', 'Headquarters_City', 
       'Headquarters_State/Country', 'Number_of_Emlpoyees', 'Founded', 'Type_of_ownership', 'Industry', 'Sector', 
       'Revenue_USD', 'Competitors']);

# fixing incorrect data

df.Rating = df.Rating.mask(df.Rating == -1.0, 1.0)

# updating all "-1" to null value

df = df.mask(df == -1, )

# replacing all NaN values with "Unknown/Non-Applicable"

df.fillna('Unknown/Non-Applicable', inplace=True)

# updating Founded column datatype from object to int

df.Founded = df.Founded.replace('Unknown/Non-Applicable', '0')
df.Founded= df.Founded.astype(int)