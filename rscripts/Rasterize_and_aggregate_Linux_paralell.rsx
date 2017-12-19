##Vector processing=group
##Rasterize and aggregate [Linux paralell]=name
##Layer=vector
##Rasterize_field=field Layer
##Aggregate_fun=selection sum;mean;sd;min;max;median;count
##Pixel_size_x=number 1.0
##Pixel_size_y=number 1.0
##Extent=extent
##Multicore_processing=boolean False
##Result=output raster
library(doMC)
library(foreach)
count <- function(x, na.rm=T) if(na.rm) length(x[!is.na(x)]) else length(x)
r <- raster(x = extent(Extent),
resolution = c(Pixel_size_x, Pixel_size_y),
crs=proj4string(Layer))
r[] <- NA
f=function(i, Layer = Layer, Field = Rasterize_field, base = r){
rasterize(Layer[i,], base, field = Field)}

funs <- c("sum","mean","sd","min","max","median","count")
if(Multicore_processing) registerDoMC(detectCores()-1)
rs <- foreach(i = seq_along(Layer), .packages = c("raster", "rgdal")) %dopar%
f(i = i, Layer=Layer, Field = Rasterize_field, base = r)
s<-stack(rs)
Result<-calc(s,match.fun(funs[Aggregate_fun+1]), na.rm = T)
