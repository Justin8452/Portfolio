-- cleaning cleaned_jobs (renamed uncleaned_jobs) --

-- making dupicate table

Select * Into PortfolioProject..cleaned_jobs From PortfolioProject..uncleaned_jobs;

-- updaing salary_estimate_USD column with the following code

Update PortfolioProject..cleaned_jobs
SET salary_estimate_USD = REPLACE('$137K-$171K', '$', '');

-- separating "(Glassdoor est.)" from salary_estimate_USD column and removing parenthises
 
Select *,
	TRIM( '()' FROM '(Glassdoor est.)') As salary_source
From PortfolioProject..cleaned_jobs;

-- adding salary_source column with data

Alter Table PortfolioProject..cleaned_jobs ADD salary_source Nvarchar(255);

Update PortfolioProject..cleaned_jobs
SET salary_source = TRIM( '()' FROM '(Glassdoor est.)');

--remove "(Glassdoor est.)" from salary_estimate_USD column

Select 
	Substring(salary_estimate_USD, -15, LEN(salary_estimate_USD) )
From PortfolioProject..cleaned_jobs;

--updating salary_estimate_USD column to remove "(Glassdoor est.)"

Update PortfolioProject..cleaned_jobs
SET salary_estimate_USD = Substring(salary_estimate_USD, -15, LEN(salary_estimate_USD));

-- removing "$" from salary_estimate_USD column

Select 
	Replace([salary_estimate_USD], '$', '') As salary_estimate_USD
From PortfolioProject..cleaned_jobs;

--updating salary_estimate_USD clumn to remove "$" 

Update PortfolioProject..cleaned_jobs
SET salary_estimate_USD = Replace([salary_estimate_USD], '$', '');

-- remvoing "employees" from number_of_employee column

Select 
	Substring(number_of_employees, -9, LEN(number_of_employees))
From PortfolioProject..cleaned_jobs;

-- updating number_of_employee column

Update PortfolioProject..cleaned_jobs
SET number_of_employees = Substring(number_of_employees, -9, LEN(number_of_employees));

-- separating city and state from location column

Select 
	Substring(location, -3, LEN(location)) As job_city,
	Substring(location, CHARINDEX(',', location) +1, LEN(location)) As job_state
From PortfolioProject..cleaned_jobs;

-- update table: adding job_city, job_state columns and adding the data to it
-- deleting location column

Alter Table PortfolioProject..cleaned_jobs ADD job_city nvarchar (255);

Update PortfolioProject..cleaned_jobs
SET job_city = Substring(location, -3, LEN(location));

Alter Table PortfolioProject..cleaned_jobs ADD job_state nvarchar (255);

Update PortfolioProject..cleaned_jobs
SET job_state = Substring(location, CHARINDEX(',', location) +1, LEN(location));

Alter Table PortfolioProject..cleaned_jobs Drop Column headquarters;

-- separating city and state from headquarters column

Select 
	Substring(headquarters, -3, LEN(headquarters)) As headquarters_city
	Substring(headquarters, CHARINDEX(',', headquarters) +1, LEN(headquarters)) As headquarters_state
From PortfolioProject..cleaned_jobs;
 
-- update table: adding headquarters_city, headquarters_state columns and adding the data to it
-- deleting headquarters column

Alter Table PortfolioProject..cleaned_jobs ADD headquarters_city nvarchar (255)

Update PortfolioProject..cleaned_jobs
SET headquarters_city = Substring(headquarters, -3, LEN(headquarters));

Alter Table PortfolioProject..cleaned_jobs ADD headquarters_state nvarchar (255);

Update PortfolioProject..cleaned_jobs
SET headquarters_state = Substring(headquarters, CHARINDEX(',', headquarters) +1, LEN(headquarters));

Alter Table PortfolioProject..cleaned_jobs Drop Column headqaurters;

-- removing "(USD)" from revenue column and updating it

Select 
	Replace([revenue_USD], '(USD)', '') As salary_estimate_USD
From PortfolioProject..cleaned_jobs;

Update PortfolioProject..cleaned_jobs
SET revenue = Replace([revenue_USD], '(USD)', '');

