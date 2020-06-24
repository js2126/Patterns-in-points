setwd("~/Big Data Module/03 - Data Modelling (Clustering)/Project #1")

library(ggplot2)
library(dplyr)
library(maps)
library(dbscan)
library(tidyr)
library(stringr)

#The dataset is Synthetic 2-d data with N=5000 vectors and k=15 Gaussian clusters

synthetic <- read.csv("synthetic.txt")

#First I will check the density
#As the dataset does not have column names, I will need to add first to help identify

names(synthetic)[1] <- "A"
names(synthetic)

#There seems to be 2 columns, however R is viewing it as one dataset

library(splitstackshape)

synthetic <- cSplit(synthetic, "A", " ")

#Now that there are two columns, I now need to label the columsn in a more simple way

names(synthetic)[1] <- "A"
names(synthetic)[2] <- "B"

#Now I will plot to see the density of points before finding clusters

plot(synthetic)

#ALL VALID UP TO HERE
#Write what you notice (multiple obvious cluster points)
# Now we will start to analyse the data, we know there are 15 Gaussian clusters

library(gridExtra)
library(tidyverse)  
library(cluster)   
library(factoextra) 

#We are going to scale to put into reasonable numbers
df <- scale(synthetic)
summary(df)
plot(df)
#We have enough evidence to suggest that there might be meaningful clusters in the data, so we will apply the k-means algorithm to it. 
#Lets see if certain clusters could merge to others

library(factoextra) 
library(grid)
library(ggplot2)

k13 <- kmeans(df, centers = 13, nstart = 25)
k14 <- kmeans(df, centers = 14, nstart = 25)
p3 <- fviz_cluster(k13, geom = "point", data = df) + ggtitle("k = 13")
p4 <- fviz_cluster(k14, geom = "point", data = df) + ggtitle("k = 14")
grid.arrange(p3, p4, nrow = 2)
#As they seem to overload at 13 and 14 cluster points, it is best to stay with 15.
#^ that is the conclusion add on to GitHub


