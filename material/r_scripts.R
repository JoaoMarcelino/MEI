library(gplots)
library(ggplot2)

table=read.table("./results/test6.txt",header = TRUE)
table = subset(table,   minSlots!=-1)
table1 = subset(table, codigo == 1 )
table2 = subset(table, codigo == 2 )

#plot(x=table1$nExams,y=table1$time,xlab ="Number of Exams",ylab = "Time",main = "Time to compute answer by code1")
#plot(x=table2$nExams,y=table2$time,xlab ="Number of Exams",ylab = "Time",main = "Time to compute answer by code2")



#plotmeans(table1$time~table1$overlapProb, data = table1,minbar=0, maxbar=120, col="blue", barcol="white",  frame = FALSE, mean.labels = FALSE, connect = FALSE, n.label=FALSE,xlab = "Overlap Probability", ylab="Time",main="Time to compute answer by code1")
#plotmeans(table2$time~table2$overlapProb, data = table1,minbar=0, maxbar=120, col="blue", barcol="white",  frame = FALSE, mean.labels = FALSE, connect = FALSE, n.label=FALSE,xlab = "Overlap Probability", ylab="Time",main="Time to compute answer by code1")


#plotmeans(table1$time~table1$nExams, data = table1,minbar=0, maxbar=120, col="red", barcol="white",  frame = FALSE,mean.labels = FALSE, connect = FALSE, n.label=FALSE,xlab = "Number of Exams", ylab="Time",main="Time to compute answer by code1")
#plotmeans(table2$time~table2$nExams, data = table2,minbar=0, maxbar=120, col="red", barcol="white",  frame = FALSE,mean.labels = F, connect = F, n.label=FALSE,xlab = "Number of Exams", ylab="Time",main="Time to compute answer by code2")


tableOfMeans= function(table,numberOfSampesRequired){
  tableOfMeans=setNames(data.frame(matrix(ncol = 3, nrow = 0)), c("overlapProb", "nExams", "time"))
  
  i=1
  while(i<=nrow(table)){
    print(i)
    
    row=table[i,]
    table1 = subset(table, (overlapProb==row$overlapProb & nExams==row$nExams))

    if(nrow(table1)>=numberOfSampesRequired) {
      table1=table1[1:numberOfSampesRequired,]
      meanTime=mean(table1$time)
      
      newRow=data.frame(row$nExams,row$overlapProb,meanTime)
      names(newRow)=c("nExams","overlapProb","time")
      tableOfMeans = rbind(tableOfMeans, newRow)
      
    }
        
    table=subset(table,!(overlapProb==row$overlapProb & nExams==row$nExams))
    i=i+1
  }
  return(tableOfMeans)
}
# 
# table3=tableOfMeans(table1,5)
# table3=subset(table3,nExams>20)
# ggplot(table3,aes(x=overlapProb,y=nExams))+
#   geom_point(aes(size=time))
# 
# table3=tableOfMeans(table2,5)
# table3=subset(table3,nExams>20)
# ggplot(table3,aes(x=overlapProb,y=nExams))+
#   geom_point(aes(size=time))+
#   labs(x="Overlap Probability", y="Number of Exams")

table3=tableOfMeans(table1,10)
ggplot(table3,aes(x=nExams,y=time))+
  geom_point(size=2)+
  labs(x="Number of Exams",y="Time")

#plotmeans(table1$time~table1$overlapProb, data = table1,minbar=0, maxbar=120, col="blue", barcol="white",  frame = FALSE,mean.labels = FALSE, connect = FALSE, n.label=FALSE)

#plotmeans(table2$time~table2$overlapProb, data = table2,minbar=0, maxbar=120, col="red", barcol="white",  frame = FALSE,mean.labels = FALSE, connect = FALSE, n.label=FALSE)


test1 <- function(){
  par(mfrow=c(2,2))
  table=read.table("./results/test1.txt",header = TRUE)
  maxTime <- table$maxTime[1]
  table1 = subset(table, codigo == 1 , select=c(overlapProb, nExams, time))
  table2 = subset(table, codigo == 2 , select=c(overlapProb, nExams, time))
  
  plotmeans(table1$time~table1$nExams, xlab ="Number of Exams",ylab = "Time", data = table1,minbar=0, maxbar= maxTime, col="blue", barcol="white",  frame = FALSE,mean.labels = FALSE, connect = FALSE, n.label=FALSE)
  
  plotmeans(table2$time~table2$nExams, xlab ="Number of Exams",ylab = "Time", data = table1,minbar=0, maxbar= maxTime, col="red", barcol="white",  frame = FALSE,mean.labels = FALSE, connect = FALSE, n.label=FALSE)
  
  plotmeans(table1$time~table1$overlapProb, xlab ="Overlap Probability",ylab = "Time", data = table1,minbar=0, maxbar= maxTime, col="blue", barcol="white",  frame = FALSE,mean.labels = FALSE, connect = FALSE, n.label=FALSE)
  
  plotmeans(table2$time~table2$overlapProb, xlab ="Overlap Probability",ylab = "Time", data = table1,minbar=0, maxbar= maxTime, col="red", barcol="white",  frame = FALSE,mean.labels = FALSE, connect = FALSE, n.label=FALSE)
  
  
  #plot(table1$nExams,y=table1$time, xlab ="Number of Exams",ylab = "Time",main = "Time to compute answer by code1")
  #plot(table2$nExams,y=table2$time, xlab ="Number of Exams",ylab = "Time",main = "Time to compute answer by code2")

  #plot(table1$overlapProb,y=table1$time, xlab ="Overlap Probability",ylab = "Time",main = "Time to compute answer by code1")
  #plot(table2$overlapProb,y=table2$time, xlab ="Overlap Probability",ylab = "Time",main = "Time to compute answer by code2")
  
}

test2 <- function(){
  par(mfrow=c(2,1))
  table=read.table("./results/test2.txt",header = TRUE)
  table1 = subset(table, codigo == 1 , select=c(nExams,time))
  table2 = subset(table, codigo == 2 , select=c(nExams,time))
  
  plot(table1$nExams,y=table1$time, xlab ="Number of Exams",ylab = "Time",main = "Time to compute answer by code1")
  plot(table2$nExams,y=table2$time, xlab ="Number of Exams",ylab = "Time",main = "Time to compute answer by code2")
}

test3 <- function(){
  par(mfrow=c(2,1))
  table=read.table("./results/test3.txt",header = TRUE)
  table1 = subset(table, codigo == 1 & time<4 & overlapProb>0.7, select=c(overlapProb,time))
  table2 = subset(table, codigo == 2 & time<4 & overlapProb>0.7, select=c(overlapProb,time))
  
  plot(table1$overlapProb,y=table1$time, xlab ="Overlap Probability",ylab = "Time",main = "Time to compute answer by code1")
  plot(table2$overlapProb,y=table2$time, xlab ="Overlap Probability",ylab = "Time",main = "Time to compute answer by code2")
}

test5 <- function(){
  par(mfrow=c(2,1))
  table=read.table("./results/test5.txt",header = TRUE)
  table1 = subset(table, codigo == 1 , select=c(overlapProb,time))
  table2 = subset(table, codigo == 2 , select=c(overlapProb,time))
  
  maxTime <- table$maxTime[1]
  
  plotmeans(table1$time~table1$overlapProb, xlab ="Overlap Probability",ylab = "Time", data = table1,minbar=0, maxbar= maxTime, col="blue", barcol="white",  frame = FALSE,mean.labels = FALSE, connect = FALSE, n.label=FALSE)
  plotmeans(table2$time~table2$overlapProb, xlab ="Overlap Probability",ylab = "Time", data = table1,minbar=0, maxbar= maxTime, col="red", barcol="white",  frame = FALSE,mean.labels = FALSE, connect = FALSE, n.label=FALSE)
}

test5()
