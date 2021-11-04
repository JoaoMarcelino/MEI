library(gplots)
library(ggplot2)
tableOfMeans= function(table,numberOfSampesRequired){
  tableOfMeans=setNames(data.frame(matrix(ncol = 3, nrow = 0)), c("overlapProb", "nExams", "time"))
  
  i=1
  while(i<=nrow(table)){
    
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


tableOfAnswerProbability= function(table,numberOfSampesRequired,timeLimit){
  tableOfMeans=setNames(data.frame(matrix(ncol = 3, nrow = 0)), c("overlapProb", "nExams", "prob"))
  
  i=1
  while(i<=nrow(table)){
    
    row=table[i,]
    table1 = subset(table, (overlapProb==row$overlapProb & nExams==row$nExams))
    totalRows=nrow(table1)
    
    if(totalRows>=numberOfSampesRequired) {
      table1=table1[1:numberOfSampesRequired,]
      nConcluded=length(which(table1$time<timeLimit))
      totalRows=nrow(table1)
      ratio=nConcluded/totalRows
      
      newRow=data.frame(row$nExams,row$overlapProb,ratio)
      names(newRow)=c("nExams","overlapProb","prob")
      
      tableOfMeans = rbind(tableOfMeans, newRow)
      
    }
    
    table=subset(table,!(overlapProb==row$overlapProb & nExams==row$nExams))
    i=i+1
  }
  return(tableOfMeans)
}

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
  table=read.table("./results/test2.txt",header = TRUE)
  table$codigo=as.character(table$codigo)
  
  table1 = subset(table, codigo == 1 )
  table2 = subset(table, codigo == 2 )
  
  p=ggplot(table,aes(x=nExams,y=time))
  p=p+  geom_point(size=2,aes(color=codigo))
  p=p+  labs(x="Number of Exams",y="Time")
  print(p)
}

test3 <- function(){
  table=read.table("./results/test3.txt",header = TRUE)
  table$codigo=as.character(table$codigo)
  
  table1 = subset(table, codigo == 1 )
  table2 = subset(table, codigo == 2 )
  
  p=ggplot(table,aes(x=overlapProb,y=time))
  p=p+  geom_point(size=2,aes(color=codigo))
  p=p+  labs(x="Overlap Probability",y="Time")
  print(p)
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

test6 <- function(){
  table=read.table("./results/test6.txt",header = TRUE)
  table$codigo=as.character(table$codigo)
  table = subset(table,   minSlots!=-1)
  table1 = subset(table, codigo == 1 )
  table2 = subset(table, codigo == 2 )
  
  table3=tableOfMeans(table1,10)
  table3$codigo="1"
  table4=tableOfMeans(table2,10)
  table4$codigo="2"
  table5=rbind(table3,table4)
  p=ggplot(table5,aes(x=nExams,y=time))
  p=p+  geom_point(size=2,aes(color=codigo))
  p=p+  labs(x="Number of Exams",y="Time")
  print(p)
}

test7 <- function(){
  table=read.table("./results/test6.txt",header = TRUE)
  table$codigo=as.character(table$codigo)
  table1 = subset(table, codigo == 1 )
  table2 = subset(table, codigo == 2 )
  maxTimes=c(0.1,1,10,100)
  
  table5=setNames(data.frame(matrix(ncol = 5, nrow = 0)), c("overlapProb", "nExams", "prob","codigo","maxTime"))
  for (value in maxTimes){
    table3=tableOfAnswerProbability(table1,10,value)
    table3$codigo="1"
    table3$maxTime=value
    table5=rbind(table5,table3)
  }
  table5$maxTime=as.character(table5$maxTime)
  p=ggplot(data=table5, aes(x=nExams, y=prob,group=maxTime)) +
    geom_line(linetype = "dashed",aes(color=maxTime))+
    geom_point(size=3,aes(color=maxTime))+
    ylim(0, 1)+
    labs(x="Number of Exams",y="Probability of Computing in Time")
  print(p)
  
  print(table5)
}

test8 <- function(){
  table=read.table("./results/test5_1.txt",header = TRUE)
  table$codigo=as.character(table$codigo)
  table1 = subset(table, codigo == 1 )
  table2 = subset(table, codigo == 2 )
  maxTimes=c(0.5)
  
  table5=setNames(data.frame(matrix(ncol = 5, nrow = 0)), c("overlapProb", "nExams", "prob","codigo","maxTime"))
  
  for (value in maxTimes){
    table3=tableOfAnswerProbability(table1,5,value)
    table3$codigo="1"
    table3$maxTime=value
    table5=rbind(table5,table3)
  }
  
  table5$maxTime=as.character(table5$maxTime)
  p=ggplot(data=table5, aes(x=overlapProb, y=prob,group=maxTime)) +
    geom_point(size=2,aes(color=maxTime,shape=maxTime))+
    ylim(0, 1)+
    labs(x="Overlap Probability",y="Probability of Computing in Time")
  print(p)
  
}

test9 <- function(){
  table=read.table("./results/test7.txt",header = TRUE)
  table = subset(table,   minSlots!=-1)
  table$codigo=as.character(table$codigo)
  table1 = subset(table, codigo == 1 )
  table2 = subset(table, codigo == 2 )
  
  p=ggplot(table, aes(x=time, color=codigo)) +
    geom_histogram(fill="white")
  print(p)
  
}


test9()








