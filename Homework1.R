rm(list=ls())
#(a) Import the data to R. Copy the R code used below.
library(arules)
fp.df <- read.csv("transactions.csv")

# remove first column
fp.df1<-fp.df[,-1]

# create a binary incidence matrix
fp.df2 <- ifelse(fp.df1 > 0, 1, 0)

#  convert the binary incidence matrix into a transactions database
fp.mat <- as.matrix(fp.df2)
fp.trans <- as(fp.mat, "transactions")
inspect(fp.trans)

# plot data
itemFrequencyPlot(fp.trans)

# run apriori function
#(b) Set Support to 0.01, Confidence to 0.10, and Min Length to 2. Run apriori to obtain the rules. Sort
#the rules according to “Lift” with descending order. Copy the R code used below.
rules <- apriori(fp.trans, parameter = list(supp = 0.01, conf = 0.10, target = "rules",minlen=2))
inspect(rules)
inspect(sort(rules, by = "lift"))

#(c) Show the top ten Association Rules. Copy the code used and the result below
inspect(head(sort(rules, by = "lift"), n = 10))

#(d) What is the highest lift value for the resulting rules? Which rule has this value? Show how this lift
#value was calculated.
#(e) Interpret the first five rules in the output in words.
#(f) Reviewing the top 10 rules, based on their lift ratios, comment on their redundancy and how you
#would assess their utility as a decision maker.