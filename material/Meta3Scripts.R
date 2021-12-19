library(gplots)
library(ggplot2)
library(ggpubr)


#setwd Marcelino
#setwd('../Desktop/Universidade/MEI/material/')

#Teste 1 -----------------------------------------------------------------------
# table=read.table("./results_2/test1.txt",header = TRUE)
# table = subset(table, minSlots!=-1 )
# table1 = subset(table, codigo == 1 )
# table2 = subset(table, codigo == 2 )
# 
# show(mean(table1$time))
# show(mean(table2$time))
# 
# test = t.test(table1$time, table2$time,alternative="greater", paired = FALSE)
# print(test)

#Teste 2 -----------------------------------------------------------------------
table=read.table("./results_2/test2_1.txt",header = TRUE)
table = subset(table, minSlots!=-1 )
code1=subset(table, codigo==1 )[1:100,]
code2=subset(table, codigo==2 )[1:100,]


p=t.test(code1$time,code2$time,alternative="less",conf.level = 0.9,paired = FALSE)
show(p)

p=t.test(code1$time,code2$time,alternative="greater",conf.level = 0.9,paired = FALSE)
show(p)

#Teste 3 -----------------------------------------------------------------------
table=read.table("./results_2/test3.txt",header = TRUE)
table1 = subset(table, select=c(nExams,time, codigo, overlapProb))

 
 
table1$codigo <- factor(table1$codigo, 
                       levels = c( 1, 2),
                       labels = c("C1", "C2"))
 

p = ggboxplot(table1, x = "nExams", y = "time", pallete = "overlapProb", facet.by = "codigo")



model  <- lm(time ~ codigo*nExams*overlapProb, data = table1)
# Create a QQ plot of residuals
q = ggqqplot(residuals(model))



r = ggqqplot(table1, "time", ggtheme = theme_bw()) +
  facet_grid(codigo + nExams ~ overlapProb, labeller = "label_both")



res.aov <- table1 %>% anova_test(time ~ codigo*nExams*overlapProb)
show(res.aov)


# https://www.datanovia.com/en/lessons/anova-in-r/#computation-2
# Post-hoc tests

show(r)