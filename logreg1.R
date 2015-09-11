quality=read.csv("quality.csv")
str(quality)
table(quality$PoorCare)
98/131

set.seed(88)
split=sample.split(quality$PoorCare,SplitRatio=0.75)
split
qualityTrain=subset(quality,split==TRUE)
qualityTest=subset(quality,split==FALSE)
nrow(qualityTrain)
QualityLog=glm(PoorCare~OfficeVisits+Narcotics,data=qualityTrain,family=binomial)
summary(QualityLog)

predictTrain=predict(QualityLog,type="response")
summary(predictTrain)
tapply(predictTrain,qualityTrain$PoorCare,mean       )
QualityLog2=glm(PoorCare~ StartOnCombination + ProviderCount,data=qualityTrain,family=binomial)
