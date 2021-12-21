library(gplots)
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(rstatix)


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
#table=read.table("./results_2/test2.txt",header = TRUE)
#table = subset(table, minSlots!=-1 )
#codigo1=subset(table, codigo==1 )
#codigo2=subset(table, codigo==2 )


#p=t.test(codigo1$time,codigo2$time,alternative="less",paired = FALSE)
#show(p)

#Teste 3 -----------------------------------------------------------------------
table=read.table("./results_2/test4.txt",header = TRUE)
table1 = subset(table,select=c(nExams,time, codigo, overlapProb))

 
 
table1$codigo <- factor(table1$codigo, 
                       levels = c( 1, 2),
                       labels = c("C1", "C2"))

table1$nExams <- factor(table1$nExams,
                        levels = c( 5, 10, 15, 20),
                        labels = c("n5", "n10", "n15", "n20"))


table1$overlapProb <- factor(table1$overlapProb,
                        levels = c( 0.1, 0.3, .5, 0.7, 0.9),
                        labels = c("p10", "p30", "p50", "p70", "p90"))
 

bxp <- ggboxplot(
  table1, x = "overlapProb", y = "time",
  color = "nExams", facet.by = "codigo", ylim = c(0,1))


model  <- lm(time ~ codigo*nExams*overlapProb, data = table1)
# Create a QQ plot of residuals
qq = ggqqplot(residuals(model), ggtheme = theme_bw())

show(shapiro_test(residuals(model)))

r = ggqqplot(table1,"time",ggtheme = theme_bw(),) + 
  facet_grid(codigo + nExams ~ overlapProb, labeller = "label_both")



three.way = aov(time ~ codigo*nExams*overlapProb, data = table1)

show(summary(three.way))

res.aov <- table1 %>% anova_test(time ~ codigo*nExams*overlapProb)
show(res.aov)

# https://www.datanovia.com/en/lessons/anova-in-r/#computation-2
# Post-hoc tests

show(qq)


show("Two Way")


#POST HOC
# simple two-way interactions

model  <- lm(time ~ codigo*nExams*overlapProb, data = table1)
groupedBy <- table1 %>%
  group_by(overlapProb) %>%
  anova_test(time ~ nExams*codigo, error = model)

show(groupedBy)


#simple simple main effects
pp <-table1 %>%group_by(overlapProb) %>%group_by(overlapProb, codigo) %>%anova_test(time ~ nExams, error = model)

show(pp)

# # Group the data by gender and risk, and fit  anova
# treatment.effect <- table1 %>%
#   group_by(codigo, overlapProb) %>%
#   anova_test(time ~ nExams, error = model)
# treatment.effect %>% filter(codigo == "c1")






# Two Way anova between nExams and overlapProb
# 
# table2 = subset(table, select=c(nExams,time, overlapProb))
# 
# table2$nExams <- factor(table2$nExams,
#                         levels = c( 5, 10, 15, 20),
#                         labels = c("n5", "n10", "n15", "n20"))
# 
# bxp2 <- ggboxplot(
#   table2, x = "overlapProb", y = "time",
#   color = "nExams")
# 
# show(bxp2)
# 
# 
# # Build the linear model
# 
# model  <- lm(time ~ nExams * overlapProb,
#              data = table2)
# 
# #Create a QQ plot of residuals
# qqplot <- ggqqplot(residuals(model))
# 
# goodplot <- ggqqplot(table2, "time", ggtheme = theme_bw()) +
#   facet_grid(nExams ~ overlapProb)
# 
# show(goodplot)
# 
# res.aov <- table2 %>% anova_test(time ~ nExams * overlapProb)
# show(res.aov)

