#'3-D visualization of taper models
#'
#'@description VisTaperShape3d is used for visualizing taper models in 3-D
#'@usage VisTaperShape3d(model,dbh,height,col, solid) 
#'@param model, taper model as an object of class "lm"
#'@param dbh, tree diameter at breast height, e.g. 35 cm
#'@param height, tree height, e.g. 25 m
#'@param col, taper color, e.g. "forestgreen"
#'@param solid, if TRUE (default) returns a solid 3d model. If FALSE, returns a 3d grid model
#'@return Nothing, but outputs a plot
#'@author Carlos Alberto Silva and Joao Paulo Sardo Madi
#'@examples
#'# Importing forest inventory data
#'data(ForestInv01) 
#'
#'# setting model parametersdbh and ht
#'hi<-ForestInv01[,2]
#'di<-ForestInv01[,3]
#'ht<-ForestInv01[,4]
#'dbh<-ForestInv01[,5]
#'
#' # fitting the fifth-degree polynomial taper model
#'fit <- poly5Model(dbh,ht,di,hi, plotxy=TRUE)
#'
# Setting parameters for the 3-D visualization
#'dbh<-30 # cm
#'height<-25 # m
#'model<-fit
#'
#'library(rgl)
#'# Plotting the taper model in 3-D
#'VisTaperShape3d(fit,dbh,height,col="forestgreen",solid=TRUE)
#'box3d()
#'grid3d(c("x+","y+"))
#'aspect3d(0.3,0.3,1)
#'
#'@importFrom rgl open3d triangles3d
#'@importFrom stats coef
#'@importFrom alphashape3d ashape3d
#'@export
VisTaperShape3d<-function(model,dbh,height,col="forestgreen", solid=TRUE){
  
  SetModel<-function(dbh,h,ht,model) {
    h_ht<-h/ht
    dbh*(coef(model)[1]+coef(model)[2]*(h_ht)+coef(model)[3]*(h_ht)^2+coef(model)[4]*(h_ht)^3+coef(model)[5]*(h_ht)^4+coef(model)[6]*(h_ht)^5) 
  }
  
  z <- rep(seq(0,height,length=50),each=50)
  angs <- rep(seq(0,2*pi, length=50),50)
  
  distfun<-SetModel(dbh,h=z,height,model)
  
  x <- 0 + distfun*cos(angs)
  y <- 0 + distfun*sin(angs)
  
  keep <- !duplicated(cbind(x,y,z))
  x <- x[keep]
  y <- y[keep]
  z <- z[keep]
  xyz<-matrix(rbind(cbind(x,y,z),c(0,0,height)),ncol=3)
  
  if (solid==TRUE) {   
    rgl::open3d()
    tape3d <- alphashape3d::ashape3d(xyz,alpha=4,pert=TRUE)
    plot(tape3d, transparency = 1,col=rep(col,3))
    rgl::aspect3d(0.3,0.3,1)
    
  } else {
    
    mMatrix<-matrix(ncol=3)[-1,]
    
    for ( i in 1:nrow(xyz)){
      ln=i+50
      
      if ( ln >= nrow(xyz)) { ln2=nrow(xyz) } else { ln2= ln}
      
      mMatrix<-rbind(mMatrix,rbind(xyz[i,],xyz[ln2,])) 
    }
    
    kljzbase=subset(xyz,xyz[,3]==z[2])
    kljzbaseNew<-matrix(ncol=3)[-1,]
    
    for ( i in 1:nrow(kljzbase)){
      kljzbaseNew<-rbind(kljzbaseNew,rbind(kljzbase[i,],c(0,0,0)))
      
    }
    
    rgl::open3d()
    newList<-rbind(kljzbaseNew,c(0,0,0),mMatrix,c(0,0,0),xyz)
    rgl::plot3d(newList, type="l", col=col, add=T)
    rgl::aspect3d(0.3,0.3,1)
    
  }
  
}
