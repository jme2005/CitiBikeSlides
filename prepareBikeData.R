setwd("/Users/jme2005/coursera/rmap")
filename<-"2013-09 - Citi Bike trip data.csv"
bike<-read.csv(filename,nrow=5)
classes<-sapply(bike,class)
bike<-read.csv(filename,nrow=1034360)

names(bike)<-gsub("\\.","",names(bike))
bike$endstationid=as.factor(bike$endstationid)
bike$startstationid=as.factor(bike$startstationid)
bikeData<-aggregate(tripduration~endstationid+startstationid,data=bike,FUN=mean)
tmp1<-as.data.frame(table(bike$endstationid,bike$startstationid))
names(tmp1)[1:2]=c("endstationid","startstationid")
bikeData$endstationid=as.factor(bikeData$endstationid)
bikeData$startstationid=as.factor(bikeData$startstationid)
bikeData<-join(bikeData,tmp1)

tmp2<-data.frame(endstationid=unique(bike$endstationid),latitude=unique(bike$endstationlatitude),longitude=unique(bike$endstationlongitude))
bikeData<-join(bikeData,tmp2)
tmp3<-data.frame(startstationname=unique(bike$startstationname),startstationid=unique(bike$startstationid))
bikeData<-join(bikeData,tmp3)
tmp4<-data.frame(startstationid=unique(bike$startstationid),
                 Slatitude=unique(bike$startstationlatitude),
                 Slongitude=unique(bike$startstationlongitude))
bikeData<-join(bikeData,tmp4)
names(tmp3)<-c("endstationname","endstationid")
bikeData<-join(bikeData,tmp3)
setwd("/Users/jme2005/coursera/DataProd")

write.csv(bikeData,"./data/bikeData.csv",row.names=F)
