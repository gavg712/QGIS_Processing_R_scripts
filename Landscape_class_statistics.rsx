##Raster processing = group
##Landscape class statistics = name
##Raster = raster
##Set_background = boolean false
##Background_value = number
##Landscape_class_stats = output table
library(SDMTools)
cs <- res(Raster)
Background <- NA
if(Set_background) Background <- Background_value
rst <- Raster[[1]]
Landscape_class_stats <- ClassStat(rst, cellsize = min(cs), bkgd =Background)
