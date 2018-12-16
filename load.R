library(ggplot2)
library(anytime)
library(dplyr)
library(readr)
library(data.table)

#' names of variables: english, lowletter case and "_"

csv_filenames <- list.files(path = "data", pattern = "_sds011_sensor_", full.names = TRUE)
sensor_data <- rbindlist(lapply(csv_filenames, fread))

sensor_data$timestamp <- anytime(sensor_data$timestamp)