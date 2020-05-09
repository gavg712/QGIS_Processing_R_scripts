##Raster processing = group
##First cover second except zero = name
##Raster_A = raster
##Raster_B = raster
##NA_Value = number 0
##Covered = output raster
Raster_A[Raster_A==NA_value] <- NA
Covered <- cover(Raster_A, Raster_B)
