# edit by WangLonghao hhuwlh@163.com
# 2022.11.15
# generate data
library(tidyverse)

names <- c(rep("A", 40) , rep("B", 25) , rep("C", 35), rep("D", 30))
value <- c( rnorm(40 , mean=10 , sd=9) , rnorm(25 , mean=2 , sd=15) , rnorm(35 , mean=0 , sd=10) , rnorm(30 , mean=-10 , sd=12))
dplot <- data.frame(names,value)
lower <- dplot$value %>% tapply(names, function(x){
  return(quantile(x, c(0.25)))
})
upper <- dplot$value %>% tapply(names, function(x){
  return(quantile(x, c(0.75)))
})
median <- dplot$value %>% tapply(names, median)

dplot <- data.frame(names,value,
                    lower=c(rep(lower[1], 40), rep(lower[2], 25), rep(lower[3], 35), rep(lower[4], 30)),
                    upper=c(rep(upper[1], 40), rep(upper[2], 25), rep(upper[3], 35),rep(upper[4], 30)), 
                    median=c(rep(median[1], 40), rep(median[2], 25), rep(median[3], 35), rep(median[4], 30)))



#plot boxplot2
dplot %>% 
  ggplot()+
  geom_jitter(aes(x=names,y=value,fill=ifelse(value<0, "positive", "negtive")),width = 0.2,
              size=4, shape=21, color = "#778899")+
  scale_fill_manual(values=c("#F57D98","#83A2FC")) +
  geom_linerange(aes(x=names,y=value,ymin=lower,ymax=upper),size=3,)+
  geom_point(aes(x=names, y=median),size=11,shape=1,stroke=1)+
  theme_classic() +
  theme(legend.position = "none") 