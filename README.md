# Child-Care-Inspection



![](https://x-default-stgec.uplynk.com/ausw/slices/bfe/ef205c0e5ea14d77944cbd6904335118/bfe9055dd1c645299376d8201ed3d1bb/poster_08073b583e0f4729adeb9bca439ac23d.png)


## Project Overview

This project analyzes childcare inspection data to identify patterns, trends, and insights related to various childcare centers, inspection results, and violation categories. The analysis aims to provide actionable recommendations to improve compliance and safety in childcare facilities. The NYC OpenData provided the [Dataset](https://data.cityofnewyork.us/Health/DOHMH-Childcare-Center-Inspections/dsg6-ifza/about_data)


## Problem Statement:
Childcare centers are subject to regular inspections to meet safety and regulatory standards. However, the data must be systematically analyzed to identify areas for improvement, common violations, and trends over time. This analysis will help make informed decisions to enhance the overall quality of child services.

## Tools Utilized

SQL server management Studio (ssms) for data extraction, transformation, and [querying](https://github.com/kuetena1/Child-Care-Inspection/blob/main/child_care_queries.sql)

## Here are steps to query the database and extract valuable insights.


### Inspection periode 

![](https://github.com/kuetena1/Child-Care-Inspection/blob/main/images/periode%20of%20study.png)


### Identifying the types of child care centers and their frequencies 

![](https://github.com/kuetena1/Child-Care-Inspection/blob/main/images/child%20care%20type.png)


### Analyzing violation categories and their frequencies.

![](https://github.com/kuetena1/Child-Care-Inspection/blob/main/images/violation%20categories.png)




### Determining the status of facilities at the time of inspection


![](https://github.com/kuetena1/Child-Care-Inspection/blob/main/images/status.png)



### Examining the program types 

![](https://github.com/kuetena1/Child-Care-Inspection/blob/main/images/program.png)



###  Determing the facility types 

![](6https://github.com/kuetena1/Child-Care-Inspection/blob/main/images/Facility%20type.png)



### What are the top 10 inspection summary results?

![](https://github.com/kuetena1/Child-Care-Inspection/blob/main/images/top%2010%20inspection%20results.png)



###  What are the citywide average violations for each violation category


![](https://github.com/kuetena1/Child-Care-Inspection/blob/main/images/average%20for%20the%203%20categories%20of%20violations.png)


### This query will provide a comparison of the actual violation rate to the citywide average violation rate for the general violation category, broken down by childcare type

![](https://github.com/kuetena1/Child-Care-Inspection/blob/main/images/General%20violation%201.png)
![](https://github.com/kuetena1/Child-Care-Inspection/blob/main/images/general%20violatio%202.png)
![](https://github.com/kuetena1/Child-Care-Inspection/blob/main/images/General%20violation%203.png)

### This query will provide a comparison of the actual violation rate to the citywide average violation rate for the  public hazard violation category, broken down by child care type. According to the data description, public hazard violation  needs to be fixed in 1 day.




![](https://github.com/kuetena1/Child-Care-Inspection/blob/main/images/public%20violation%201.png)
![](https://github.com/kuetena1/Child-Care-Inspection/blob/main/images/public%20violation%202.png)


### This query will provide a comparison of the actual violation rate to the citywide average violation rate for the critical violation category, broken down by child care type. According to the data description, critical violation  needs to be fixed in 2 weeks.

  

![](https://github.com/kuetena1/Child-Care-Inspection/blob/main/images/critical%20violation%201.png)
![](https://github.com/kuetena1/Child-Care-Inspection/blob/main/images/critical%20violation%202.png)
![](https://github.com/kuetena1/Child-Care-Inspection/blob/main/images/critical%20violation%203.png)




### The following query splits the inspection summary results into the type of inspection and the decision.



![](https://github.com/kuetena1/Child-Care-Inspection/blob/main/images/type%20of%20inspection.png)
![](https://github.com/kuetena1/Child-Care-Inspection/blob/main/images/inspection%20decision.png)




### The below query aims to standardize the inspection decisions to gather more information


![](https://github.com/kuetena1/Child-Care-Inspection/blob/main/images/decision%20standadized%20.png)



###  Child Care Successfully Passing the Initial Annual Inspection



![](https://github.com/kuetena1/Child-Care-Inspection/blob/main/images/how%20many%20passed%20the%20initial%20inspection.png)





### Child Care Types Failing the Initial Annual Inspection
![](https://github.com/kuetena1/Child-Care-Inspection/blob/main/images/how%20many%20failed%20the%20initial%20inspection.png)
