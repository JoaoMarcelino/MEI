
# test1=function(){
table=read.table("./results_2/test2.txt",header = TRUE)

table = subset(table, minSlots!=-1 )

codigo1Table=subset(table, codigo==1 )
codigo2Table=subset(table, codigo==2 )



p=t.test(codigo1Table$time,codigo2Table$time,conf.level=0.90,alternative="greater",paired = FALSE)


show(p)
# }
# 
# 
# test1()

