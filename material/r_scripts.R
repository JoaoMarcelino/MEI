library(gplots)
#setwd Marcelino
  #setwd('../Desktop/Universidade/MEI/material/')


#table=read.table("./results/test5.txt",header = TRUE)
#table1 = subset(table, codigo == 1 , select=c(overlapProb,time))
#table2 = subset(table, codigo == 2 , select=c(overlapProb,time))

#plot(table1$overlapProb,y=table1$time,xlab ="Number of Exams",ylab = "Time",main = "Time to compute answer by code2")



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