##Raster processing=group
##Extract raster values by point=name
##Raster=raster
##Points=vector point
##Output_column_name=string New
##Extracted=output vector
Extracted <- extract(Raster, Points, sp = TRUE)
nam <- names(Extracted)
names(Extracted) <- c(nam[-length(nam)], Output_column_name)
