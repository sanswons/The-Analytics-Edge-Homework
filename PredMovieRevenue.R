Movies=read.csv("Movies.csv")
Train=subset(Movies,Year<2010)
Test=subset(Movies,Year>=2010)
str(Train)
names(Movies)

#Linear Model
LinRegModel=lm(Worldwide ~ Rated+Runtime+Action+Adventure+Crime+Drama+Thriller+Fantasy+Horror+Sci.Fi+Comedy+Family+Mystery+Romance+Animation+Music+History+Documentary+Wins+Nominations+Production.Budget,data=Train[ , 3:ncol(Train)])
str(LinRegModel)
summary(LinRegModel)

# LM using the important variables
LinRegModel2=lm(Worldwide~Production.Budget+Nominations+History+Animation+Horror+Crime+Runtime,data=Train[ , 3:ncol(Train)])
summary(LinRegModel2)

LinPredictTest=predict(LinRegModel2,newdata=Test)

#SSE
SSE=sum((Test$Worldwide-LinPredictTest)^2)
SSE

#SST
SST=sum((Test$Worldwide-mean(Train$Worldwide))^2)
SST

#R-squared
1 - SSE/SST

Movies$Performance = factor(ifelse(Movies$Worldwide > quantile(Movies$Worldwide, .75), "Excellent", ifelse(Movies$Worldwide > quantile(Movies$Worldwide, .25), "Average", "Poor")))
table(Movies$Performance)

Movies$Worldwide = NULL

set.seed(15071)
library(caTools)

#Split data
split=sample.split(Movies$Performance,SplitRatio=0.7)
MoviesTrain=subset(Movies,split==TRUE)
MoviesTest=subset(Movies,split==FALSE)
library(rpart)
library(rpart.plot)

#Rcart Model using all variables
RcartModel=rpart(Performance~Rated+Runtime+Action+Adventure+Crime+Drama+Thriller+Fantasy+Horror+Sci.Fi+Comedy+Family+Mystery+Romance+Animation+Music+History+Documentary+Wins+Nominations+Production.Budget, data=MoviesTrain[ ,3:ncol(MoviesTrain)])
RcartPredictTrain=predict(RcartModel,newdata=MoviesTrain,type="class")

#accuracy
table(RcartPredictTrain,MoviesTrain$Performance)
(96+41+46)/nrow(MoviesTrain)

#baseline accuracy
table(MoviesTrain$Performance)
116/nrow(MoviesTrain)

RcartPredictTest=predict(RcartModel,newdata=MoviesTest,type="class")
table(RcartPredictTest,MoviesTest$Performance)
(36+16+16)/nrow(MoviesTest)

#Baseline accuracy of test data
table(MoviesTest$Performance)
50/nrow(MoviesTest)










