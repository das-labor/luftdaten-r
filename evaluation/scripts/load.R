library(ggplot2)
library(anytime)
library(dplyr)
library(readr)
library(data.table)
library(osmdata)
library(tmap)
library(tmaptools)
library(sf)
library(rgdal)
library(ggplot2)
library(cartography)

#' For production environment e.g. with Knitr use:
source("func.R")

#' For local testing via file only
#' source("evaluation/scrips/func.R")

#' names of variables: english, lowletter case and "_"

#' Download city relation via overpass and extract polygons of them
do_query <- opq("Dortmund Nordrhein-Westfalen") %>% add_osm_feature(key="de:regionalschluessel", value="059130000000") %>% osmdata_sf()
do_polygon <- do_query$osm_multipolygons
e_query <- opq("Essen Nordrhein-Westfalen") %>% add_osm_feature(key="de:regionalschluessel", value="051130000000") %>% osmdata_sf()
e_polygon <- e_query$osm_multipolygons
#nrw_query <- opq_osm_id(id="62761", type="relation") %>% opq_string() %>% osmdata_sp()
#nrw_polygon <- nrw_query$osm_multipolygons
getwd()
#' Import luftdaten as csv, only sds011 sensor data (and only from 2018-10-08)
csv_filenames <- list.files(path = "../data/2018-10-08", pattern = "_sds011_sensor_", full.names = TRUE)
sensor_data <- rbindlist(lapply(csv_filenames, fread))

#' Generating unique list of sensors
sensor_data_unique <- sensor_data[!duplicated(sensor_data$sensor_id), ]

#' convert timestamp strings to datetime objects
sensor_data_unique$timestamp <- anytime(sensor_data_unique$timestamp)

#' convert lat/lon strings to coordinates/sf-object and adding projection
sensor_data_unique <- st_as_sf(sensor_data_unique, coords=c("lon","lat"))
sensor_data_unique <- st_set_crs(sensor_data_unique, 4326)

#' select sensors in specific geo areas (in a polygon that represents the area)
do_sensors <- st_intersection(sensor_data_unique, do_polygon)
e_sensors <- st_intersection(sensor_data_unique, e_polygon)

