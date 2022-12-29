# edit by WangLonghao hhuwlh@163.com
# generate data
# MIT License
# Copyright (c) 2022 Longhao Wang

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

# Plot boxplot1
dplot <- data.frame(names,value,lower=c(rep(lower[1], 40), rep(lower[2], 25), rep(lower[3], 35), rep(lower[4], 30)),
                    upper=c(rep(upper[1], 40), rep(upper[2], 25), rep(upper[3], 35),rep(upper[4], 30)), median=c(rep(median[1], 40), rep(median[2], 25), rep(median[3], 35), rep(median[4], 30)))

dplot %>% 
  ggplot(aes(x=names,y=value))+
  geom_boxplot(color="black", fill="black", alpha=0.2, width=0.3, outlier.shape = NA, coef = 0) +
  geom_jitter(color="black", size=1, alpha=0.9, width=0.2)+
  theme_classic()