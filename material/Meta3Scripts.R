library(gplots)
library(ggplot2)
library(ggpubr)

#setwd Marcelino
#setwd('../Desktop/Universidade/MEI/material/')


#table=read.table("./results_2/test1.txt",header = TRUE)
#table1 = subset(table, codigo == 1 )
#table2 = subset(table, codigo == 2 )


#test = t.test(table1$time, table2$time, paired = TRUE)
#print(test)

table=read.table("./results_2/test3.txt",header = TRUE)
table1 = subset(table, overlapProb == 0.10, select=c(nExams,time, codigo))
table2 = subset(table, codigo == 1 & nExams == 10, select=c(overlapProb,time, codigo))


table1$codigo <- factor(table1$codigo, 
                       levels = c( 1, 2),
                       labels = c("C1", "C2"))



p = ggboxplot(table1, x = "nExams", y = "time", color = "codigo",
          palette = c("#00AFBB", "#E7B800"))

p =ggline(table1, x = "nExams", y = "time", color = "codigo",
       add = c("mean_se", "dotplot"),
       palette = c("#00AFBB", "#E7B800"))


#if time depends on codigo and nExams.
res.aov2 <- aov(time ~ codigo + nExams, data = table1)
summary(res.aov2)


# Two-way ANOVA with interaction effect
# These two calls are equivalent
res.aov3 <- aov(time ~ codigo * nExams, data = table1)

print(p)