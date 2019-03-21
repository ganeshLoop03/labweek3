# Enter date into vectors before construction 
# INTO Data frame
date_col <-c("2018-15-10", "2018-01-11", "2018-21-10", "2018-28-10", "2018-01-05")
country_col <-c("US", "US", "IRL", "IRL", "IRL")
gender_col <-c("M", "F", "F", "M", "F")
#99 age is not possible hence needs correcting 

age_col <-c(32, 45, 25, 39, 99)
q1_col <-c(5, 3, 3, 3, 2)
q2_col <-c(4, 5, 5, 3, 2)
q3_col <-c(5, 2, 5, 4, 1)
# missing values have been repalced by NA
q4_col <-c(5, 5, 5, NA, 2)
q5_col <-c(5, 5, 2, NA, 1)

column_names <-c("Date", "Country", "gender", "age", "Q1", "Q2", "Q3", "Q4", "Q5")
# construct a data frame from the above vectors
managers <- data.frame(date_col, country_col, gender_col, age_col, q1_col, q2_col, q3_col, q4_col, q5_col)


# add column names to daraframe using col_names vector
colnames(managers) <- column_names


# Recode the incorrect age data from 99 to NA
managers$age[managers$age ==99] <- NA

# Create a new attribute called age_cat andd set values 
# in age_cat to the following if true
# <=25 = young
# >-26 & <=44 midle age
# recode NA to elder
managers$age_cat[managers$age >=45] <- "Elder"
managers$age_cat[managers$age >=26 & managers$age <=44] <- "Middleage"
managers$age_cat[managers$age <=25] <- "Young"

#record the incorrect age 
managers$age_cat[is.na(managers$age)] <- "Elder"

# to add mean score
summary_col <-managers$Q1 + managers$Q2 + managers$Q3 + managers$Q4 + managers$Q5

managers <- data.frame(managers, summary_col)


# calculate mean for eah row 
mean_value <- rowMeans(managers[5:9])
managers <- data.frame (managers, mean_value)

str (managers)
head(managers)

#change the newly created column names  ##################
names(managers)[12]<- "meanValue"
names(managers)[11]<- "SUM"
names(managers)[10]<- "Category"
managers

## dealing with missing data

new_data <- na.omit(managers)
new_data

#list rows with missing data
complete_data <- complete.cases(managers)
complete_data

#list rows with missing data
managers[!complete.cases(managers),]
# show all missing attributes for age attribute
sum(is.na(managers$age))

install.packages("mice")
library(mice)
