library(gplots)
library(ggplot2)
library(ggpubr)


table=read.table("./results_2/test1.txt",header = TRUE)
table1 = subset(table, codigo == 1 )
table2 = subset(table, codigo == 2 )


test = t.test(table1$time, table2$time, paired = TRUE)
print(test)