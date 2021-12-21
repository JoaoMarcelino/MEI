library(gplots)
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(rstatix)

tTest=function(a,b,alpha,less=TRUE,plot=TRUE){
  x=mean(a)-mean(b)
  n1=length(a)
  n2=length(b)
  s1=sd(a)
  s2=sd(b)
  sx=sqrt((s1^2/n1)+(s2^2/n2))
  if(less==TRUE){
    t=x/sx
  }
  else{
    t=x/sx
  }
 
  
  ndf= (s1^2/n1+s2^2/n2)^2 /( (s1^2/n1)^2/(n1-1) + (s2^2/n2)^2/(n2-1) )
  
  if(less==TRUE){
    r=-qt(1-alpha,df = ndf)
    p=pt(q = t,df = ndf,lower.tail = TRUE)
  }
  else{
    r=qt(1-alpha,df = ndf)
    p=pt(q = t,df = ndf,lower.tail = FALSE)
  }
  
  show(round(ndf))
  
  show(t)
  show(r)
  show(p)

  if(plot==TRUE){
    x=seq(-5, 5, by = 0.01)
    y=dt(x, df = ndf)
    df=data.frame(x,y)
    line.data <- data.frame(xintercept = c(r, t), Lines = c("critical value (r)", "test statistic (t)"),
                            color = c("red", "blue"), stringsAsFactors = FALSE)
    p=ggplot(data=df,mapping=aes(x=x, y=y))+
      geom_line()+
      geom_area(mapping = aes(x = ifelse(x>r , x, r)), fill = "red",position = "identity")+
      geom_vline(aes(xintercept = xintercept, color = Lines), line.data, size = 1) +
      scale_colour_manual(values = line.data$color)+
      labs(title="Welch's t-test")+
      theme(legend.position="bottom")
      
    show(p)
  }
  
}

#setwd Marcelino
#setwd('../Desktop/Universidade/MEI/material/')

#Teste 1 -----------------------------------------------------------------------
# table=read.table("./results_2/test1.txt",header = TRUE)
# table = subset(table, minSlots!=-1 )
# code1 = subset(table, codigo == 1 )
# code2 = subset(table, codigo == 2 )
# 
# table$code <- as.factor(table$codigo)
# p = ggplot(table, aes(x=code, y=time,color=code)) +
#   geom_boxplot()+
#   labs(y="Time (seconds)")
# show(p)
# 
# a=code1$time
# b=code2$time
# tTest(a,b,0.10,FALSE,TRUE)
# 
# test = t.test(code1$time, code2$time,conf.level = 0.9,alternative="greater", paired = FALSE)
# print(test)
# test = t.test(code1$time, code2$time,conf.level = 0.9,alternative="less", paired = FALSE)
# print(test)

#Teste 2 -----------------------------------------------------------------------
<<<<<<< HEAD
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
=======
table=read.table("./results_2/test2_1.txt",header = TRUE)
table = subset(table, minSlots!=-1 )
code1=subset(table, codigo==1 )[1:100,]
code2=subset(table, codigo==2 )[1:100,]
>>>>>>> a3e47d0fd1cbce0c61f5ecd75f88512479c30846


table$code <- as.factor(table$codigo)
p = ggplot(table, aes(x=code, y=time,color=code)) +
  geom_boxplot()+
  labs(y="Time (seconds)")
show(p)

<<<<<<< HEAD
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

=======
a=code1$time
b=code2$time
tTest(a,b,0.10,FALSE,TRUE)

# p=t.test(code1$time,code2$time,alternative="less",conf.level = 0.9,paired = FALSE)
# show(p)

p=t.test(code1$time,code2$time,alternative="greater",conf.level = 0.9,paired = FALSE)
show(p)

#Teste 3 -----------------------------------------------------------------------
# table=read.table("./results_2/test3.txt",header = TRUE)
# table1 = subset(table, select=c(nExams,time, codigo, overlapProb))
# 
# 
# 
# table1$codigo <- factor(table1$codigo,
#                        levels = c( 1, 2),
#                        labels = c("C1", "C2"))
# 
# 
# p = ggboxplot(table1, x = "nExams", y = "time", pallete = "overlapProb", facet.by = "codigo")
# 
# 
# 
# model  <- lm(time ~ codigo*nExams*overlapProb, data = table1)
# # Create a QQ plot of residuals
# q = ggqqplot(residuals(model))
# 
# 
# 
# r = ggqqplot(table1, "time", ggtheme = theme_bw()) +
#   facet_grid(codigo + nExams ~ overlapProb, labeller = "label_both")
# 
# 
# 
# res.aov <- table1 %>% anova_test(time ~ codigo*nExams*overlapProb)
# show(res.aov)
# 
# 
# # https://www.datanovia.com/en/lessons/anova-in-r/#computation-2
# # Post-hoc tests
# 
# show(r)
>>>>>>> a3e47d0fd1cbce0c61f5ecd75f88512479c30846
