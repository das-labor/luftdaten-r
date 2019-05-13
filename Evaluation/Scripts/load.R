library(ggplot2)
library(anytime)
library(dplyr)
library(readr)
library(data.table)
library(osmdata)
library(tmap)
library(tmaptools)
library(sf)
library(sp)
library(rgdal)

source('func.R')

#' names of variables: english, lowletter case and "_"

#' Download city relation via overpass and extract polygons of them
do_query <- opq("Dortmund Nordrhein-Westfalen") %>% add_osm_feature(key="de:regionalschluessel", value="059130000000") %>% osmdata_sp()
do_polygon <- do_query$osm_multipolygons
e_query <- opq("Essen Nordrhein-Westfalen") %>% add_osm_feature(key="de:regionalschluessel", value="051130000000") %>% osmdata_sp()
e_polygon <- e_query$osm_multipolygons
#nrw_query <- opq_osm_id(id="62761", type="relation") %>% opq_string() %>% osmdata_sp()
#nrw_polygon <- nrw_query$osm_multipolygons

#' Import luftdaten as csv, only sds011 sensor data (and only from 2018-10-08)
csv_filenames <- list.files(path = "data/2018-10-08", pattern = "_sds011_sensor_", full.names = TRUE)
sensor_data <- rbindlist(lapply(csv_filenames, fread))

#' convert timestamp strings to datetime objects
sensor_data$timestamp <- anytime(sensor_data$timestamp)

#' convert lat/lon strings to coordinates
coordinates(sensor_data) <- ~ lon + lat

#' select sensors in specific geo areas (in a polygon that represents the area)
do_sensors <- sensors.in.poly(sensor_data, do_polygon)
e_sensors <- sensors.in.poly(sensor_data, e_polygon)
#nrw_sensors <- sensors.in.poly(sensor_data, nrw_polygon)
