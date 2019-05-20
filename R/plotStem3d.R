#'3D visualization of tree stems
#'
#'@description plotStem3d is used to visualize tree stems in 3D 
#'@usage plotStem3d(hi,di,col,alpha) 
#'@param hi, vector of trees his
#'@param di, vector of trees dis
#'@param col, stem color, e.g. "chocolate"
#'@param alpha, stem transparency. Set a value from 0 to 1
#'@author Carlos Alberto Silva
#'@examples
#'# Importing forest inventory data
#'data(ForestInv01) 
#'
#'# Subsetting Tree 1
#'tree1<-subset(ForestInv01,ForestInv01[,1]==1)
#'hi<-tree1$hi
#'di<-tree1$di
#'
#'# Plotting stem 3d
#'plotStem3d(hi,di,alpha=1,col="forestgreen")
#'@importFrom rgl triangles3d
#'@importFrom geometry convhulln
#'@export
plotStem3d<-function(hi,di,col="chocolate4", alpha=0.75) {

  cilinder<-function(X0,Y0,r,z) {
    disfun<-sqrt(1)
    angs<-seq(0,2*pi,length=60)
    x<-X0 + r*disfun*cos(angs)
    y<-Y0 + r*disfun*sin(angs)
    return(cbind(x,y,rep(z,60)))
  }
  
  hidi<-cbind(hi,di)
  maxr<-max(hidi)/2
  x=0 ;  y=0
  rgl::open3d()

  rgl::bg3d(col="white")
  rgl::view3d( theta = -90, phi = -90)
  for ( i in 2:(nrow(hidi))) {
      sec_i<-hidi[(i-1):i,]
        c0<-cilinder(x,y,(sec_i[1,2]/2),sec_i[1,1])
          c1<-cilinder(x,y,(sec_i[2,2]/2),sec_i[2,1])
        xyz<-cbind(rbind(c0,c1))
        rgl::plot3d(xyz,type="l",lwd=2,xlab="",add=T,col="black",ylab="",axes=FALSE, xlim=c(x-maxr-2,x+maxr+2),ylim=c(y-maxr-2,y+maxr+2))
      ch <- t(geometry::convhulln(xyz, "QJ"))
      rgl::rgl.triangles(xyz[ch,1],xyz[ch,2],xyz[ch,3], col=col,alpha=alpha)
  }
  
  rgl::aspect3d(0.3,0.3,1)
}


