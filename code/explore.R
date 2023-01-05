# Author: Anton Urfels (CIMMYT/CGIAR)
# Set up to provide Maxwell with yield distributions across space and time.
# Subset for each scenario and for Bihar and then send cell in row and var_year in columns

# load some libraries
library(rasterVis)
library(raster)
library(rgdal)
library(colorspace)
library(RColorBrewer)
library(ggplot2)
library(ggpubr)
library(reshape2)
library(tidyverse)
library(ggtext)
library(plyr)

# define key files
#load files to be used later
file1 <- "data/simulations/s001.nc4"
file2 <- "data/simulations/s002.nc4"
file3 <- "data/simulations/s003.nc4"
file4 <- "data/simulations/s004.nc4"
file5 <- "data/simulations/s005.nc4"
file6 <- "data/simulations/s006.nc4"
file7 <- "data/simulations/s007.nc4"
file_aoi <- "data/aoi_mask/aoi_mask.tif"
india_states <- "data/gadm40_IND_shp/gadm40_IND_1.shp"

# loading key data
aoi <- raster(file_aoi)
bihar <- readOGR(india_states)
aoi <- bihar[bihar$NAME_1=="Bihar",]
plot(aoi)

# functions for loading data 
load_sims <- function(files,var,aoi,operator,var2) {
  # check if operators is used, is NA, just load one var
  if (is.na(operator)==TRUE) {  
    l <- list()
    #cycle through file names to load all different scenarios
    for (i in files) {      
      j <- which(i==files)
      #load file and add to list
      l[[j]] <- raster::stack(i,varname= var)[[3:35]]
    }} else {   # if operator is used, load to vars with operators
      l <- list()
      for (i in files) {
        j <- which(i==files)
        # important: need to pass operator with backticks, not as string
        if (var=="rice_yield") {
          a <-  raster::stack(i,varname= var)[[3:35]] * 3600}
        else {a <-  raster::stack(i,varname= var)[[3:35]] }
        if (var=="wheat_yield") {
          b <-  raster::stack(i,varname= var2)[[3:35]] * 3340}
        else {b <-  raster::stack(i,varname= var2)[[3:35]] }
        
        l[[j]] <- operator(a,b)
      }
    }
  l <- lapply(l,function(x){raster::mask(x,aoi)})
  l <- lapply(l,function(x){raster::crop(x,aoi)})
  return(l)
}



# start extraction for rice

create_csv <- function(crop,var) {
files <- c(file1,file2,file3,file4,file5,file6,file7)
raster_df <- load_sims(files,var,aoi,NA)
list_df <- lapply(raster_df, getValues)
list_df <- lapply(list_df, na.omit)
lapply(list_df, nrow)
list_df <- lapply(list_df, "colnames<-", paste0(var,"_",1983:2015))

#Scenarios
# Fixed/onset is the rice planting strategy
# Medium/long is the variety
# suppl is where we ran supplementary irrigation instead of full irrigation. Use with caution.

scen <- c("baseline","fixed_long","onset_long","fixed_medium","onset_medium","onset_long_suppl","onset_medium_suppl")

for (i in 1:length(scen)) {
  write.csv(list_df[[i]],paste0("output/",crop,"_",scen[i],".csv"))
}
}

create_csv("rice","rice_yield")
create_csv("wheat","wheat_yield")



#####################################

# Map Maxwell's outputs

files <- c(file1)
r <- load_sims(files,"rice_yield",aoi,NA)
r1 <- r[[1]][[1]]

m <- read.csv("data/maxwell_output_fixedLong/RA_Rice_fixedlong_onset_medium_suppl_c.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

#
w1 <-   scale(m$Riskiness_Comp,center = T)
w2 <-   scale(m$Diff_Mean_CompBase,center = T)

m$Diff_Mean_CompBase[m$Diff_Mean_CompBase < 100 & m$Diff_Mean_CompBase > -100] <- 0
m$Diff_Mean_CompBase[m$Diff_Mean_CompBase > 0] <- 1
m$Diff_Mean_CompBase[m$Diff_Mean_CompBase < 0] <- -1

#scale(m$MinProp_CompSOSDBase_Divdbaseyield) + scale(m$Diff_Mean_CompBase)


values(r1)[t]<-w1+w2
library(rasterVis)
levelplot(r1,par.settings=RdBuTheme(),margin=F )

values(r1)[t]<-w1
library(rasterVis)
levelplot(r1,par.settings=RdBuTheme(),margin=F )

values(r1)[t]<- m$Diff_Mean_CompBase
library(rasterVis)
levelplot(r1,par.settings=RdBuTheme(),margin=F )

values(r1)[t]<- m$Diff_Mean_CompBase - m$Riskiness_Comp
library(rasterVis)
levelplot(r1,par.settings=RdBuTheme(),margin=F)


# Check for -99 values
files <- c(file1)
r <- load_sims(files,"rice_yield",aoi,NA)
getValues()


