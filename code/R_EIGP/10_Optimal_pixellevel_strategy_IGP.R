# Load packages
library(rio)


# Load all datasets
RA_rice_wheat_farmer_practice_fixedlong_prof_IGP <- read.csv("data/maxwell_output_fixedLong_prof_IGP/RA_rice_wheat_farmer_practice_fixedlong_prof_IGP.csv")
RA_rice_wheat_fixedlong_fixedmedium_prof_IGP <- read.csv("data/maxwell_output_fixedLong_prof_IGP/RA_rice_wheat_fixedlong_fixedmedium_prof_IGP.csv")
RA_rice_wheat_fixedlong_onset_long_prof_IGP <- read.csv("data/maxwell_output_fixedLong_prof_IGP/RA_rice_wheat_fixedlong_onset_long_prof_IGP.csv")
RA_rice_wheat_fixedlong_onset_long_suppl_prof_IGP <- read.csv("data/maxwell_output_fixedLong_prof_IGP/RA_rice_wheat_fixedlong_onset_long_suppl_prof_IGP.csv")
RA_rice_wheat_fixedlong_onset_medium_prof_IGP <- read.csv("data/maxwell_output_fixedLong_prof_IGP/RA_rice_wheat_fixedlong_onset_medium_prof_IGP.csv")
RA_rice_wheat_fixedlong_onset_medium_suppl_prof_IGP <- read.csv("data/maxwell_output_fixedLong_prof_IGP/RA_rice_wheat_fixedlong_onset_medium_suppl_prof_IGP.csv")


RA_rice_wheat_farmer_practice_fixedlong_prof_IGP$FP_LowerBound=(RA_rice_wheat_farmer_practice_fixedlong_prof_IGP$CompMinPropSOSDBase*-1)/1000
RA_rice_wheat_farmer_practice_fixedlong_prof_IGP$FP_UpperBound=(RA_rice_wheat_farmer_practice_fixedlong_prof_IGP$BaseMinPropSOSDComp*-1)/1000
FP=subset(RA_rice_wheat_farmer_practice_fixedlong_prof_IGP,select=c("CellID","FP_LowerBound","FP_UpperBound"))

RA_rice_wheat_fixedlong_fixedmedium_prof_IGP$FM_LowerBound=(RA_rice_wheat_fixedlong_fixedmedium_prof_IGP$CompMinPropSOSDBase*-1)/1000
RA_rice_wheat_fixedlong_fixedmedium_prof_IGP$FM_UpperBound=(RA_rice_wheat_fixedlong_fixedmedium_prof_IGP$BaseMinPropSOSDComp*-1)/1000
FM=subset(RA_rice_wheat_fixedlong_fixedmedium_prof_IGP,select=c("CellID","FM_LowerBound","FM_UpperBound"))

RA_rice_wheat_fixedlong_onset_long_prof_IGP$OL_LowerBound=(RA_rice_wheat_fixedlong_onset_long_prof_IGP$CompMinPropSOSDBase*-1)/1000
RA_rice_wheat_fixedlong_onset_long_prof_IGP$OL_UpperBound=(RA_rice_wheat_fixedlong_onset_long_prof_IGP$BaseMinPropSOSDComp*-1)/1000
OL=subset(RA_rice_wheat_fixedlong_onset_long_prof_IGP,select=c("CellID","OL_LowerBound","OL_UpperBound"))


RA_rice_wheat_fixedlong_onset_long_suppl_prof_IGP$OLS_LowerBound=(RA_rice_wheat_fixedlong_onset_long_suppl_prof_IGP$CompMinPropSOSDBase*-1)/1000
RA_rice_wheat_fixedlong_onset_long_suppl_prof_IGP$OLS_UpperBound=(RA_rice_wheat_fixedlong_onset_long_suppl_prof_IGP$BaseMinPropSOSDComp*-1)/1000
OLS=subset(RA_rice_wheat_fixedlong_onset_long_suppl_prof_IGP,select=c("CellID","OLS_LowerBound","OLS_UpperBound"))

RA_rice_wheat_fixedlong_onset_medium_prof_IGP$OM_LowerBound=(RA_rice_wheat_fixedlong_onset_medium_prof_IGP$CompMinPropSOSDBase*-1)/1000
RA_rice_wheat_fixedlong_onset_medium_prof_IGP$OM_UpperBound=(RA_rice_wheat_fixedlong_onset_medium_prof_IGP$BaseMinPropSOSDComp*-1)/1000
OM=subset(RA_rice_wheat_fixedlong_onset_medium_prof_IGP,select=c("CellID","OM_LowerBound","OM_UpperBound"))

RA_rice_wheat_fixedlong_onset_medium_suppl_prof_IGP$OMS_LowerBound=(RA_rice_wheat_fixedlong_onset_medium_suppl_prof_IGP$CompMinPropSOSDBase*-1)/1000
RA_rice_wheat_fixedlong_onset_medium_suppl_prof_IGP$OMS_UpperBound=(RA_rice_wheat_fixedlong_onset_medium_suppl_prof_IGP$BaseMinPropSOSDComp*-1)/1000
OMS=subset(RA_rice_wheat_fixedlong_onset_medium_suppl_prof_IGP,select=c("CellID","OMS_LowerBound","OMS_UpperBound"))

library(tidyverse)

#put all data frames into list
df_list <- list(FP, FM, OL, OLS, OM, OMS)      

#merge all data frames together
WTP_Bounds=df_list %>% reduce(full_join, by='CellID')


WTP_Bounds$max_UpperBound_WTP<- pmax(WTP_Bounds$FP_UpperBound, WTP_Bounds$FM_UpperBound,WTP_Bounds$OL_UpperBound,
                          WTP_Bounds$OLS_UpperBound,WTP_Bounds$OM_UpperBound,WTP_Bounds$OMS_UpperBound)

WTP_Bounds$max_LowerBound_WTP<- pmax(WTP_Bounds$FP_LowerBound, WTP_Bounds$FM_LowerBound,WTP_Bounds$OL_LowerBound,
                                     WTP_Bounds$OLS_LowerBound,WTP_Bounds$OM_LowerBound,WTP_Bounds$OMS_LowerBound)


WTP_Bounds_UB=subset(WTP_Bounds,select=c("FP_UpperBound","FM_UpperBound","OL_UpperBound",
                                         "OLS_UpperBound","OM_UpperBound","OMS_UpperBound"))
WTP_Bounds$Optimal_UB=colnames(WTP_Bounds_UB)[max.col(WTP_Bounds_UB)]

WTP_Bounds_LB=subset(WTP_Bounds,select=c("FP_LowerBound","FM_LowerBound","OL_LowerBound",
                                         "OLS_LowerBound","OM_LowerBound","OMS_LowerBound"))
WTP_Bounds$Optimal_LB=colnames(WTP_Bounds_LB)[max.col(WTP_Bounds_LB)]

WTP_Bounds[c('Optimal_UB_Sc', 'Optimal_UB_name')] <- str_split_fixed(WTP_Bounds$Optimal_UB, '_', 2)
WTP_Bounds[c('Optimal_LB_Sc', 'Optimal_LB_name')] <- str_split_fixed(WTP_Bounds$Optimal_LB, '_', 2)

WTP_Bounds$Logical_optimal=ifelse(WTP_Bounds$Optimal_UB_Sc==WTP_Bounds$Optimal_LB_Sc,"Yes","No")

WTP_Bounds$Logical_optimal2=WTP_Bounds$Logical_optimal

WTP_Bounds$Logical_optimal2[WTP_Bounds$max_LowerBound_WTP<0]="FL"

WTP_Bounds$Logical_optimal3=paste0(WTP_Bounds$Optimal_UB_Sc,"_",WTP_Bounds$Logical_optimal2)

WTP_Bounds$Logical_optimal3[WTP_Bounds$Logical_optimal3%in%c("FM_FL","FP_FL","OL_FL","OLS_FL","OM_FL","OMS_FL")]="FL"

WTP_Bounds$Logical_optimal4[WTP_Bounds$Logical_optimal3=="FL"]=1
WTP_Bounds$Logical_optimal4[WTP_Bounds$Logical_optimal3=="FM_No"]=2
WTP_Bounds$Logical_optimal4[WTP_Bounds$Logical_optimal3=="FM_Yes"]=3
WTP_Bounds$Logical_optimal4[WTP_Bounds$Logical_optimal3=="FP_No"]=4
WTP_Bounds$Logical_optimal4[WTP_Bounds$Logical_optimal3=="FP_Yes"]=5
WTP_Bounds$Logical_optimal4[WTP_Bounds$Logical_optimal3=="OL_No"]=6
WTP_Bounds$Logical_optimal4[WTP_Bounds$Logical_optimal3=="OL_Yes"]=7
WTP_Bounds$Logical_optimal4[WTP_Bounds$Logical_optimal3=="OLS_No"]=8
WTP_Bounds$Logical_optimal4[WTP_Bounds$Logical_optimal3=="OLS_Yes"]=9
WTP_Bounds$Logical_optimal4[WTP_Bounds$Logical_optimal3=="OM_No"]=10
WTP_Bounds$Logical_optimal4[WTP_Bounds$Logical_optimal3=="OM_Yes"]=11
WTP_Bounds$Logical_optimal4[WTP_Bounds$Logical_optimal3=="OMS_No"]=12
WTP_Bounds$Logical_optimal4[WTP_Bounds$Logical_optimal3=="OMS_Yes"]=13



# Mapping -----------------------
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
library(rio)

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


files <- c(file1)
r <- load_sims(files,"rice_yield",aoi,NA)
r1 <- r[[1]][[1]]

# Optimal rice planting strategy: partial profits
m <- WTP_Bounds

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

optimal_strategies<- r1

values(optimal_strategies)[t]<- m$Logical_optimal4
library(rasterVis)

optimal_strategies<- ratify(optimal_strategies)
rat <- levels(optimal_strategies)[[1]]
rat$optimal_choices <- c("FL","FM_No","FM_Yes",
                         "FP_No","FP_Yes","OL_No",
                         "OL_Yes","OLS_No","OLS_Yes",
                         "OM_No","OM_Yes","OMS_No","OMS_Yes")

rat$optimal_choices_detailed <- c("Fixed long clearly",
                                  "Fixed medium not clear",
                                  "Fixed medium clearly",
                         "Farmer practice not clear",
                         "Farmer practice clearly",
                         "Onset long not clear",
                         "Onset long clearly",
                         "Onset long supp not clear",
                         "Onset long supp clearly",
                         "Onset medium not clear",
                         "Onset medium clearly",
                         "Onsed medium supp not clear",
                         "Onset medium supp clearly")

levels(optimal_strategies) <- rat


levelplot(optimal_strategies,par.settings=RdBuTheme(), main="Optimal rice planting date strategy ")
levelplot(optimal_strategies,att="optimal_choices_detailed",par.settings=RdBuTheme(), main="Optimal rice planting date strategy ")




cols <- c("1" = "red", "2" = "yellow","3" = "orange","4" = "green","5"="blue" ,
          "6"="grey", "8" = "salmon","7"="black","9"="purple",
          "10"="pink","11"="cyan", "12"="darkgreen","13"="brown")

cols <- c("1" = "#ccebc5", "2" = "#b3cde3","3" = "brown","4" = "#b3cde3","5"="#decbe4" ,
          "6"="#b3cde3", "7" = "#fbb4ae","8"="#b3cde3","9"="#fbb4ae",
          "10"="#b3cde3","11"="#fed9a6", "12"="#b3cde3","13"="#fed9a6")


optimal_strategies[optimal_strategies==4] <- 2
optimal_strategies[optimal_strategies==6] <- 2
optimal_strategies[optimal_strategies==8] <- 2
optimal_strategies[optimal_strategies==10] <- 2
optimal_strategies[optimal_strategies==12] <- 2
optimal_strategies[optimal_strategies==5] <- 4
optimal_strategies[optimal_strategies==7] <- 5
optimal_strategies[optimal_strategies==9] <- 7
optimal_strategies[optimal_strategies==11] <- 6
optimal_strategies[optimal_strategies==13] <- 8

cols <- c("1" = "#ccebc5", 
          "2" = "#fbb4ae",
          "3" = "brown",
          "4" ="#decbe4" ,
          "5" = "#b3cde3",
          "6"="#fed9a6",
          "7"="#ffffcc",
          "8"="#e5d8bd")


library(ggpubr)
optimal_strategies_plot=gplot(optimal_strategies) +
  geom_raster(aes(fill = factor(value)))+
  scale_fill_manual(values = cols,na.value = "transparent",
                    breaks = c("2","4","1","3","5","6","7","8"),
                    labels=c(                                       "No clear strategy",
                                                                    "Farmer practice",
                                                                    "Fixed long",
                                                                    "Fixed medium",
                                                                    "Onset long",
                                                                    "Onset medium",
                                                                    "Onset long supp",
                                                                    "Onset medium supp"))+
  labs(x="Longitude",y="Latitude",fill="")+
  theme_classic2()
#previous_theme <- theme_set(theme_bw())
optimal_strategies_plot

ggsave("output/figures_IGP_IGP/optimal_strategies_IGP.png",dpi=300,width=6.88, height=4.16)

write.csv(WTP_Bounds,"output/tables/Optimal_pixellevel_strategy_WTP_Bounds.csv")


