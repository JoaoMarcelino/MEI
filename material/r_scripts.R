table=read.table("./results/test2.txt",header = TRUE)

table1 = subset(table, codigo ==2 & nExams<20, select=c(nExams, overlapProb,time))

plot(x=table1$nExams,y=table1$time,xlab ="Number of Exams",ylab = "Time",main = "Time to compute answer by code2")