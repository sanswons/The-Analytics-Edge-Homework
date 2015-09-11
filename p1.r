# Intro to R programming
WHO=read.csv("WHO.csv") 
summary(WHO)
Outliers=subset(WHO,GNI>10000&FertilityRate>2.5)
nrow(Outliers)
Outliers[c("Country","GNI","FertilityRate")]