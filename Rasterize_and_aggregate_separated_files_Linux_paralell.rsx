##Vector processing = group
##Rasterize and aggregate separated files [Linux paralell] = name
##Layers = multiple vector
##Rasterize_field = field Layers
##Aggregate_fun = selection sum;mean;sd;min;max;median;count
##Pixel_size_x = number 1.0
##Pixel_size_y = number 1.0
##Extent = extent
##Multicore_processing = boolean False
##Result = output raster
library(doMC)
library(foreach)
if(Multicore_processing) registerDoMC(detectCores()-1)
count <- function(x, na.rm = T) if(na.rm) length(x[!is.na(x)]) else length(x)
numerize <- function(x, field="year") {
  x@data[,field] <- as.numeric(as.character(x@data[,field]))
  return(x)
}
r <- raster(x = extent(Extent),
            resolution = c(Pixel_size_x, Pixel_size_y),
            crs = proj4string(Layers[[1]]))
r[] <- NA
funs <- c("sum", "mean", "sd", "min", "max", "median", "count")
Layers <- lapply(Layers, numerize, field = Rasterize_field)
rs <- foreach(Layer = Layers, .packages = c("raster", "rgdal")) %dopar%
  raster::rasterize(x = Layer, y = r, field = Rasterize_field)
s <- stack(rs)
Result <- calc(s, match.fun(funs[Aggregate_fun+1]), na.rm = T)
