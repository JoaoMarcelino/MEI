library(gplots)
library(ggplot2)
library(ggpubr)

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
table=read.table("./results_2/test2_1.txt",header = TRUE)
table = subset(table, minSlots!=-1 )
code1=subset(table, codigo==1 )[1:100,]
code2=subset(table, codigo==2 )[1:100,]


table$code <- as.factor(table$codigo)
p = ggplot(table, aes(x=code, y=time,color=code)) +
  geom_boxplot()+
  labs(y="Time (seconds)")
show(p)

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