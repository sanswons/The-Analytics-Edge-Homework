usda=read.csv("USDA.csv")
str(usda)
summary(usda)
usda$Sodium
which.max(usda$Sodium)

names(usda)
HighSodium=subset(usda,Sodium>10000)
nrow(HighSodium)
HighSodium$Description

 
usda$Sodium[match("CAVIAR",usda$Description)]
summary(usda$Sodium)
sd( usda$Sodium)
sd( usda$Sodium,na.rm=TRUE)

