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

#3. OUTCOME VAR from DF WAVE2
#Set Name
#name variable Suicide ideation to SI2, suicide attemts to SA2 
df2=setNames(df2, c("AID","CALCAGE2","ITVDAY2","ITVMONTH2","ITVYEAR2","SI2","SA2","AGE2"))
df2%>%head(10)

#Merge data frame 2,3,4 by AID(unique id number). FOR THIS IMPORT W3 DATA RESULT
df23=merge(df2, df3, by= "AID")
df234=merge(df23,df4, by="AID")
