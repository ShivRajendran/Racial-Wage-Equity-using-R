# Racial-Wage-Equity-using-R
Analyze Racial Wage gap utilizing linear Regression in R

-------------------------------------------------------------
To analyze the Racial wage gap in the organization, I ran a Linear regression Models while using Dummy variables to quantify Race and Gender. For this model I allowed each race to be a basline and performed 4 different models.  For example in the first model Whites were being compared to other races, in the next model African Americans were comnpared to the other races, and etc. This led me to create four models of interest and display them in an html for stargazer. The results allowed me to see which races were being underpaid when compared to another.

To change the baseline in the lm function i had to relevel my data table hence why there are 4 different relevel commands.

The JPG file contains a sample output using random sample data and what it would look like. In my random output we see that African Americans make 4.7% less than whites. The satargazer tables makes it easier to interpret Linear regression results.
