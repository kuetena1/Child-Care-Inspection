


--data inspection
SELECT * FROM[child_care].[dbo].[child_care];

-- let's create a copy of the table 
SELECT * INTO child_care_inspection
from [dbo].[child_care];


 -- LET'S CHECK IN KEY COLUMNS
 SELECT*
 FROM[dbo].[child_care_inspection]

 -- period of study 
SELECT
 min(Inspection_Date),
 max(Inspection_Date)
 from[dbo].child_care_inspection

-- What are the different type of child care centers 
 SELECT 
 child_care_type,
 count(*) Total_Number
 FROM [dbo].child_care_inspection
 GROUP BY child_care_type
 order by count(*) desc

 -- what are violations categories
 -- Public Health Hazard violation needs to be fixed within 1 day,  
 --Critical Violation needs to be fixed within 2 weeks,
 --General Violation needs to be fixed in 30 days
 SELECT 
 Violation_Category,
 COUNT(*) as Total
 FROM [dbo].child_care_inspection
 WHERE Violation_Category is not null
 GROUP BY Violation_Category
 order by COUNT(*) desc ;

 --What are the differents status of the facilities at the time of inspection
 SELECT 
 [Status],
 COUNT(*) Total_Number
 FROM [dbo].child_care_inspection
 GROUP BY [Status]
 ORDER BY COUNT(*) DESC;

--Program
 SELECT 
 Program_Type,
 COUNT(*) Total_Number
 FROM [dbo].child_care_inspection
 GROUP BY Program_Type
 ORDER BY COUNT(*) DESC;

 -- Facility type
SELECT 
Facility_Type,
COUNT(*) as Total_Number
 FROM [dbo].child_care_inspection
 GROUP BY Facility_Type
 ORDER BY COUNT(*) DESC;

 -- WHAT  are the top 10 inspection summary results 
 SELECT 
Inspection_Summary_Result,
COUNT(*) as total_number
 FROM [dbo].child_care_inspection
 WHERE Inspection_Summary_Result IS NOT NULL
 GROUP BY Inspection_Summary_Result
 ORDER BY COUNT(*) DESC
offset 0 rows fetch next 10 rows only;
-- what is the citywide average violation rate for General, Public and critical violation categories.
SELECT 
child_care_type,
Average_Violation_Rate_Percent,
Average_Public_Health_Hazard_Violation_Rate,
Average_Critical_Violation_Rate
FROM [dbo].child_care_inspection
where Average_Violation_Rate_Percent is not null
GROUP BY child_care_type,Average_Violation_Rate_Percent,Average_Public_Health_Hazard_Violation_Rate,Average_Critical_Violation_Rate

-- under the general violation category how can we compare the the average violation rate over the actual violation rate
SELECT 
child_care_type,
Average_Violation_Rate_Percent,
Violation_Rate_Percent,
count(*) total_number
FROM [dbo].child_care_inspection
where Violation_Rate_Percent is not null and Average_Violation_Rate_Percent is not null
GROUP BY child_care_type,Violation_Rate_Percent, Average_Violation_Rate_Percent
order by child_care_type,count(*) desc,[Violation_Rate_Percent] desc;

--under the public health hazard violation category how can we compare the the average violation rate over the actual violation rate
SELECT
Child_Care_Type,
Average_Public_Health_Hazard_Violation_Rate,
Public_Health_Hazard_Violation_Rate,
count(*) as Total_number
FROM [dbo].child_care_inspection
WHERE Public_Health_Hazard_Violation_Rate is not null and Average_Public_Health_Hazard_Violation_Rate is not null
GROUP BY Child_Care_Type,Public_Health_Hazard_Violation_Rate,Average_Public_Health_Hazard_Violation_Rate
ORDER BY Child_Care_Type,count(*)desc,Public_Health_Hazard_Violation_Rate desc ;

 ---under the Critical_Violation_Rate category how can we compare the the average violation rate over the actual violation rate
SELECT
Child_Care_Type,
Average_Critical_Violation_Rate,
Critical_Violation_Rate,
count(*) as Total_number
FROM [dbo].child_care_inspection
WHERE Public_Health_Hazard_Violation_Rate is not null and Average_Public_Health_Hazard_Violation_Rate is not null
GROUP BY Child_Care_Type,Critical_Violation_Rate,Average_Critical_Violation_Rate
ORDER BY Child_Care_Type,count(*)DESC;

--We are spliting the inspection summary result into two columns. the type of inspection and the decision

WITH first_dash AS
(SELECT *,
substring([Inspection_Summary_Result],1 ,CHARINDEX('-', [Inspection_Summary_Result])-1) as type_of_inspection,
right([Inspection_Summary_Result],len([Inspection_Summary_Result])-CHARINDEX('-', [Inspection_Summary_Result]))as Decision
FROM[dbo].[child_care_inspection]
)   
SELECT 
type_of_inspection,
count(*) as Total
FROM first_dash  
WHERE type_of_inspection is not null and Decision is not null
GROUP BY type_of_inspection
ORDER BY count(*) desc;

--what decision was made after the inspection
WITH first_dash AS
(SELECT *,
substring([Inspection_Summary_Result],1 ,CHARINDEX('-', [Inspection_Summary_Result])-1) as type_of_inspection,
right([Inspection_Summary_Result],len([Inspection_Summary_Result])-CHARINDEX('-', [Inspection_Summary_Result]))as Decision
FROM[dbo].[child_care_inspection]
)   
SELECT 
Decision,
count(*) as Total
FROM first_dash  
WHERE type_of_inspection is not null and Decision is not null
GROUP BY Decision
ORDER BY count(*) desc
offset 0 rows fetch next 10 rows only;

--Let's standardize the inspection decisions to gather more comprehensive information.
WITH first_dash as
(SELECT *,
substring(Inspection_Summary_Result,1 ,CHARINDEX('-', Inspection_Summary_Result)-1) as type_of_inspection,
right(Inspection_Summary_Result,len(Inspection_Summary_Result)-CHARINDEX('-', Inspection_Summary_Result))as Decision
FROM [dbo].child_care_inspection
),   
second_dash as 
(SELECT*, 
case 
when Decision like '%reinspection Required%' then 'Reinspection Required'
when Decision like '%passed inspection%' then 'passed inspection'
when Decision in('Reinspection Not Required','Routine - Previously closed program re-opened','Routine - Previously cited violations corrected') then 'passed inspection'
 end as Final_decision
FROM first_dash  
WHERE Decision is not null
)
select 
Final_decision,
count(*)
from second_dash
WHERE Final_decision is not null
GROUP BY  Final_decision
ORDER BY count(*) desc;

--Is there a relationship between the type of child care, the initial inspection, and the inspection decision?
WITH first_dash as
(SELECT *,
substring(Inspection_Summary_Result,1 ,CHARINDEX('-', Inspection_Summary_Result)-1) as type_of_inspection,
right(Inspection_Summary_Result,len(Inspection_Summary_Result)-CHARINDEX('-', Inspection_Summary_Result))as Decision
FROM[dbo].[child_care_inspection]
),   
second_dash as 
(SELECT*,
case 
when Decision like '%reinspection Required%' then 'Reinspection Required'
when Decision like '%passed inspection%' then 'passed inspection'
when Decision in('Reinspection Not Required','Routine - Previously closed program re-opened','Routine - Previously cited violations corrected') then 'passed inspection'
 end as Final_decision
FROM first_dash  
WHERE Decision is not null
)
SELECT
[Child_Care_Type],
count(*) as Total_number_passed_initial_inspection
FROM second_dash
WHERE type_of_inspection ='Initial Annual Inspection' and Final_decision = 'passed inspection' 
GROUP BY  [Child_Care_Type]
ORDER BY  count(*) desc;

--is there a relation Initial inspection and the inspection decision (reinspection required)?
WITH first_dash as
(SELECT *,
substring(Inspection_Summary_Result,1 ,CHARINDEX('-', Inspection_Summary_Result)-1) as type_of_inspection,
right(Inspection_Summary_Result,len(Inspection_Summary_Result)-CHARINDEX('-', Inspection_Summary_Result))as Decision
FROM[dbo].[child_care_inspection]
),
second_dash as 
(SELECT*,
case 
when Decision like '%reinspection Required%' then 'Reinspection Required'
when Decision like '%passed inspection%' then 'passed inspection'
when Decision in('Reinspection Not Required','Routine - Previously closed program re-opened','Routine - Previously cited violations corrected') then 'passed inspection'
 end as Final_decision
FROM first_dash  
WHERE Decision is not null
)
SELECT
Child_Care_Type,
count(*) as Total_number_failed_initial_inspection
FROM second_dash
WHERE type_of_inspection ='Initial Annual Inspection' and Final_decision = 'Reinspection Required'
GROUP BY Child_Care_Type
ORDER BY count(*) desc;

--Final query
WITH first_dash as
(SELECT *,
substring(Inspection_Summary_Result,1 ,CHARINDEX('-', Inspection_Summary_Result)-1) as type_of_inspection,
right(Inspection_Summary_Result,len(Inspection_Summary_Result)-CHARINDEX('-', Inspection_Summary_Result))as Decision
FROM[dbo].[child_care_inspection]
),   
second_dash as 
(SELECT*,
case 
when Decision like '%reinspection Required%' then 'Reinspection Required'
when Decision like '%passed inspection%' then 'passed inspection'
when Decision in('Reinspection Not Required','Routine - Previously closed program re-opened','Routine - Previously cited violations corrected') then 'passed inspection'
 end as Final_decision
FROM first_dash  
WHERE Decision is not null
)
SELECT
Center_Name,
[Status],
Maximum_Capacity,
Program_Type,
Facility_Type,
Child_Care_Type,
Violation_Rate_Percent,
Average_Violation_Rate_Percent,
Public_Health_Hazard_Violation_Rate,
Average_Public_Health_Hazard_Violation_Rate,   
Critical_Violation_Rate,
Average_Critical_Violation_Rate,
Violation_Category,
Inspection_Date,
Violation_Status,
Total_Educational_Workers,
type_of_inspection,
Final_decision
FROM second_dash
WHERE type_of_inspection ='Initial Annual Inspection'AND Final_decision = 'Reinspection Required'










