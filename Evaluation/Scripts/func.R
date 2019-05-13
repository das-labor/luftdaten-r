#' Functions, that will be used throughout this project
#' 
#' @param <name of param> <desc of param>

#' @sensors.in.poly <list of sensor data with coordinates> <polygon sp object>
sensors.in.poly <- function(sensor_list_input, polygon_input) {
  # projections should be the same
  proj4string(sensor_list_input) <- proj4string(polygon_input)
  # is 'sensor_list_input' in 'polygon_input'? TRUE/FALSE
  sensor_true_false_list <- !is.na(over(sensor_list_input, as(polygon_input, "SpatialPolygons")))
  # return list of sensors that are in the polygon
  return(sensor_list_input[ which(sensor_true_false_list==TRUE),])
}