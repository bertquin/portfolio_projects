## Statistical Analysis of Marketing Campaign
## Data Source: UCI Machine Learning Repository

# Import Libraries

library(tidyverse)
library(dplyr)
library(ggplot2)

# Load the data
df <- read.csv('campaign.csv',stringsAsFactors = FALSE)
bank <- tibble(df)

#View first 5 lines
head(bank,n=5)

#Check the dimension of the data - observations and variables
dim(bank)

# Check the column names
names(bank)

# Check the data types
str(bank)

# Show missing values in the data
sapply(bank, function(x)sum(is.na(x)))

## How successful was the campaign?
yes <- table(bank$subscription)
round(prop.table(yes)*100,3)

## shows distribution of subscription
ggplot(data=bank)+
  geom_bar(mapping=aes(x=subscription, y=..prop..,group=1))

## How is the data distributed within segments?

## Subscription Vs. Contact
# Show frequency table for subscription and channel

con_sub <- table(bank$contact, bank$subscription)
round(prop.table(con_sub)*100,3)

# display subscription segmented by contact channel
ggplot(data=bank)+
  geom_bar(mapping=aes(x=subscription, fill=contact),
           position = "dodge")

##### Marital status vs Subscription
# Show the percentage of subscription broken down by marital status

stat_sub <- table(bank$marital,bank$subscription)
round(prop.table(stat_sub)*100,3)

# Plots marital status vs. subscription

ggplot(data=bank)+
  geom_bar(mapping = aes(x=subscription, fill=marital), 
           position = 'dodge')

## Job vs Subscription
# Show subscriptions based on type of consumer job

job_sub <- table(bank$job, bank$subscription)
round(prop.table(job_sub)*100,3)

## Housing vs Subscription
# Displays subscription rate based on customers with housing loan

hse_sub <- table(bank$housing, bank$subscription)
round(prop.table(hse_sub)*100,3)

## Loan vs Subscription
# Show subscription rate based on previous loan commitment

loan_sub <- table(bank$loan,bank$subscription)
round(prop.table(loan_sub)*100,3)

## Did defaulters subscribe to new term loan?
# show frequency table

def_sub <- table(bank$default, bank$subscription)
round(prop.table(def_sub)*100,3)

# plots loan subscription against defaulters

ggplot(data=bank)+
  geom_bar(mapping=aes(x=subscription, fill=default),
           position = "dodge")

### Is the outcome of the campaign due to chance?
### Let's perform statistical analysis on subscriptions

# Cross tabulate subscription

subs = xtabs(~subscription, data=bank)
subs #show counts
subs

# Commute Pearson's Chi sq. test
chisq.test(subs)

# Binomial test
binom.test(subs)

### Conclusion: 
#The outcome was not due to chance since the p-values in 
# both tests are less than 0.05. We can conclude that the 
# number of subcriptions generated was statistically significant 

