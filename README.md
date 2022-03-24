# Modeling-Suicidal-Ideation-Growth-Trajectory-An-Application-of-a-Growth-Mixture-Model-to-Add-Health
The objective of the study is to quantify longitudinal trajectories of groups (classes) of past-year suicide ideation and to explore the association between covariates and class membership in these trajectories from adolescence into young adulthood. In the study, the heterogeneity of longitudinal trajectories of suicide ideation groups of individuals will be identified. In addition, the relationship between covariates and each latent class will be estimated. Primary research areas include identifying the number of classes and longitudinal group differences of suicide-related thought and behavior. 

# DATA

### Raw Data
#### Raw data file for Mplus ( without attribute name), step 1
[df1209fullm.csv](https://github.com/strategic-jp/Modeling-Suicidal-Ideation-Growth-Trajectory-An-Application-of-a-Growth-Mixture-Model-to-Add-Health/files/8307202/df1209fullm.csv)
#### Raw data file for Mplus, step3, github does not support "dat"file extension, see google docs
- 1209man3step2.dat
- 1209man3step2missing.dat
#### Raw data file for Rstudio 
-- [Df1234sw.csv](https://github.com/strategic-jp/Modeling-Suicidal-Ideation-Growth-Trajectory-An-Application-of-a-Growth-Mixture-Model-to-Add-Health/files/8306723/Df1234sw.csv)
### Raw data file for Mplus with attribute 
(Mplus statistical software program does not support data file with attribute. This data file is saved to keep the data structure 
[df1209full.csv](https://github.com/strategic-jp/Modeling-Suicidal-Ideation-Growth-Trajectory-An-Application-of-a-Growth-Mixture-Model-to-Add-Health/files/8307201/df1209full.csv)

# Cleaning DATA
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

#3.SET VAR
# OUTCOME VAR from DF WAVE2
#Set Name
#name variable Suicide ideation to SI2, suicide attemts to SA2 
df2=setNames(df2, c("AID","CALCAGE2","ITVDAY2","ITVMONTH2","ITVYEAR2","SI2","SA2","AGE2"))
df2%>%head(10)

# OUTCOME VAR from DF WAVE3
df3=da21600.0008 #21600-0008-dATA.rda
library(dplyr)
library(tidyverse)
df3=select(df3,AID,H3TO130,H3TO131)
df3=setNames(df3, c("AID","SI3","SA3"))

# OUTCOME VAR from DF WAVE3
df4 = da21600.0022 #21600-0022-dATA.rda
library(dplyr)
library(tidyverse)
df4=select(df4,AID,H4SE1,H4SE2)
df4=setNames(df4, c("AID","SI4","SA4"))

# OUTCOME VAR MERGE
#Merge data frame 2,3,4 by AID(unique id number). FOR THIS IMPORT W3 DATA RESULT
df23=merge(df2, df3, by= "AID")
df234=merge(df23,df4, by="AID")
