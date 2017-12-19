##Raster processing = group
##Rescale = name
##Raster = raster
##New_min = number 0
##New_max = number 1
##Rescaled = output raster
r.min <- cellStats(Raster, "min")
r.max <- cellStats(Raster, "max")
Rescaled <- New_min + (Raster - r.min) * ((New_max - New_min) / (r.max - r.min))
