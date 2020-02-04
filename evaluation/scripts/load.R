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

#' Setting the stage
#'
#' Annotation: This sourcing is not needed here at the moment and therefore 
#' commented 
#  source("evaluation/scripts/func.R")
#'
#' Set working directory strictly to "Project directory". All following paths 
#' are relative to this directory
setwd("~/devel/luftdaten-r")
#'
#' Please consider: names of variables are in english, lowercase and "_" 

#' Download city relation via overpass and extract polygons of them

do_query <- opq("Dortmund Nordrhein-Westfalen") %>% add_osm_feature(key="de:regionalschluessel", value="059130000000") %>% osmdata_sf()
do_polygon <- do_query$osm_multipolygons
e_query <- opq("Essen Nordrhein-Westfalen") %>% add_osm_feature(key="de:regionalschluessel", value="051130000000") %>% osmdata_sf()
e_polygon <- e_query$osm_multipolygons

#' Download country relation and extract polygons of them
#nrw_query <- opq_osm_id(id="62761", type="relation") %>% opq_string() %>% osmdata_sp()
#nrw_polygon <- nrw_query$osm_multipolygons

#' Import luftdaten as csv files into a table of csv filepaths. 
#' Use only sds011 sensor data by using pattern matching on the file names. 
#' Export the absolute path
#csv_filenames <- list.files(path = "data/", pattern = "_sds011", full.names = TRUE)
csv_filenames <- list.files(path = "data/", pattern = "cutted", full.names = TRUE)


# Subset of debugging and or different styles of loading large csv-files. 
sensor_data <- rbindlist(lapply(csv_filenames, fread))
#sensor_data <- read.csv("data/2019-12_sds011.csv")[c(1:100) ,c('sensor_id', 'lat', 'lon', 'timestamp')]
#sensor_data <- read.table("data/2019-12_sds011.csv", colClasses = c())
#sensor_data <- read.csv("data/cutted-10M.csv", sep=";")


#' Generate unique list of sensors
sensor_data_unique <- sensor_data[!duplicated(sensor_data$sensor_id), ]

#' Convert timestamp strings to datetime objects
sensor_data_unique$timestamp <- anytime(sensor_data_unique$timestamp)

#' Convert lat/lon strings to coordinates/sf-object and adding projection
sensor_data_unique <- st_as_sf(sensor_data_unique, coords=c("lon","lat"))
sensor_data_unique <- st_set_crs(sensor_data_unique, 4326)

#' Select sensors in specific geo areas (in a polygon that represents the area)
do_sensors <- st_intersection(sensor_data_unique, do_polygon)
e_sensors <- st_intersection(sensor_data_unique, e_polygon)

