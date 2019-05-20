#'2D visualization of tree stems
#'
#'@description plotStem3d is used to visualize tree stems in 3D 
#'@usage plotStem2d(hi,di,col)
#'@param hi, vector of measured tree i heights
#'@param di, vector of measured tree diameters (di) at i heights
#'@param col, stem color, e.g. "chocolate"
#'@return Returns an object of class "lm"
#'@author Carlos A. Silva
#'@examples
#'# Importing forest inventory data
#'data(ForestInv01) 
#'
#'# Subsetting Tree 1
#'tree1<-subset(ForestInv01,ForestInv01[,1]==1)
#'hi<-tree1$hi
#'di<-tree1$di
#'
#'# Plotting stem 2d
#'plotStem2d(hi,di, col="forestgreen")
#'@importFrom sp SpatialPolygons
#'@importFrom grDevices chull
#'@importFrom graphics arrows curve grid plot text
#'@export
plotStem2d<-function(hi,di,col="forestgreen") {

  cone2d<-function(h0,h1,d0,d1){
    if((d1==0)) {
      x<-c(h0,h1,h0,h1,h0)
      y<-c(-d0/2,0,+d0/2,0,+d0/2) } else {
        x<-c(h0,h1,h0,h1,h0)
        y<-c(-d0/2,-d1/2,+d0/2,+d1/2,+d0/2)  
      }
    dat<-cbind(x,y)
    ch <- chull(x,y)
    coords <- dat[c(ch, ch[1]), ]
    sp_poly <- sp::SpatialPolygons(list(sp::Polygons(list(sp::Polygon(coords)),ID = 1))) 
    sp::plot(sp_poly, col=col,add=T)
  }
  
  plot(min(hi),0,pch=".",xlim=range(hi), ylim=c(-2.5-max(di)/2,+max(di)/2), axes=FALSE,col=col, xlab="Height (m)", ylab="Diameter (m)")
  
  for ( i in 1:length(hi)) {
    h0<-hi[i]
    h1<-hi[i+1]
    d0<-di[i]
    d1<-di[i+1]
      cone2d(h0,h1,d0,d1)
        if ( h1 == max(hi)) {(break(""))}
  }
  arrows(hi,-1-max(di)/2,hi,-2-max(di)/2, code=3,angle=90,length=0.05)
  arrows(0,-1.5-max(di)/2,max(hi),-1.5-max(di)/2, code=3,angle=90,length=0.05)
  for ( i in 1:length(hi)) {
    if ( i ==1) {text(hi[i],-2.5-max(di)/2, paste(hi[i]," m")) } else {
        text(hi[i],-2.5-max(di)/2, paste(hi[i]))}
  }
}


