library(gplots)

table=read.table("./results/test5.txt",header = TRUE)
table1 = subset(table, codigo == 1 , select=c(overlapProb,time))
table2 = subset(table, codigo == 2 , select=c(overlapProb,time))

#plot(table1$overlapProb,y=table1$time,xlab ="Number of Exams",ylab = "Time",main = "Time to compute answer by code2")



plotmeans(table1$time~table1$overlapProb, data = table1,minbar=0, maxbar=120, col="blue", barcol="white",  frame = FALSE,mean.labels = FALSE, connect = FALSE, n.label=FALSE)

plotmeans(table2$time~table2$overlapProb, data = table2,minbar=0, maxbar=120, col="red", barcol="white",  frame = FALSE,mean.labels = FALSE, connect = FALSE, n.label=FALSE)
