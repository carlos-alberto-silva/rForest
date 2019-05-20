![Github](https://img.shields.io/badge/CRAN-0.0.1-green.svg)
![Github](https://img.shields.io/badge/Github-0.0.1-green.svg)
[![Rdoc](http://www.rdocumentation.org/badges/version/rForest)](http://www.rdocumentation.org/packages/rForest)
![licence](https://img.shields.io/badge/Licence-GPL--3-blue.svg) 
![R_Forge](https://img.shields.io/badge/R_Forge-0.0.1-green.svg) 
![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/rForest)

rForest: An R Package for Forest Inventory and Analysis 

The rForest package provides functions to i) Fit a fifth-degree polynomial taper model, ii) plot tree stems in 2-D and 3-D, iii) plot taper models in 3-D.

## Installation
```r
#The development version:
library(devtools)
devtools::install_github("carlos-alberto-silva/rForest")

#The CRAN version:
install.packages("rForest")
```    

## Getting Started

### 2-D visualization of tree stems
```r
#Loading rForest and rgl libraries
library(rForest)
library(rgl)

# Importing forest inventory data
data(ForestInv01) 

# Subsetting Tree 1
tree1<-subset(ForestInv01,ForestInv01[,1]==1)
hi<-tree1$hi
di<-tree1$di

# Plotting stem 2d
plotStem2d(hi,di, col="#654321")
```
![](https://github.com/carlos-alberto-silva/rForest/blob/master/readme/Fig_1.png)


### 3-D visualization of tree stems
```r
plotStem3d(hi,di,alpha=1,col="#654321")
box3d()
```
![](https://github.com/carlos-alberto-silva/rForest/blob/master/readme/Fig_2.png)

### Fitting a fifth-degree polynomial taper model
```r
# setting model parametersdbh and ht
hi<-ForestInv01[,2]
di<-ForestInv01[,3]
ht<-ForestInv01[,4]
dbh<-ForestInv01[,5]

# fitting the fifth-degree polynomial taper model
fit <- poly5Model(dbh,ht,di,hi, plotxy=TRUE)
grid()
```
![](https://github.com/carlos-alberto-silva/rForest/blob/master/readme/Fig_3.png)

### 3-D visualization of taper models
```r
# Setting parameters for the 3-D visualization
dbh<-30 # cm
height<-25 # m

# Plotting the taper model in 3-D
VisTaperShape3d(model=fit,dbh=dbh,height=height,col="forestgreen",solid=TRUE)
box3d()
grid3d(c("x+","y+"))
aspect3d(0.3,0.3,1)

# Plotting the taper model in 3-D (solid=FALSE)
VisTaperShape3d(model=fit,dbh=dbh,height=height,col="forestgreen",solid=FALSE)
box3d()
grid3d(c("x+","y+"))
aspect3d(0.3,0.3,1)
```
![](https://github.com/carlos-alberto-silva/rForest/blob/master/readme/Fig_4.png)
