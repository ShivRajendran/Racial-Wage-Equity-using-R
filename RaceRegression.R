library(stargazer)
library(broom)
library(dplyr)

#load csv
setwd("---------------")
data=read.csv("---------.csv",stringsAsFactors=FALSE)

#create age groups
data$age_Group=0
data$age_Group=ifelse(data$Age<25,1,data$age_Group)
data$age_Group=ifelse(data$Age>=25 & data$Age<35,2,data$age_Group)
data$age_Group=ifelse(data$Age>=35 & data$Age<45,3,data$age_Group)
data$age_Group=ifelse(data$Age>=45 & data$Age<55,4,data$age_Group)
data$age_Group=ifelse(data$Age>=55,5,data$age_Group)

#log base for Pay gap
data$log_base <- log(data$Annual.Salary)

#setup dummy variable
data$male=ifelse(data$Gender=="Male",1,0)

##quick plot of race distribution to see what im working with
zz=data[(data$Race.Description)!="",]$Race.Description
unique(zz)
zz=ifelse(zz=="Black or African American",1,zz)
zz=ifelse(zz=="White",2,zz)
zz=ifelse(zz=="Asian",3,zz)
zz=ifelse(zz=="Two or more races",4,zz)
zz=ifelse(zz=="Native Hawaiian or Other Pacific Islander",5,zz)
zz=ifelse(zz=="American Indian or Alaska Native",6,zz)
zz=ifelse(zz=="Hispanic or Latino",7,zz)
plot(data[(data$Race.Description)!="",]$Annual.Salary~zz,data=data)

#relevel and run a model
data$Race.Description=as.factor(data$Race.Description)
data <- within(data, Race.Description <- relevel(Race.Description, ref = "White"))
White=(lm(log_base~Race.Description+Job.Title.Description+Department.Description+Age+Tenure,data=data))
data <- within(data, Race.Description <- relevel(Race.Description, ref = "Black or African American"))
Black=(lm(log_base~Race.Description+Job.Title.Description+Department.Description+Age+Tenure,data=data))
data <- within(data, Race.Description <- relevel(Race.Description, ref = "Asian"))
Asian=(lm(log_base~Race.Description+Job.Title.Description+Department.Description+Age+Tenure,data=data))
data <- within(data, Race.Description <- relevel(Race.Description, ref = "Hispanic or Latino"))
HL=(lm(log_base~Race.Description+Job.Title.Description+Department.Description+Age+Tenure,data=data))

##Race Description Regression------------------------------------------------------------------------------- 
summary((lm(log_base~Race.Description+Job.Title.Description+Department.Description+Age+Tenure,data=data)))
res=(lm(log_base~Race.Description+Job.Title.Description+Department.Description+Age+Tenure,data=data))

#only showing things we want to show here (cleanup final results)
x=attributes(res$coefficients)$names
omitlist=x[grepl("Department.Description|Job.Title.Description|Age|Tenure",x)==TRUE]

stargazer(res, type="html", out="raceresults.htm", omit=omitlist)
stargazer(White,Black,Asian,HL, type="html", out="Raceresults.htm", column.labels = c("White","Black or African American","Asian","Hispanic or Latino"),omit=omitlist)
