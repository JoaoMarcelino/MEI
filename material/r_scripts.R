library(gplots)
library(ggplot2)
library(ggpubr)

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

#setwd Marcelino
#setwd('../Desktop/Universidade/MEI/material/')


#table=read.table("./results/test5.txt",header = TRUE)
#table1 = subset(table, codigo == 1 , select=c(overlapProb,time))
#table2 = subset(table, codigo == 2 , select=c(overlapProb,time))

#plot(table1$overlapProb,y=table1$time,xlab ="Number of Exams",ylab = "Time",main = "Time to compute answer by code2")



#plotmeans(table1$time~table1$overlapProb, data = table1,minbar=0, maxbar=120, col="blue", barcol="white",  frame = FALSE,mean.labels = FALSE, connect = FALSE, n.label=FALSE)


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
  blue='#00BFC4'
  red='#F8766D'
  table=read.table("./results/test1.txt",header = TRUE)
  table = subset(table, minSlots!=-1 )
  table1 = subset(table, codigo == 1 )
  table2 = subset(table, codigo == 2 )
  
  table3=tableOfMeans(table1,5)
  table4=tableOfMeans(table2,5)
  
  p1=ggplot(subset(table3,overlapProb==0.04 ),aes(x=nExams,y=time))
  p1=p1+  geom_point(size=2,color=blue)
  p1=p1+  labs(x="Number of Exams",y="Time (seconds)")  
  
  p2=ggplot(subset(table3,nExams==30),aes(x=overlapProb,y=time))
  p2=p2+  geom_point(size=2,color=blue)
  p2=p2+  labs(x="Overlap Probability",y="Time (seconds)")
  
  p3=ggplot(subset(table4,overlapProb==0.04),aes(x=nExams,y=time))
  p3=p3+  geom_point(size=2,color=red)
  p3=p3+  labs(x="Number of Exams",y="Time (seconds)")  
  
  p4=ggplot(subset(table4,nExams==30),aes(x=overlapProb,y=time))
  p4=p4+  geom_point(size=2,color=red)
  p4=p4+  labs(x="Overlap Probability",y="Time (seconds)")
  
  
  p5=ggarrange(p1, p2, p3,p4, 
            labels = c("(a)", "(b)", "(C)","(d)"),
            ncol = 2, nrow = 2)
  print(p5)
}

test2 <- function(){
  blue='#00BFC4'
  red='#F8766D'
  table=read.table("./results/test2.txt",header = TRUE)
  table$codigo=as.character(table$codigo)
  
  table1 = subset(table, codigo == 1 )
  table2 = subset(table, codigo == 2 )
  
  p=ggplot(table,aes(x=nExams,y=time))+  
    geom_point(size=2,aes(shape=codigo,color=codigo))+
    scale_color_manual(values=c(blue,red))+
    labs(x="Number of Exams",y="Time")
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

test2_3 <- function(){
  blue='#00BFC4'
  red='#F8766D'
  
  table=read.table("./results/test2.txt",header = TRUE)
  table$codigo=as.character(table$codigo)
  colnames(table)[which(names(table) == "codigo")] <- "code"
  
  table1 = subset(table, code == 1 )
  table2 = subset(table, code == 2 )
  
  p1=ggplot(table,aes(x=nExams,y=time))+  
    geom_point(size=2,aes(shape=code,color=code))+
    scale_color_manual(values=c(blue,red))+
    labs(x="Number of Exams",y="Time (seconds)")
  
  table=read.table("./results/test3.txt",header = TRUE)
  table$codigo=as.character(table$codigo)
  colnames(table)[which(names(table) == "codigo")] <- "code"
  
  table1 = subset(table, code == 1 )
  table2 = subset(table, code == 2 )
  
  p2=ggplot(table,aes(x=overlapProb,y=time))+  
    geom_point(size=2,aes(shape=code,color=code))+
    scale_color_manual(values=c(blue,red))+
    labs(x="Overlap Probability",y="Time (seconds)")
  
  p5=ggarrange(p1, p2, 
               
               ncol = 1, nrow = 2)
  print(p5)
}

test5 <- function(){
  par(mfrow=c(2,1))
  table=read.table("./results/test5_15.txt",header = TRUE)
  table1 = subset(table, codigo == 1 , select=c(overlapProb, time, minSlots))
  table2 = subset(table, codigo == 2 , select=c(overlapProb, time, minSlots))
  
  
  maxTime <- table$maxTime[1]
  
  plotmeans(table1$time~table1$overlapProb, xlab ="Overlap Probability",ylab = "Time", data = table1,minbar=0, maxbar= maxTime, col="blue", barcol="white",  frame = FALSE,mean.labels = FALSE, connect = FALSE, n.label=FALSE)
  plotmeans(table2$time~table2$overlapProb, xlab ="Overlap Probability",ylab = "Time", data = table1,minbar=0, maxbar= maxTime, col="red", barcol="white",  frame = FALSE,mean.labels = FALSE, connect = FALSE, n.label=FALSE)
}

test6 <- function(){
  blue='#00BFC4'
  red='#F8766D'
  table=read.table("./results/test6_1.txt",header = TRUE)
  colnames(table)[which(names(table) == "codigo")] <- "code"
  table$code=as.character(table$code)
  table = subset(table,   minSlots!=-1)
  table1=tableOfMeans(subset(table,code==1),5)
  table2=tableOfMeans(subset(table,code==2),5)
  table1$code="1"
  table2$code="2"
  table3=rbind(table1,table2)
  p=ggplot(table3,aes(x=nExams,y=time,color=code,shape=code))+
    geom_point(size=2)+  
    labs(x="Number of Exams",y="Time (seconds)")+
    scale_color_manual(values=c(blue,red))+
    geom_smooth(method=lm, se=FALSE, fullrange=TRUE)
  print(p)
  #p1=plot(lm(time~nExams,data=table2))
  #print(p1)
  lr.out=lm(log(table2$time)~table2$nExams)
  print(summary(lr.out))
  
  
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
  table=read.table("./results/test5_15.txt",header = TRUE)
  table = subset(table,)
  table$codigo=as.character(table$codigo)
  table1 = subset(table, codigo == 1 )
  table2 = subset(table, codigo == 2 )
  
  p=ggplot(table, aes(x=time, color=codigo, fill=codigo )) +
    geom_histogram(alpha=0.7, position="dodge")
  print(p)
  
}

test10 <- function(){
  table=read.table("./results/test8.txt",header = TRUE)
  table$codigo=as.character(table$codigo)
  table = subset(table,   minSlots!=-1)
  
  table1 = subset(table, codigo == 1 )
  table2 = subset(table, codigo == 2 )
  
  p=ggplot(table,aes(x=overlapProb,y=time))
  p=p+  geom_point(size=2,aes(color=codigo))
  p=p+  labs(x="Overlap Probability",y="Time")
  print(p)
}

test11 <- function(){
  blue='#00BFC4'
  red='#F8766D'
  table=read.table("./results/test7.txt",header = TRUE)
  table$codigo=as.character(table$codigo)
  colnames(table)[which(names(table) == "codigo")] <- "code"
  table = subset(table,   minSlots!=-1)

  
  p=ggplot(table, aes(x=time, color=code, fill=code)) +
    geom_histogram(alpha=0.2, position="identity",bins = 30)+
    geom_vline(data=subset(table,   code==1), aes(xintercept=mean(time), color=code),
               linetype="dashed")+
    geom_vline(data=subset(table,   code==2), aes(xintercept=mean(time), color=code),
               linetype="dashed")+
    scale_color_manual(values=c(blue,red))+
    scale_fill_manual(values=c(blue,red))+
    labs(x="Runtime (seconds)",y="Seed Count")
  print(p)
}

test12 <- function(){
  blue='#00BFC4'
  red='#F8766D'
  table=read.table("./results/test7_1.txt",header = TRUE)
  table$codigo=as.character(table$codigo)
  table$overlapProb=as.character(table$overlapProb)
  colnames(table)[which(names(table) == "codigo")] <- "code"
  table = subset(table,   minSlots!=-1)
  
  p = ggplot(table, aes(x=overlapProb, y=time,fill=code)) + 
    geom_boxplot()+
    ylim(-0.5, 2)+
    scale_color_manual(values=c(blue,red))+
    scale_fill_manual(values=c(blue,red))+
    labs(x="Overlap Probability",y="Runtime (seconds)")
  print(p)
  print(nrow(subset(table,   overlapProb==0.78)))
}


test12()








