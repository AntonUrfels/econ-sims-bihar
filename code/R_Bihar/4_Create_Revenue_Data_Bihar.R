
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

# define key files ------------------------
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

# loading key data ----------------------------------
aoi <- raster(file_aoi)
bihar <- readOGR(india_states)
aoi <- bihar[bihar$NAME_1=="Bihar",]
plot(aoi)

# functions for loading data  ----------------------
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



# start extraction for rice --------------------------------------------

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


files <- c(file1)
r <- load_sims(files,"rice_yield",aoi,NA)
r1 <- r[[1]][[1]]



# Spatial system revenue benefits -----------------------
library(terra)

# Import raster files of rice and wheat prices [created using spatial Bayesian Krigging]
rice_prices=raster("data/maxwell_interpolated_prices/Rice_SVCpriceModel.r.pred.mu.image.tif")
wheat_prices=raster("data/maxwell_interpolated_prices/Wheat_SVCpriceModel.r.pred.mu.image.tif")

rice_prices=mask(rice_prices,aoi)
wheat_prices=mask(wheat_prices,aoi)


library(exactextractr)

rice_prices_r = resample(rice_prices, y = r1, method = "bilinear")
wheat_prices_r = resample(wheat_prices, y = r1, method = "bilinear")
plot(wheat_prices_r)

levelplot(rice_prices_r,par.settings=RdBuTheme(),margin=F, main="Rice prices (R/kg")
levelplot(wheat_prices_r,par.settings=RdBuTheme(),margin=F, main="Wheat prices (R/kg)")
rice_wheat_price_ratio=rice_prices_r$Rice_SVCpriceModel.r.pred.mu.image/wheat_prices_r$Wheat_SVCpriceModel.r.pred.mu.image
levelplot(rice_wheat_price_ratio,par.settings=RdBuTheme(),margin=F, main="Rice-wheat price ratio (R/kg)")

library(ncdf4)
library(stars)
library(ncmeta)

# Transform the ncdf4 file into a terra rast object

## Farmer practice --------------
farmer_practice_rast=rast(file1)
plot(farmer_practice_rast)
bihar_shape= bihar[bihar$NAME_1=="Bihar",]
plot(bihar_shape)
bihar_shape_terra=vect(bihar_shape)
farmer_practice_rast_m=mask(farmer_practice_rast,bihar_shape_terra)
plot(farmer_practice_rast_m$`rice_yield_scen=1_38`)
rice_farmer_practice_rast_m <- farmer_practice_rast_m[[1295:1327]]
rice_farmer_practice_rast_m_stack=raster::stack(rice_farmer_practice_rast_m)
rice_farmer_practice_rast_m_stack_revenue=rice_farmer_practice_rast_m_stack*rice_prices_r

plot(rice_farmer_practice_rast_m_stack_revenue)
rice_farmer_practice_rev<- rasterToPoints(rice_farmer_practice_rast_m_stack_revenue)

write.csv(rice_farmer_practice_rev,"data/maxwell_interpolated_prices/rice_farmer_practice_rev.csv")

### wheat -----
wheat_farmer_practice_rast_m <- farmer_practice_rast_m[[1903:1935]]
wheat_farmer_practice_rast_m_stack=raster::stack(wheat_farmer_practice_rast_m)
wheat_farmer_practice_rast_m_stack_revenue=wheat_farmer_practice_rast_m_stack*wheat_prices_r
plot(wheat_farmer_practice_rast_m_stack_revenue)
wheat_farmer_practice_rev<- rasterToPoints(wheat_farmer_practice_rast_m_stack_revenue)

#write.csv(wheat_farmer_practice_rev,"data/maxwell_interpolated_pwheats/wheat_farmer_practice_rev.csv")

rice_wheat_farmer_practice_rast_m_stack_revenue=rice_farmer_practice_rast_m_stack_revenue+wheat_farmer_practice_rast_m_stack_revenue
plot(rice_wheat_farmer_practice_rast_m_stack_revenue)
rice_wheat_farmer_practice_rev=rasterToPoints(rice_wheat_farmer_practice_rast_m_stack_revenue)
write.csv(rice_wheat_farmer_practice_rev,"data/maxwell_interpolated_prices/rice_wheat_farmer_practice_rev.csv")

## Fixed long --------
fixed_long_rast=rast(file2)
plot(fixed_long_rast)
fixed_long_rast_m=mask(fixed_long_rast,bihar_shape_terra)
plot(fixed_long_rast_m$`rice_yield_scen=1_38`)
rice_fixed_long_rast_m <- fixed_long_rast_m[[1295:1327]]
rice_fixed_long_rast_m_stack=raster::stack(rice_fixed_long_rast_m)
rice_fixed_long_rast_m_stack_revenue=rice_fixed_long_rast_m_stack*rice_prices_r

plot(rice_fixed_long_rast_m_stack_revenue)
rice_fixed_long_rev<- rasterToPoints(rice_fixed_long_rast_m_stack_revenue)

write.csv(rice_fixed_long_rev,"data/maxwell_interpolated_prices/rice_fixed_long_rev.csv")




### wheat -----
wheat_fixed_long_rast_m <- fixed_long_rast_m[[1903:1935]]
wheat_fixed_long_rast_m_stack=raster::stack(wheat_fixed_long_rast_m)
wheat_fixed_long_rast_m_stack_revenue=wheat_fixed_long_rast_m_stack*wheat_prices_r
plot(wheat_fixed_long_rast_m_stack_revenue)
wheat_fixed_long_rev<- rasterToPoints(wheat_fixed_long_rast_m_stack_revenue)

#write.csv(wheat_fixed_long_rev,"data/maxwell_interpolated_pwheats/wheat_fixed_long_rev.csv")

##########
rice_wheat_fixed_long_rast_m_stack_revenue=rice_fixed_long_rast_m_stack_revenue+wheat_fixed_long_rast_m_stack_revenue
plot(rice_wheat_fixed_long_rast_m_stack_revenue)
rice_wheat_fixed_long_rev=rasterToPoints(rice_wheat_fixed_long_rast_m_stack_revenue)
write.csv(rice_wheat_fixed_long_rev,"data/maxwell_interpolated_prices/rice_wheat_fixed_long_rev.csv")



#scen <- c("baseline","fixed_long","onset_long","fixed_medium","onset_medium","onset_long_suppl","onset_medium_suppl")
# Onset_long

onset_long_rast=rast(file3)
plot(onset_long_rast)
onset_long_rast_m=mask(onset_long_rast,bihar_shape_terra)
plot(onset_long_rast_m$`rice_yield_scen=1_38`)
rice_onset_long_rast_m <- onset_long_rast_m[[1295:1327]]
rice_onset_long_rast_m_stack=raster::stack(rice_onset_long_rast_m)
rice_onset_long_rast_m_stack_revenue=rice_onset_long_rast_m_stack*rice_prices_r

plot(rice_onset_long_rast_m_stack_revenue)
rice_onset_long_rev<- rasterToPoints(rice_onset_long_rast_m_stack_revenue)

write.csv(rice_onset_long_rev,"data/maxwell_interpolated_prices/rice_onset_long_rev.csv")



### wheat
wheat_onset_long_rast_m <- onset_long_rast_m[[1903:1935]]
wheat_onset_long_rast_m_stack=raster::stack(wheat_onset_long_rast_m)
wheat_onset_long_rast_m_stack_revenue=wheat_onset_long_rast_m_stack*wheat_prices_r
plot(wheat_onset_long_rast_m_stack_revenue)
wheat_onset_long_rev<- rasterToPoints(wheat_onset_long_rast_m_stack_revenue)

#write.csv(wheat_onset_long_rev,"data/maxwell_interpolated_pwheats/wheat_onset_long_rev.csv")

##########
rice_wheat_onset_long_rast_m_stack_revenue=rice_onset_long_rast_m_stack_revenue+wheat_onset_long_rast_m_stack_revenue
plot(rice_wheat_onset_long_rast_m_stack_revenue)
rice_wheat_onset_long_rev=rasterToPoints(rice_wheat_onset_long_rast_m_stack_revenue)
write.csv(rice_wheat_onset_long_rev,"data/maxwell_interpolated_prices/rice_wheat_onset_long_rev.csv")


# fixed medium 
fixed_medium_rast=rast(file4)
plot(fixed_medium_rast)
fixed_medium_rast_m=mask(fixed_medium_rast,bihar_shape_terra)
plot(fixed_medium_rast_m$`rice_yield_scen=1_38`)
rice_fixed_medium_rast_m <- fixed_medium_rast_m[[1295:1327]]
rice_fixed_medium_rast_m_stack=raster::stack(rice_fixed_medium_rast_m)
rice_fixed_medium_rast_m_stack_revenue=rice_fixed_medium_rast_m_stack*rice_prices_r

plot(rice_fixed_medium_rast_m_stack_revenue)
rice_fixed_medium_rev<- rasterToPoints(rice_fixed_medium_rast_m_stack_revenue)

write.csv(rice_fixed_medium_rev,"data/maxwell_interpolated_prices/rice_fixed_medium_rev.csv")

### wheat
wheat_fixed_medium_rast_m <- fixed_medium_rast_m[[1903:1935]]### wheat
wheat_fixed_medium_rast_m <- fixed_medium_rast_m[[1903:1935]]
wheat_fixed_medium_rast_m_stack=raster::stack(wheat_fixed_medium_rast_m)
wheat_fixed_medium_rast_m_stack_revenue=wheat_fixed_medium_rast_m_stack*wheat_prices_r
plot(wheat_fixed_medium_rast_m_stack_revenue)
wheat_fixed_medium_rev<- rasterToPoints(wheat_fixed_medium_rast_m_stack_revenue)

#write.csv(wheat_fixed_medium_rev,"data/maxwell_interpolated_pwheats/wheat_fixed_medium_rev.csv")

##########
rice_wheat_fixed_medium_rast_m_stack_revenue=rice_fixed_medium_rast_m_stack_revenue+wheat_fixed_medium_rast_m_stack_revenue
plot(rice_wheat_fixed_medium_rast_m_stack_revenue)
rice_wheat_fixed_medium_rev=rasterToPoints(rice_wheat_fixed_medium_rast_m_stack_revenue)
write.csv(rice_wheat_fixed_medium_rev,"data/maxwell_interpolated_prices/rice_wheat_fixed_medium_rev.csv")


#onset medium
onset_medium_rast=rast(file5)
plot(onset_medium_rast)
onset_medium_rast_m=mask(onset_medium_rast,bihar_shape_terra)
plot(onset_medium_rast_m$`rice_yield_scen=1_38`)
rice_onset_medium_rast_m <- onset_medium_rast_m[[1295:1327]]
rice_onset_medium_rast_m_stack=raster::stack(rice_onset_medium_rast_m)
rice_onset_medium_rast_m_stack_revenue=rice_onset_medium_rast_m_stack*rice_prices_r

plot(rice_onset_medium_rast_m_stack_revenue)
rice_onset_medium_rev<- rasterToPoints(rice_onset_medium_rast_m_stack_revenue)

write.csv(rice_onset_medium_rev,"data/maxwell_interpolated_prices/rice_onset_medium_rev.csv")

### wheat
wheat_onset_medium_rast_m <- onset_medium_rast_m[[1903:1935]]
wheat_onset_medium_rast_m_stack=raster::stack(wheat_onset_medium_rast_m)
wheat_onset_medium_rast_m_stack_revenue=wheat_onset_medium_rast_m_stack*wheat_prices_r
plot(wheat_onset_medium_rast_m_stack_revenue)
wheat_onset_medium_rev<- rasterToPoints(wheat_onset_medium_rast_m_stack_revenue)

#write.csv(wheat_onset_medium_rev,"data/maxwell_interpolated_pwheats/wheat_onset_medium_rev.csv")

##########
rice_wheat_onset_medium_rast_m_stack_revenue=rice_onset_medium_rast_m_stack_revenue+wheat_onset_medium_rast_m_stack_revenue
plot(rice_wheat_onset_medium_rast_m_stack_revenue)
rice_wheat_onset_medium_rev=rasterToPoints(rice_wheat_onset_medium_rast_m_stack_revenue)
write.csv(rice_wheat_onset_medium_rev,"data/maxwell_interpolated_prices/rice_wheat_onset_medium_rev.csv")



# onset_long_suppl
onset_long_suppl_rast=rast(file6)
plot(onset_long_suppl_rast)
onset_long_suppl_rast_m=mask(onset_long_suppl_rast,bihar_shape_terra)
plot(onset_long_suppl_rast_m$`rice_yield_scen=1_38`)
rice_onset_long_suppl_rast_m <- onset_long_suppl_rast_m[[1295:1327]]
rice_onset_long_suppl_rast_m_stack=raster::stack(rice_onset_long_suppl_rast_m)
rice_onset_long_suppl_rast_m_stack_revenue=rice_onset_long_suppl_rast_m_stack*rice_prices_r

plot(rice_onset_long_suppl_rast_m_stack_revenue)
rice_onset_long_suppl_rev<- rasterToPoints(rice_onset_long_suppl_rast_m_stack_revenue)

write.csv(rice_onset_long_suppl_rev,"data/maxwell_interpolated_prices/rice_onset_long_suppl_rev.csv")


### wheat
wheat_onset_long_suppl_rast_m <- onset_long_suppl_rast_m[[1903:1935]]
wheat_onset_long_suppl_rast_m_stack=raster::stack(wheat_onset_long_suppl_rast_m)
wheat_onset_long_suppl_rast_m_stack_revenue=wheat_onset_long_suppl_rast_m_stack*wheat_prices_r
plot(wheat_onset_long_suppl_rast_m_stack_revenue)
wheat_onset_long_suppl_rev<- rasterToPoints(wheat_onset_long_suppl_rast_m_stack_revenue)

#write.csv(wheat_onset_long_suppl_rev,"data/maxwell_interpolated_pwheats/wheat_onset_long_suppl_rev.csv")

##########
rice_wheat_onset_long_suppl_rast_m_stack_revenue=rice_onset_long_suppl_rast_m_stack_revenue+wheat_onset_long_suppl_rast_m_stack_revenue
plot(rice_wheat_onset_long_suppl_rast_m_stack_revenue)
rice_wheat_onset_long_suppl_rev=rasterToPoints(rice_wheat_onset_long_suppl_rast_m_stack_revenue)
write.csv(rice_wheat_onset_long_suppl_rev,"data/maxwell_interpolated_prices/rice_wheat_onset_long_suppl_rev.csv")




# onset medium suppl
onset_medium_suppl_rast=rast(file7)
plot(onset_medium_suppl_rast)
onset_medium_suppl_rast_m=mask(onset_medium_suppl_rast,bihar_shape_terra)
plot(onset_medium_suppl_rast_m$`rice_yield_scen=1_38`)

rice_onset_medium_suppl_rast_m <- onset_medium_suppl_rast_m[[1295:1327]]
rice_onset_medium_suppl_rast_m_stack=raster::stack(rice_onset_medium_suppl_rast_m)
rice_onset_medium_suppl_rast_m_stack_revenue=rice_onset_medium_suppl_rast_m_stack*rice_prices_r

plot(rice_onset_medium_suppl_rast_m_stack_revenue)
rice_onset_medium_suppl_rev<- rasterToPoints(rice_onset_medium_suppl_rast_m_stack_revenue)

write.csv(rice_onset_medium_suppl_rev,"data/maxwell_interpolated_prices/rice_onset_medium_suppl_rev.csv")


### wheat
wheat_onset_medium_suppl_rast_m <- onset_medium_suppl_rast_m[[1903:1935]]
wheat_onset_medium_suppl_rast_m_stack=raster::stack(wheat_onset_medium_suppl_rast_m)
wheat_onset_medium_suppl_rast_m_stack_revenue=wheat_onset_medium_suppl_rast_m_stack*wheat_prices_r
plot(wheat_onset_medium_suppl_rast_m_stack_revenue)
wheat_onset_medium_suppl_rev<- rasterToPoints(wheat_onset_medium_suppl_rast_m_stack_revenue)

#write.csv(wheat_onset_medium_suppl_rev,"data/maxwell_interpolated_pwheats/wheat_onset_medium_suppl_rev.csv")

##########
rice_wheat_onset_medium_suppl_rast_m_stack_revenue=rice_onset_medium_suppl_rast_m_stack_revenue+wheat_onset_medium_suppl_rast_m_stack_revenue
plot(rice_wheat_onset_medium_suppl_rast_m_stack_revenue)
rice_wheat_onset_medium_suppl_rev=rasterToPoints(rice_wheat_onset_medium_suppl_rast_m_stack_revenue)
write.csv(rice_wheat_onset_medium_suppl_rev,"data/maxwell_interpolated_prices/rice_wheat_onset_medium_suppl_rev.csv")

######


# Partial profits --------

## Import revenue files for all scenarios ------------------

# rm(list=ls())
# rice_wheat_farmer_practice_rev=read.csv("data/maxwell_interpolated_prices/rice_wheat_farmer_practice_rev.csv")
# rice_wheat_fixed_long_rev=read.csv("data/maxwell_interpolated_prices/rice_wheat_fixed_long_rev.csv")
# rice_wheat_fixed_medium_rev=read.csv("data/maxwell_interpolated_prices/rice_wheat_fixed_medium_rev.csv")
# rice_wheat_onset_medium_rev=read.csv("data/maxwell_interpolated_prices/rice_wheat_onset_medium_rev.csv")
# rice_wheat_onset_long_suppl_rev=read.csv("data/maxwell_interpolated_prices/rice_wheat_onset_long_suppl_rev.csv")
# rice_wheat_onset_medium_suppl_rev=read.csv("data/maxwell_interpolated_prices/rice_wheat_onset_medium_suppl_rev.csv")

# Import irrigation raster files

##baseline -----------------------------------------------------------
baseline_diesel_irrig_costs=rast("output/baseline_diesel_irrig_costs.nc")
baseline_electric_irrig_costs=rast("output/baseline_diesel_irrig_costs.nc")
baseline_rented_irrig_costs=rast("output/baseline_diesel_irrig_costs.nc")

plot(baseline_diesel_irrig_costs)
bihar <- readOGR(india_states)
bihar_shape= bihar[bihar$NAME_1=="Bihar",]
plot(bihar_shape)
bihar_shape_terra=vect(bihar_shape)

# Diesel
baseline_diesel_irrig_costs_bihar=mask(baseline_diesel_irrig_costs,bihar_shape_terra)
plot(baseline_diesel_irrig_costs_bihar)
baseline_diesel_irrig_costs_bihar_stack=raster::stack(baseline_diesel_irrig_costs_bihar)
baseline_diesel_irrig_costs_bihar_stack_Rupees_ha=baseline_diesel_irrig_costs_bihar_stack*80
plot(baseline_diesel_irrig_costs_bihar_stack_Rupees_ha)
rice_wheat_farmer_practice_rast_m_stack_diesel_profit=rice_wheat_farmer_practice_rast_m_stack_revenue-baseline_diesel_irrig_costs_bihar_stack_Rupees_ha
plot(rice_wheat_farmer_practice_rast_m_stack_diesel_profit)

rice_wheat_farmer_practice_diesel_profit_pt=rasterToPoints(rice_wheat_farmer_practice_rast_m_stack_diesel_profit)
write.csv(rice_wheat_farmer_practice_diesel_profit_pt,"data/maxwell_interpolated_prices/rice_wheat_farmer_practice_diesel_profit_pt.csv")

library(raster)
writeRaster(baseline_diesel_irrig_costs_bihar_stack_Rupees_ha,"data/maxwell_interpolated_prices/baseline_diesel_irrig_costs_bihar_stack_Rupees_ha.tif")
baseline_diesel_irrig_costs_bihar_stack_Rupees_ha_pt=rasterToPoints(baseline_diesel_irrig_costs_bihar_stack_Rupees_ha)
write.csv(baseline_diesel_irrig_costs_bihar_stack_Rupees_ha_pt,"data/maxwell_interpolated_prices/baseline_diesel_irrig_costs_bihar_stack_Rupees_ha_pt.csv")






# Electric irrigation
baseline_electric_irrig_costs_bihar=mask(baseline_electric_irrig_costs,bihar_shape_terra)
plot(baseline_electric_irrig_costs_bihar)
baseline_electric_irrig_costs_bihar_stack=raster::stack(baseline_electric_irrig_costs_bihar)
baseline_electric_irrig_costs_bihar_stack_Rupees_ha=baseline_electric_irrig_costs_bihar_stack*80
plot(baseline_electric_irrig_costs_bihar_stack_Rupees_ha)
rice_wheat_farmer_practice_rast_m_stack_electric_profit=rice_wheat_farmer_practice_rast_m_stack_revenue-baseline_electric_irrig_costs_bihar_stack_Rupees_ha
plot(rice_wheat_farmer_practice_rast_m_stack_electric_profit)

rice_wheat_farmer_practice_electric_profit_pt=rasterToPoints(rice_wheat_farmer_practice_rast_m_stack_electric_profit)
write.csv(rice_wheat_farmer_practice_electric_profit_pt,"data/maxwell_interpolated_prices/rice_wheat_farmer_practice_electric_profit_pt.csv")

# Rented irrigation
baseline_rented_irrig_costs_bihar=mask(baseline_rented_irrig_costs,bihar_shape_terra)
plot(baseline_rented_irrig_costs_bihar)
baseline_rented_irrig_costs_bihar_stack=raster::stack(baseline_rented_irrig_costs_bihar)
baseline_rented_irrig_costs_bihar_stack_Rupees_ha=baseline_rented_irrig_costs_bihar_stack*80
plot(baseline_rented_irrig_costs_bihar_stack_Rupees_ha)
rice_wheat_farmer_practice_rast_m_stack_rented_profit=rice_wheat_farmer_practice_rast_m_stack_revenue-baseline_rented_irrig_costs_bihar_stack_Rupees_ha
plot(rice_wheat_farmer_practice_rast_m_stack_rented_profit)

rice_wheat_farmer_practice_rented_profit_pt=rasterToPoints(rice_wheat_farmer_practice_rast_m_stack_rented_profit)
write.csv(rice_wheat_farmer_practice_rented_profit_pt,"data/maxwell_interpolated_prices/rice_wheat_farmer_practice_rented_profit_pt.csv")


library(raster)
writeRaster(baseline_rented_irrig_costs_bihar_stack_Rupees_ha,"data/maxwell_interpolated_prices/baseline_rented_irrig_costs_bihar_stack_Rupees_ha.tif")
baseline_rented_irrig_costs_bihar_stack_Rupees_ha_pt=rasterToPoints(baseline_rented_irrig_costs_bihar_stack_Rupees_ha)
write.csv(baseline_rented_irrig_costs_bihar_stack_Rupees_ha_pt,"data/maxwell_interpolated_prices/baseline_rented_irrig_costs_bihar_stack_Rupees_ha_pt.csv")




## fixed long -------------------
fixed_long_diesel_irrig_costs=rast("output/fixed_long_diesel_irrig_costs.nc")
fixed_long_electric_irrig_costs=rast("output/fixed_long_diesel_irrig_costs.nc")
fixed_long_rented_irrig_costs=rast("output/fixed_long_diesel_irrig_costs.nc")

plot(fixed_long_diesel_irrig_costs)
bihar <- readOGR(india_states)
bihar_shape= bihar[bihar$NAME_1=="Bihar",]
plot(bihar_shape)
bihar_shape_terra=vect(bihar_shape)

# Diesel
fixed_long_diesel_irrig_costs_bihar=mask(fixed_long_diesel_irrig_costs,bihar_shape_terra)
plot(fixed_long_diesel_irrig_costs_bihar)
fixed_long_diesel_irrig_costs_bihar_stack=raster::stack(fixed_long_diesel_irrig_costs_bihar)
fixed_long_diesel_irrig_costs_bihar_stack_Rupees_ha=fixed_long_diesel_irrig_costs_bihar_stack*80
plot(fixed_long_diesel_irrig_costs_bihar_stack_Rupees_ha)
rice_wheat_fixed_long_rast_m_stack_diesel_profit=rice_wheat_fixed_long_rast_m_stack_revenue-fixed_long_diesel_irrig_costs_bihar_stack_Rupees_ha
plot(rice_wheat_fixed_long_rast_m_stack_diesel_profit)

rice_wheat_fixed_long_diesel_profit_pt=rasterToPoints(rice_wheat_fixed_long_rast_m_stack_diesel_profit)
write.csv(rice_wheat_fixed_long_diesel_profit_pt,"data/maxwell_interpolated_prices/rice_wheat_fixed_long_diesel_profit_pt.csv")




# Electric irrigation
fixed_long_electric_irrig_costs_bihar=mask(fixed_long_electric_irrig_costs,bihar_shape_terra)
plot(fixed_long_electric_irrig_costs_bihar)
fixed_long_electric_irrig_costs_bihar_stack=raster::stack(fixed_long_electric_irrig_costs_bihar)
fixed_long_electric_irrig_costs_bihar_stack_Rupees_ha=fixed_long_electric_irrig_costs_bihar_stack*80
plot(fixed_long_electric_irrig_costs_bihar_stack_Rupees_ha)
rice_wheat_fixed_long_rast_m_stack_electric_profit=rice_wheat_fixed_long_rast_m_stack_revenue-fixed_long_electric_irrig_costs_bihar_stack_Rupees_ha
plot(rice_wheat_fixed_long_rast_m_stack_electric_profit)

rice_wheat_fixed_long_electric_profit_pt=rasterToPoints(rice_wheat_fixed_long_rast_m_stack_electric_profit)
write.csv(rice_wheat_fixed_long_electric_profit_pt,"data/maxwell_interpolated_prices/rice_wheat_fixed_long_electric_profit_pt.csv")



# Rented irrigation
fixed_long_rented_irrig_costs_bihar=mask(fixed_long_rented_irrig_costs,bihar_shape_terra)
plot(fixed_long_rented_irrig_costs_bihar)
fixed_long_rented_irrig_costs_bihar_stack=raster::stack(fixed_long_rented_irrig_costs_bihar)
fixed_long_rented_irrig_costs_bihar_stack_Rupees_ha=fixed_long_rented_irrig_costs_bihar_stack*80
plot(fixed_long_rented_irrig_costs_bihar_stack_Rupees_ha)
rice_wheat_fixed_long_rast_m_stack_rented_profit=rice_wheat_fixed_long_rast_m_stack_revenue-fixed_long_rented_irrig_costs_bihar_stack_Rupees_ha
plot(rice_wheat_fixed_long_rast_m_stack_rented_profit)

rice_wheat_fixed_long_rented_profit_pt=rasterToPoints(rice_wheat_fixed_long_rast_m_stack_rented_profit)
write.csv(rice_wheat_fixed_long_electric_profit_pt,"data/maxwell_interpolated_prices/rice_wheat_fixed_long_rented_profit_pt.csv")


library(raster)
writeRaster(fixed_long_rented_irrig_costs_bihar_stack_Rupees_ha,"data/maxwell_interpolated_prices/rice_wheat_fixed_long_rented_irrig_costs_bihar_stack_Rupees_ha.tif")
rice_wheat_fixed_long_rented_irrig_costs_bihar_stack_Rupees_ha_pt=rasterToPoints(fixed_long_rented_irrig_costs_bihar_stack_Rupees_ha)
write.csv(rice_wheat_fixed_long_rented_irrig_costs_bihar_stack_Rupees_ha_pt,"data/maxwell_interpolated_prices/rice_wheat_fixed_long_rented_irrig_costs_bihar_stack_Rupees_ha_pt.csv")





## fixed medium --------------------------------------
fixed_medium_diesel_irrig_costs=rast("output/fixed_medium_diesel_irrig_costs.nc")
fixed_medium_electric_irrig_costs=rast("output/fixed_medium_diesel_irrig_costs.nc")
fixed_medium_rented_irrig_costs=rast("output/fixed_medium_diesel_irrig_costs.nc")

plot(fixed_medium_diesel_irrig_costs)
bihar <- readOGR(india_states)
bihar_shape= bihar[bihar$NAME_1=="Bihar",]
plot(bihar_shape)
bihar_shape_terra=vect(bihar_shape)

# Diesel
fixed_medium_diesel_irrig_costs_bihar=mask(fixed_medium_diesel_irrig_costs,bihar_shape_terra)
plot(fixed_medium_diesel_irrig_costs_bihar)
fixed_medium_diesel_irrig_costs_bihar_stack=raster::stack(fixed_medium_diesel_irrig_costs_bihar)
fixed_medium_diesel_irrig_costs_bihar_stack_Rupees_ha=fixed_medium_diesel_irrig_costs_bihar_stack*80
plot(fixed_medium_diesel_irrig_costs_bihar_stack_Rupees_ha)
rice_wheat_fixed_medium_rast_m_stack_diesel_profit=rice_wheat_fixed_medium_rast_m_stack_revenue-fixed_medium_diesel_irrig_costs_bihar_stack_Rupees_ha
plot(rice_wheat_fixed_medium_rast_m_stack_diesel_profit)

rice_wheat_fixed_medium_diesel_profit_pt=rasterToPoints(rice_wheat_fixed_medium_rast_m_stack_diesel_profit)
write.csv(rice_wheat_fixed_medium_diesel_profit_pt,"data/maxwell_interpolated_prices/rice_wheat_fixed_medium_diesel_profit_pt.csv")


# Electric irrigation
fixed_medium_electric_irrig_costs_bihar=mask(fixed_medium_electric_irrig_costs,bihar_shape_terra)
plot(fixed_medium_electric_irrig_costs_bihar)
fixed_medium_electric_irrig_costs_bihar_stack=raster::stack(fixed_medium_electric_irrig_costs_bihar)
fixed_medium_electric_irrig_costs_bihar_stack_Rupees_ha=fixed_medium_electric_irrig_costs_bihar_stack*80
plot(fixed_medium_electric_irrig_costs_bihar_stack_Rupees_ha)
rice_wheat_fixed_medium_rast_m_stack_electric_profit=rice_wheat_fixed_medium_rast_m_stack_revenue-fixed_medium_electric_irrig_costs_bihar_stack_Rupees_ha
plot(rice_wheat_fixed_medium_rast_m_stack_electric_profit)

rice_wheat_fixed_medium_electric_profit_pt=rasterToPoints(rice_wheat_fixed_medium_rast_m_stack_electric_profit)
write.csv(rice_wheat_fixed_medium_electric_profit_pt,"data/maxwell_interpolated_prices/rice_wheat_fixed_medium_electric_profit_pt.csv")


# Rented irrigation
fixed_medium_rented_irrig_costs_bihar=mask(fixed_medium_rented_irrig_costs,bihar_shape_terra)
plot(fixed_medium_rented_irrig_costs_bihar)
fixed_medium_rented_irrig_costs_bihar_stack=raster::stack(fixed_medium_rented_irrig_costs_bihar)
fixed_medium_rented_irrig_costs_bihar_stack_Rupees_ha=fixed_medium_rented_irrig_costs_bihar_stack*80
plot(fixed_medium_rented_irrig_costs_bihar_stack_Rupees_ha)
rice_wheat_fixed_medium_rast_m_stack_rented_profit=rice_wheat_fixed_medium_rast_m_stack_revenue-fixed_medium_rented_irrig_costs_bihar_stack_Rupees_ha
plot(rice_wheat_fixed_medium_rast_m_stack_rented_profit)

rice_wheat_fixed_medium_rented_profit_pt=rasterToPoints(rice_wheat_fixed_medium_rast_m_stack_rented_profit)
write.csv(rice_wheat_fixed_medium_rented_profit_pt,"data/maxwell_interpolated_prices/rice_wheat_fixed_medium_rented_profit_pt.csv")


## onset long -------------------------------------------------
onset_long_diesel_irrig_costs=rast("output/onset_long_diesel_irrig_costs.nc")
onset_long_electric_irrig_costs=rast("output/onset_long_diesel_irrig_costs.nc")
onset_long_rented_irrig_costs=rast("output/onset_long_diesel_irrig_costs.nc")

plot(onset_long_diesel_irrig_costs)
bihar <- readOGR(india_states)
bihar_shape= bihar[bihar$NAME_1=="Bihar",]
plot(bihar_shape)
bihar_shape_terra=vect(bihar_shape)

# Diesel
onset_long_diesel_irrig_costs_bihar=mask(onset_long_diesel_irrig_costs,bihar_shape_terra)
plot(onset_long_diesel_irrig_costs_bihar)
onset_long_diesel_irrig_costs_bihar_stack=raster::stack(onset_long_diesel_irrig_costs_bihar)
onset_long_diesel_irrig_costs_bihar_stack_Rupees_ha=onset_long_diesel_irrig_costs_bihar_stack*80
plot(onset_long_diesel_irrig_costs_bihar_stack_Rupees_ha)
rice_wheat_onset_long_rast_m_stack_diesel_profit=rice_wheat_onset_long_rast_m_stack_revenue-onset_long_diesel_irrig_costs_bihar_stack_Rupees_ha
plot(rice_wheat_onset_long_rast_m_stack_diesel_profit)

rice_wheat_onset_long_diesel_profit_pt=rasterToPoints(rice_wheat_onset_long_rast_m_stack_diesel_profit)
write.csv(rice_wheat_onset_long_diesel_profit_pt,"data/maxwell_interpolated_prices/rice_wheat_onset_long_diesel_profit_pt.csv")



# Electric irrigation
onset_long_electric_irrig_costs_bihar=mask(onset_long_electric_irrig_costs,bihar_shape_terra)
plot(onset_long_electric_irrig_costs_bihar)
onset_long_electric_irrig_costs_bihar_stack=raster::stack(onset_long_electric_irrig_costs_bihar)
onset_long_electric_irrig_costs_bihar_stack_Rupees_ha=onset_long_electric_irrig_costs_bihar_stack*80
plot(onset_long_electric_irrig_costs_bihar_stack_Rupees_ha)
rice_wheat_onset_long_rast_m_stack_electric_profit=rice_wheat_onset_long_rast_m_stack_revenue-onset_long_electric_irrig_costs_bihar_stack_Rupees_ha
plot(rice_wheat_onset_long_rast_m_stack_electric_profit)

rice_wheat_onset_long_electric_profit_pt=rasterToPoints(rice_wheat_onset_long_rast_m_stack_electric_profit)
write.csv(rice_wheat_onset_long_electric_profit_pt,"data/maxwell_interpolated_prices/rice_wheat_onset_long_electric_profit_pt.csv")



# Rented irrigation
onset_long_rented_irrig_costs_bihar=mask(onset_long_rented_irrig_costs,bihar_shape_terra)
plot(onset_long_rented_irrig_costs_bihar)
onset_long_rented_irrig_costs_bihar_stack=raster::stack(onset_long_rented_irrig_costs_bihar)
onset_long_rented_irrig_costs_bihar_stack_Rupees_ha=onset_long_rented_irrig_costs_bihar_stack*80
plot(onset_long_rented_irrig_costs_bihar_stack_Rupees_ha)
rice_wheat_onset_long_rast_m_stack_rented_profit=rice_wheat_onset_long_rast_m_stack_revenue-onset_long_rented_irrig_costs_bihar_stack_Rupees_ha
plot(rice_wheat_onset_long_rast_m_stack_rented_profit)


rice_wheat_onset_long_rented_profit_pt=rasterToPoints(rice_wheat_onset_long_rast_m_stack_rented_profit)
write.csv(rice_wheat_onset_long_rented_profit_pt,"data/maxwell_interpolated_prices/rice_wheat_onset_long_rented_profit_pt.csv")


library(raster)
writeRaster(onset_long_rented_irrig_costs_bihar_stack_Rupees_ha,"data/maxwell_interpolated_prices/onset_long_rented_irrig_costs_bihar_stack_Rupees_ha.tif")
onset_long_rented_irrig_costs_bihar_stack_Rupees_ha_pt=rasterToPoints(onset_long_rented_irrig_costs_bihar_stack_Rupees_ha)
write.csv(onset_long_rented_irrig_costs_bihar_stack_Rupees_ha_pt,"data/maxwell_interpolated_prices/onset_long_rented_irrig_costs_bihar_stack_Rupees_ha_pt.csv")






## onset long suppl -----------
onset_long_suppl_diesel_irrig_costs=rast("output/onset_long_suppl_diesel_irrig_costs.nc")
onset_long_suppl_electric_irrig_costs=rast("output/onset_long_suppl_diesel_irrig_costs.nc")
onset_long_suppl_rented_irrig_costs=rast("output/onset_long_suppl_diesel_irrig_costs.nc")

plot(onset_long_suppl_diesel_irrig_costs)
bihar <- readOGR(india_states)
bihar_shape= bihar[bihar$NAME_1=="Bihar",]
plot(bihar_shape)
bihar_shape_terra=vect(bihar_shape)

# Diesel
onset_long_suppl_diesel_irrig_costs_bihar=mask(onset_long_suppl_diesel_irrig_costs,bihar_shape_terra)
plot(onset_long_suppl_diesel_irrig_costs_bihar)
onset_long_suppl_diesel_irrig_costs_bihar_stack=raster::stack(onset_long_suppl_diesel_irrig_costs_bihar)
onset_long_suppl_diesel_irrig_costs_bihar_stack_Rupees_ha=onset_long_suppl_diesel_irrig_costs_bihar_stack*80
plot(onset_long_suppl_diesel_irrig_costs_bihar_stack_Rupees_ha)
rice_wheat_onset_long_suppl_rast_m_stack_diesel_profit=rice_wheat_onset_long_suppl_rast_m_stack_revenue-onset_long_suppl_diesel_irrig_costs_bihar_stack_Rupees_ha
plot(rice_wheat_onset_long_suppl_rast_m_stack_diesel_profit)

rice_wheat_onset_long_suppl_diesel_profit_pt=rasterToPoints(rice_wheat_onset_long_suppl_rast_m_stack_diesel_profit)
write.csv(rice_wheat_onset_long_suppl_diesel_profit_pt,"data/maxwell_interpolated_prices/rice_wheat_onset_long_suppl_diesel_profit_pt.csv")



# Electric irrigation
onset_long_suppl_electric_irrig_costs_bihar=mask(onset_long_suppl_electric_irrig_costs,bihar_shape_terra)
plot(onset_long_suppl_electric_irrig_costs_bihar)
onset_long_suppl_electric_irrig_costs_bihar_stack=raster::stack(onset_long_suppl_electric_irrig_costs_bihar)
onset_long_suppl_electric_irrig_costs_bihar_stack_Rupees_ha=onset_long_suppl_electric_irrig_costs_bihar_stack*80
plot(onset_long_suppl_electric_irrig_costs_bihar_stack_Rupees_ha)
rice_wheat_onset_long_suppl_rast_m_stack_electric_profit=rice_wheat_onset_long_suppl_rast_m_stack_revenue-onset_long_suppl_electric_irrig_costs_bihar_stack_Rupees_ha
plot(rice_wheat_onset_long_suppl_rast_m_stack_electric_profit)


rice_wheat_onset_long_suppl_electric_profit_pt=rasterToPoints(rice_wheat_onset_long_suppl_rast_m_stack_electric_profit)
write.csv(rice_wheat_onset_long_suppl_electric_profit_pt,"data/maxwell_interpolated_prices/rice_wheat_onset_long_suppl_electric_profit_pt.csv")

# Rented irrigation
onset_long_suppl_rented_irrig_costs_bihar=mask(onset_long_suppl_rented_irrig_costs,bihar_shape_terra)
plot(onset_long_suppl_rented_irrig_costs_bihar)
onset_long_suppl_rented_irrig_costs_bihar_stack=raster::stack(onset_long_suppl_rented_irrig_costs_bihar)
onset_long_suppl_rented_irrig_costs_bihar_stack_Rupees_ha=onset_long_suppl_rented_irrig_costs_bihar_stack*80
plot(onset_long_suppl_rented_irrig_costs_bihar_stack_Rupees_ha)
rice_wheat_onset_long_suppl_rast_m_stack_rented_profit=rice_wheat_onset_long_suppl_rast_m_stack_revenue-onset_long_suppl_rented_irrig_costs_bihar_stack_Rupees_ha
plot(rice_wheat_onset_long_suppl_rast_m_stack_rented_profit)


rice_wheat_onset_long_suppl_rented_profit_pt=rasterToPoints(rice_wheat_onset_long_suppl_rast_m_stack_rented_profit)
write.csv(rice_wheat_onset_long_suppl_rented_profit_pt,"data/maxwell_interpolated_prices/rice_wheat_onset_long_suppl_rented_profit_pt.csv")



## onset medium ------------------------
onset_medium_diesel_irrig_costs=rast("output/onset_medium_diesel_irrig_costs.nc")
onset_medium_electric_irrig_costs=rast("output/onset_medium_diesel_irrig_costs.nc")
onset_medium_rented_irrig_costs=rast("output/onset_medium_diesel_irrig_costs.nc")

plot(onset_medium_diesel_irrig_costs)
bihar <- readOGR(india_states)
bihar_shape= bihar[bihar$NAME_1=="Bihar",]
plot(bihar_shape)
bihar_shape_terra=vect(bihar_shape)

# Diesel
onset_medium_diesel_irrig_costs_bihar=mask(onset_medium_diesel_irrig_costs,bihar_shape_terra)
plot(onset_medium_diesel_irrig_costs_bihar)
onset_medium_diesel_irrig_costs_bihar_stack=raster::stack(onset_medium_diesel_irrig_costs_bihar)
onset_medium_diesel_irrig_costs_bihar_stack_Rupees_ha=onset_medium_diesel_irrig_costs_bihar_stack*80
plot(onset_medium_diesel_irrig_costs_bihar_stack_Rupees_ha)
rice_wheat_onset_medium_rast_m_stack_diesel_profit=rice_wheat_onset_medium_rast_m_stack_revenue-onset_medium_diesel_irrig_costs_bihar_stack_Rupees_ha
plot(rice_wheat_onset_medium_rast_m_stack_diesel_profit)


rice_wheat_onset_medium__diesel_profit_pt=rasterToPoints(rice_wheat_onset_medium_rast_m_stack_diesel_profit)
write.csv(rice_wheat_onset_medium__diesel_profit_pt,"data/maxwell_interpolated_prices/rice_wheat_onset_medium__diesel_profit_pt.csv")


# Electric irrigation
onset_medium_electric_irrig_costs_bihar=mask(onset_medium_electric_irrig_costs,bihar_shape_terra)
plot(onset_medium_electric_irrig_costs_bihar)
onset_medium_electric_irrig_costs_bihar_stack=raster::stack(onset_medium_electric_irrig_costs_bihar)
onset_medium_electric_irrig_costs_bihar_stack_Rupees_ha=onset_medium_electric_irrig_costs_bihar_stack*80
plot(onset_medium_electric_irrig_costs_bihar_stack_Rupees_ha)
rice_wheat_onset_medium_rast_m_stack_electric_profit=rice_wheat_onset_medium_rast_m_stack_revenue-onset_medium_electric_irrig_costs_bihar_stack_Rupees_ha
plot(rice_wheat_onset_medium_rast_m_stack_electric_profit)

rice_wheat_onset_medium__electric_profit_pt=rasterToPoints(rice_wheat_onset_medium_rast_m_stack_electric_profit)
write.csv(rice_wheat_onset_medium__electric_profit_pt,"data/maxwell_interpolated_prices/rice_wheat_onset_medium__electric_profit_pt.csv")



# Rented irrigation
onset_medium_rented_irrig_costs_bihar=mask(onset_medium_rented_irrig_costs,bihar_shape_terra)
plot(onset_medium_rented_irrig_costs_bihar)
onset_medium_rented_irrig_costs_bihar_stack=raster::stack(onset_medium_rented_irrig_costs_bihar)
onset_medium_rented_irrig_costs_bihar_stack_Rupees_ha=onset_medium_rented_irrig_costs_bihar_stack*80
plot(onset_medium_rented_irrig_costs_bihar_stack_Rupees_ha)
rice_wheat_onset_medium_rast_m_stack_rented_profit=rice_wheat_onset_medium_rast_m_stack_revenue-onset_medium_rented_irrig_costs_bihar_stack_Rupees_ha
plot(rice_wheat_onset_medium_rast_m_stack_rented_profit)

rice_wheat_onset_medium_rented_profit_pt=rasterToPoints(rice_wheat_onset_medium_rast_m_stack_rented_profit)
write.csv(rice_wheat_onset_medium_rented_profit_pt,"data/maxwell_interpolated_prices/rice_wheat_onset_medium_rented_profit_pt.csv")



## onset medium suppl ----------------------------------
onset_medium_suppl_diesel_irrig_costs=rast("output/onset_medium_suppl_diesel_irrig_costs.nc")
onset_medium_suppl_electric_irrig_costs=rast("output/onset_medium_suppl_diesel_irrig_costs.nc")
onset_medium_suppl_rented_irrig_costs=rast("output/onset_medium_suppl_diesel_irrig_costs.nc")

plot(onset_medium_suppl_diesel_irrig_costs)
bihar <- readOGR(india_states)
bihar_shape= bihar[bihar$NAME_1=="Bihar",]
plot(bihar_shape)
bihar_shape_terra=vect(bihar_shape)

# Diesel
onset_medium_suppl_diesel_irrig_costs_bihar=mask(onset_medium_suppl_diesel_irrig_costs,bihar_shape_terra)
plot(onset_medium_suppl_diesel_irrig_costs_bihar)
onset_medium_suppl_diesel_irrig_costs_bihar_stack=raster::stack(onset_medium_suppl_diesel_irrig_costs_bihar)
onset_medium_suppl_diesel_irrig_costs_bihar_stack_Rupees_ha=onset_medium_suppl_diesel_irrig_costs_bihar_stack*80
plot(onset_medium_suppl_diesel_irrig_costs_bihar_stack_Rupees_ha)
rice_wheat_onset_medium_suppl_rast_m_stack_diesel_profit=rice_wheat_onset_medium_suppl_rast_m_stack_revenue-onset_medium_suppl_diesel_irrig_costs_bihar_stack_Rupees_ha
plot(rice_wheat_onset_medium_suppl_rast_m_stack_diesel_profit)

rice_wheat_onset_medium_suppl_diesel_profit_pt=rasterToPoints(rice_wheat_onset_medium_suppl_rast_m_stack_diesel_profit)
write.csv(rice_wheat_onset_medium_suppl_diesel_profit_pt,"data/maxwell_interpolated_prices/rice_wheat_onset_medium_suppl_diesel_profit_pt.csv")

# Electric irrigation
onset_medium_suppl_electric_irrig_costs_bihar=mask(onset_medium_suppl_electric_irrig_costs,bihar_shape_terra)
plot(onset_medium_suppl_electric_irrig_costs_bihar)
onset_medium_suppl_electric_irrig_costs_bihar_stack=raster::stack(onset_medium_suppl_electric_irrig_costs_bihar)
onset_medium_suppl_electric_irrig_costs_bihar_stack_Rupees_ha=onset_medium_suppl_electric_irrig_costs_bihar_stack*80
plot(onset_medium_suppl_electric_irrig_costs_bihar_stack_Rupees_ha)
rice_wheat_onset_medium_suppl_rast_m_stack_electric_profit=rice_wheat_onset_medium_suppl_rast_m_stack_revenue-onset_medium_suppl_electric_irrig_costs_bihar_stack_Rupees_ha
plot(rice_wheat_onset_medium_suppl_rast_m_stack_electric_profit)

rice_wheat_onset_medium_suppl_electric_profit_pt=rasterToPoints(rice_wheat_onset_medium_suppl_rast_m_stack_electric_profit)
write.csv(rice_wheat_onset_medium_suppl_electric_profit_pt,"data/maxwell_interpolated_prices/rice_wheat_onset_medium_suppl_electric_profit_pt.csv")

# Rented irrigation
onset_medium_suppl_rented_irrig_costs_bihar=mask(onset_medium_suppl_rented_irrig_costs,bihar_shape_terra)
plot(onset_medium_suppl_rented_irrig_costs_bihar)
onset_medium_suppl_rented_irrig_costs_bihar_stack=raster::stack(onset_medium_suppl_rented_irrig_costs_bihar)
onset_medium_suppl_rented_irrig_costs_bihar_stack_Rupees_ha=onset_medium_suppl_rented_irrig_costs_bihar_stack*80
plot(onset_medium_suppl_rented_irrig_costs_bihar_stack_Rupees_ha)
rice_wheat_onset_medium_suppl_rast_m_stack_rented_profit=rice_wheat_onset_medium_suppl_rast_m_stack_revenue-onset_medium_suppl_rented_irrig_costs_bihar_stack_Rupees_ha
plot(rice_wheat_onset_medium_suppl_rast_m_stack_rented_profit)

rice_wheat_onset_medium_suppl_rented_profit_pt=rasterToPoints(rice_wheat_onset_medium_suppl_rast_m_stack_rented_profit)
write.csv(rice_wheat_onset_medium_suppl_rented_profit_pt,"data/maxwell_interpolated_prices/rice_wheat_onset_medium_suppl_rented_profit_pt.csv")



