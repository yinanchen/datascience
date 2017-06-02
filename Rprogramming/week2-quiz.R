# TODO: Add comment
# 
# Author: yachenq
###############################################################################

#q1
library(datasets)
data(iris)
dataset <- split(iris, iris$Species)
#print(dataset$virginica)
lapply(dataset$virginica['Sepal.Length'], mean)
colMeans(dataset$virginica['Sepal.Length'], dims =1)

#q2
apply(dataset$virginica[,1:4], 2, mean)
#Best
tapply(iris$Sepal.Length, iris$Species, mean)

#q3
library(datasets)
data(mtcars)
sapply(split(mtcars$mpg, mtcars$cyl), mean)
tapply(mtcars$mpg, mtcars$cyl, mean)
with(mtcars, tapply(mpg, cyl, mean))

#q4
x <- tapply(mtcars$hp, mtcars$cyl, mean)
print(x['8'] - x['4'])

#q5
debug(ls)
ls(1,2)
