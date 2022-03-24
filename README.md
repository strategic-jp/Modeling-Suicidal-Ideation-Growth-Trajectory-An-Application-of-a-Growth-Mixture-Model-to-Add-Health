# Modeling-Suicidal-Ideation-Growth-Trajectory-An-Application-of-a-Growth-Mixture-Model-to-Add-Health
The objective of the study is to quantify longitudinal trajectories of groups (classes) of past-year suicide ideation and to explore the association between covariates and class membership in these trajectories from adolescence into young adulthood. In the study, the heterogeneity of longitudinal trajectories of suicide ideation groups of individuals will be identified. In addition, the relationship between covariates and each latent class will be estimated. Primary research areas include identifying the number of classes and longitudinal group differences of suicide-related thought and behavior. 

# Research Questionas
(1) How many unobserved suicide ideation trajectory groups are there? 
i.e., Which class model can be considered optimum for suicide ideation? 
(2) Can the unobserved subpopulations be predicted?  
i.e., What variables predict the class membership of the unobserved suicide ideation groups? The analysis includes the following predictors known to be associated with suicidality: gender, same-sex attraction, childhood SES, race/ethnicity, and depressive symptom.

### Longitudianl Data Cleaning (Wave1-Wave4) 

##### Outcome variables: Suicide ideation.
Suicide ideation. The main outcome measure was participant reports of suicide ideation from Wave Ⅰ to Wave Ⅳ. Thoughts about committing suicide in the past 12 months were assessed by the dichotomous question, “During the past 12 months, did you ever seriously think about committing suicide?” Valid responses were no or yes. Suicidal ideation variables were reconfigured from data collection wave to chronological age to explore trajectories of suicidal ideation from an age-related developmental perspective. Thus, the analysis of the suicide ideation variable covers ages 12-31 years (i.e., age 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31), constituting twenty suicidal ideation variables and allowing for the identification of longitudinal trajectories. 

##### Predictors: gender, childhood socio economic status, race/ethnicity, and experience of same-sex in wave Ⅰ
Other variables in my analysis were selected on the basis of factors previously described as relevant to suicide ideation. These items were sociodemographic including gender, childhood socio economic status, race/ethnicity, and experience of same-sex in wave Ⅰ. Survey items were recoded into dichotomous variables from categorical items or 4-point response scale items to compare reference group participants (coded 0) with a comparison group of participants (coded 1).
#### Merge Wave1-Wave4, Sampling Weight

#####UPLOAD RAW DATA SET#####
df2 = da21600.0005 #21600-0005-dATA.rda WAVE2

#####PACKAGE#####

library(tidyverse)
library(dplyr)
library(lubridate)

######EXTRACT VARIABLES#####
colnames(df2)
df2=select(df2,AID,CALCAGE2,IDAY2,IMONTH2,IYEAR2,H2SU1,H2SU2)
sapply(df2, class)
df2 %>% select(AID,CALCAGE2,IDAY2,IMONTH2,IYEAR2,H2SU1,H2SU2)%>%head(10)

######DATA CLEANING######
# Overall
#1. AGE 
#2.IINTERVIEW DATE
#3. OUTCOME VAR from DF WAVE2(da21600.0005)

#1. AGE 
#AGE CALCULATION: calculate age, extract numeric value
df2$CALCAGENUM2 <- substr(df2$CALCAGE2,start=2, stop=3)
df2 %>%head(10)

sapply(df2,class)

#2.IINTERVIEW DATE
#2.1.Extract nth character
df2$IDAYS2num <- substr(df2$IDAY2,start=2, stop=3)
df2$IMONTH2num <- substr(df2$IMONTH2,start=8, stop=13)
df2$IYEAR2num <- substr(df2$IYEAR2,start=10, stop=14)

#2.2 Combine year,month,day into one column
df2$IDATE2 <-paste(df2$IYEAR2num,df2$IMONTH2num,df2$IDAYS2num,sep ="-")
df2%>%head(10)
df2 <- df2 %>% mutate(INTERVIEWDATE2=ymd(df2$IDATE2))
sapply(df2, class)

#3. OUTCOME VAR from DF WAVE2(da21600.0005)
#Set Name
#name variable Suicide ideation to SI2, suicide attemts to SA2 
df2=setNames(df2, c("AID","CALCAGE2","ITVDAY2","ITVMONTH2","ITVYEAR2","SI2","SA2","AGE2"))
df2%>%head(10)

#Merge data frame 2,3,4 by AID(unique id number). FOR THIS IMPORT W3 DATA RESULT
df23=merge(df2, df3, by= "AID")
df234=merge(df23,df4, by="AID")
##### Outcome varibales: Suicidal Ideation experience
