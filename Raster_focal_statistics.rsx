##Raster processing = group
##Focal statistics = name
##Raster = raster
##Type_of_matrix = selection flat;circle;rectangle;Gauss
##Matrix_distance = number 1
##Function = selection mean;max;min;sd;median;majority
##Remove_edge_efects = boolean False
##Fill_NoData_only = boolean False
##Filtered = output raster
MtxType <- c("flat","circle","rectangle","Gauss")
Funs <- c("mean","max","min","sd","median","majority")
Raster <- Raster[[1]]
W <- switch(MtxType[Type_of_matrix+1],
            "flat" = {
              matrix(1,Matrix_distance*2+1,Matrix_distance*2+1)
              },
            "circle" = {
              focalWeight(Raster, Matrix_distance*res(Raster), "circle")
              },
            "rectangle" = {
              focalWeight(Raster, Matrix_distanceres(Raster), "rectangle")
              },
            "Gauss" = {
              focalWeight(Raster, Matrix_distance*res(Raster), "Gauss")
              })
Filtered <- focal(x = Raster,
               w = W,
               fun  =  match.fun(Funs[Function+1]),
               pad = Remove_edge_efects,
               padValue = Matrix_distance,
               NAonly = Fill_NoData_only)
