library(randomForest)		#import library

data = iris					#import data

for(i in 1:25)				#shuffle data
{
	shuf = sample(2,nrow(data),replace=T)
}
#divide example in test and train data
train = data[shuf==1,]
test = data[shuf==2,]

#generate random forest learning tree from train data
data.rf = randomForest(Species~., data = train ,ntree = 1000,proximity = T)
print(data.rf)
table(predict(data.rf), train[,ncol(train)])
plot(data.rf)
x11()
importance(data.rf)
#x11()
varImpPlot(data.rf)

#use generated random forest to predict classes of test data
data.Pred = predict(data.rf, newdata = test)
table(data.Pred, test[,ncol(test)])

x11()
plot(margin(data.rf,test[,ncol(test)]))
#tune random forest
tune.rf = tuneRF(data[,-ncol(data)],data[,ncol(data)],stepFactor = 0.5)
print(tune.rf)


#https://www.analyticsvidhya.com/blog/2015/06/tuning-random-forest-model/
