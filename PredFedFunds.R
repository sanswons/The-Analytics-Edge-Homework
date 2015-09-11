fedFunds=read.csv("federalFundsRate.csv",stringsAsFactors=FALSE)
summary(fedFunds)
str(fedFunds)

table(fedFunds$RaisedFedFunds)
294/nrow(fedFunds)
table(fedFunds$Chairman)

fedFunds$Chairman=as.factor(fedFunds$Chairman)
fedFunds$DemocraticPres=as.factor(fedFunds$DemocraticPres)
fedFunds$RaisedFedFunds=as.factor(fedFunds$RaisedFedFunds)

set.seed(201)
library(caTools)
split = sample.split(fedFunds$RaisedFedFunds, 0.7)
training=subset(fedFunds,split==TRUE)
testing=subset(fedFunds,split==FALSE)

LogRegModel=glm(RaisedFedFunds~PreviousRate+Streak+Unemployment+ HomeownershipRate+DemocraticPres+MonthsUntilElection,data=training,family=binomial)
summary(LogRegModel)
LogRegPredict=predict(LogRegModel,newdata=testing,type="response")
table(testing$RaisedFedFunds,LogRegPredict>=0.5)
ROCRpred = prediction(LogRegPredict, testing$RaisedFedFunds)
as.numeric(performance(ROCRpred, "auc")@y.values)
