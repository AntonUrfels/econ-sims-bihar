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

m <- read.csv("data/maxwell_output_fixedLong/RA_Wheat_fixedlong_onset_medium_suppl_c.csv")

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

values(r1)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1,par.settings=RdBuTheme(),margin=F)

r1_a <- r1
r1_b <- r1

values(r1_a)[t]<- m$Riskiness_Comp
values(r1_b)[t]<- m$Riskiness_Comp

r1_c <- r1_a + r1_b

library(rasterVis)
levelplot(r1_c,par.settings=RdBuTheme(),margin=F)





# Check for -99 values
#files <- c(file1)
#r <- load_sims(files,"rice_yield",aoi,NA)
#getValues()

# Max additional code for mapping the results ------------------------------

## Rice -------------------------------------------------------------------

### Fixed long versus farmer practice
m <- read.csv("data/maxwell_output_fixedLong/RA_Rice_baseline_fixedlong_c.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_RA_Rice_baseline_fixedlong_c<- r1

values(r1_RA_Rice_baseline_fixedlong_c)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_RA_Rice_baseline_fixedlong_c,par.settings=RdBuTheme(),margin=F, main="Rice:Farmer practice more beneficial than fixed long strategy")


rice_farmer_practice=gplot(r1_RA_Rice_baseline_fixedlong_c) +
  geom_raster(aes(fill = factor(value)))+
  scale_fill_manual(values = c("#F8766D","#619CFF", "#00BA38"),na.value = "transparent",labels=c("Clearly worse","Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="Rice: Farmer practice",fill="Willingness to pay")
previous_theme <- theme_set(theme_bw())
rice_farmer_practice

ggsave("output/figures/rice_farmer_practice.png",dpi=300,width=6.88, height=4.16)






### Fixed long versus fixed medium 
m <- read.csv("data/maxwell_output_fixedLong/RA_Rice_fixedlong_fixedmedium_c.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_Rice_fixedlong_fixedmedium <- r1

values(r1_Rice_fixedlong_fixedmedium)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_Rice_fixedlong_fixedmedium,par.settings=RdBuTheme(),margin=F, main="Rice:Fixed medium more beneficial than fixed long strategy")


rice_fixedmedium=gplot(r1_Rice_fixedlong_fixedmedium) +
  geom_raster(aes(fill = factor(value)))+
  scale_fill_manual(values = c("#619CFF","#00BA38"),na.value = "transparent",labels=c("Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="Rice:Fixed, medium duration variety",fill="Willingness to pay")
previous_theme <- theme_set(theme_bw())
rice_fixedmedium

ggsave("output/figures/rice_fixedmedium.png",dpi=300,width=6.88, height=4.16)


# Fixed long versus onset long supp
m <- read.csv("data/maxwell_output_fixedLong/RA_Rice_fixedlong_onset_long_c.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_Rice_fixedlong_onset_long <- r1
values(r1_Rice_fixedlong_onset_long)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_Rice_fixedlong_onset_long,par.settings=RdBuTheme(),margin=F, main="Rice:Onset long more beneficial than fixed long strategy")

rice_onset_long=gplot(r1_Rice_fixedlong_onset_long) +
  geom_raster(aes(fill = factor(value)))+
  scale_fill_manual(values = c("#619CFF","#00BA38"),na.value = "transparent",labels=c("Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="Rice:Onset, long duration variety",fill="Willingness to pay")
previous_theme <- theme_set(theme_bw())
rice_onset_long

ggsave("output/figures/rice_onset_long.png",dpi=300,width=6.88, height=4.16)





# Fixed long versus onset long suppl
m <- read.csv("data/maxwell_output_fixedLong/RA_Rice_fixedlong_onset_long_suppl_c.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_Rice_fixedlong_onset_long_suppl <- r1
values(r1_Rice_fixedlong_onset_long_suppl)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_Rice_fixedlong_onset_long_suppl,par.settings=RdBuTheme(),margin=F, main="Rice:Onset, long duration variety, supplemental irrigation")

rice_onset_long_supp=gplot(r1_Rice_fixedlong_onset_long_suppl) +
  geom_raster(aes(fill = factor(value)))+
  scale_fill_manual(values = c("#F8766D","#619CFF", "#00BA38"),na.value = "transparent",labels=c("Clearly worse","Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="Rice:Onset, long duration variety, supplemental irrigation",fill="Willingness to pay")
previous_theme <- theme_set(theme_bw())
rice_onset_long_supp

ggsave("output/figures/rice_onset_long_supp.png",dpi=300,width=6.88, height=4.16)




# Fixed long versus onset medium 
m <- read.csv("data/maxwell_output_fixedLong/RA_Rice_fixedlong_onset_medium_c.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_Rice_fixedlong_onset_medium <- r1
values(r1_Rice_fixedlong_onset_medium)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_Rice_fixedlong_onset_medium,par.settings=RdBuTheme(),margin=F, main="Rice:Onset medium more beneficial than fixed long strategy")

rice_onset_medium=gplot(r1_Rice_fixedlong_onset_medium) +
  geom_raster(aes(fill = factor(value)))+
  scale_fill_manual(values = c("#619CFF","#00BA38"),na.value = "transparent",labels=c("Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="Rice:Onset, medium duration variety",fill="Willingness to pay")
previous_theme <- theme_set(theme_bw())
rice_onset_medium
##619CFF

ggsave("output/figures/rice_onset_medium.png",dpi=300,width=6.88, height=4.16)

# Fixed long versus onset medium supp
m <- read.csv("data/maxwell_output_fixedLong/RA_Rice_fixedlong_onset_medium_suppl_c.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_Rice_fixedlong_onset_medium_suppl <- r1
values(r1_Rice_fixedlong_onset_medium_suppl)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_Rice_fixedlong_onset_medium_suppl,par.settings=RdBuTheme(),margin=F, main="Rice:Onset medium supp more beneficial than fixed long strategy")

rice_onset_medium_supp=gplot(r1_Rice_fixedlong_onset_medium_suppl) +
  geom_raster(aes(fill = factor(value)))+
  scale_fill_manual(values = c("#F8766D","#619CFF", "#00BA38"),na.value = "transparent",labels=c("Clearly worse","Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="Rice:Onset, medium duration variety, supplemental irrigation",fill="Willingness to pay")
previous_theme <- theme_set(theme_bw())
rice_onset_medium_supp


ggsave("output/figures/rice_onset_medium_supp.png",dpi=300,width=6.88, height=4.16)






## Wheat ------------------------------------------------------------------------

### Fixed long versus farmer practice

m <- read.csv("data/maxwell_output_fixedLong/RA_Wheat_baseline_fixedlong_c.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_Wheat_fixedlong_farmer_practice <- r1
values(r1_Wheat_fixedlong_farmer_practice)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_Wheat_fixedlong_farmer_practice,par.settings=RdBuTheme(),margin=F, main="Wheat:Farmer practice more beneficial than fixed long strategy")


Wheat_farmer_practice=gplot(r1_Wheat_fixedlong_farmer_practice) +
  geom_raster(aes(fill = factor(value)))+
  scale_fill_manual(values = c("#F8766D","#619CFF", "#00BA38"),na.value = "transparent",labels=c("Clearly worse","Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="Wheat: Farmer practice",fill="Willingness to pay")
previous_theme <- theme_set(theme_bw())
Wheat_farmer_practice

ggsave("output/figures/Wheat_farmer_practice.png",dpi=300,width=6.88, height=4.16)






### Fixed long versus fixed medium 
m <- read.csv("data/maxwell_output_fixedLong/RA_Wheat_fixedlong_fixedmedium_c.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_Wheat_fixedlong_fixedmedium <- r1
values(r1_Wheat_fixedlong_fixedmedium)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_Wheat_fixedlong_fixedmedium,par.settings=RdBuTheme(),margin=F, main="Wheat:Fixed medium more beneficial than fixed long strategy")


Wheat_fixedmedium=gplot(r1_Wheat_fixedlong_fixedmedium) +
  geom_raster(aes(fill = factor(value)))+
  scale_fill_manual(values = c("#00BA38"),na.value = "transparent",labels=c("Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="Wheat: Fixed, medium duration variety rice planting strategy",fill="Willingness to pay")
previous_theme <- theme_set(theme_bw())
Wheat_fixedmedium

ggsave("output/figures/Wheat_fixedmedium.png",dpi=300,width=6.88, height=4.16)

# Fixed long versus onset 
m <- read.csv("data/maxwell_output_fixedLong/RA_Wheat_fixedlong_onset_long_c.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_Wheat_fixedlong_onset_long <- r1
values(r1_Wheat_fixedlong_onset_long)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_Wheat_fixedlong_onset_long,par.settings=RdBuTheme(),margin=F, main="Wheat:Onset long more beneficial than fixed long strategy")

Wheat_onset_long=gplot(r1_Wheat_fixedlong_onset_long) +
  geom_raster(aes(fill = factor(value)))+
  scale_fill_manual(values = c("#619CFF","#00BA38"),na.value = "transparent",labels=c("Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="Wheat:Onset, long duration variety rice planting strategy",fill="Willingness to pay")
previous_theme <- theme_set(theme_bw())
Wheat_onset_long

ggsave("output/figures/Wheat_onset_long.png",dpi=300,width=6.88, height=4.16)

# Fixed long versus onset long suppl
m <- read.csv("data/maxwell_output_fixedLong/RA_Wheat_fixedlong_onset_long_suppl_c.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_Wheat_fixedlong_onset_long_suppl <- r1
values(r1_Wheat_fixedlong_onset_long_suppl)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_Wheat_fixedlong_onset_long_suppl,par.settings=RdBuTheme(),margin=F, main="Wheat:Onset, long duration variety, supplemental irrigation")

Wheat_onset_long_supp=gplot(r1_Wheat_fixedlong_onset_long_suppl) +
  geom_raster(aes(fill = factor(value)))+
  scale_fill_manual(values = c("#F8766D","#619CFF", "#00BA38"),na.value = "transparent",labels=c("Clearly worse","Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="Wheat:Onset, long duration variety, supplemental irrigation rice planting",fill="Willingness to pay")
previous_theme <- theme_set(theme_bw())
Wheat_onset_long_supp

ggsave("output/figures/Wheat_onset_long_supp.png",dpi=300,width=6.88, height=4.16)


# Fixed long versus onset medium 
m <- read.csv("data/maxwell_output_fixedLong/RA_Wheat_fixedlong_onset_medium_c.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_Wheat_fixedlong_onset_medium <- r1
values(r1_Wheat_fixedlong_onset_medium)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_Wheat_fixedlong_onset_medium,par.settings=RdBuTheme(),margin=F, main="Wheat:Onset medium more beneficial than fixed long strategy")

Wheat_onset_medium=gplot(r1_Wheat_fixedlong_onset_medium) +
  geom_raster(aes(fill = factor(value)))+
  scale_fill_manual(values = c("#F8766D","#619CFF", "#00BA38"),na.value = "transparent",labels=c("Clearly worse","Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="Wheat:Onset, medium duration variety rice planting strategy",fill="Willingness to pay")
previous_theme <- theme_set(theme_bw())
Wheat_onset_medium

ggsave("output/figures/Wheat_onset_medium.png",dpi=300,width=6.88, height=4.16)

# Fixed long versus onset medium supp
m <- read.csv("data/maxwell_output_fixedLong/RA_Wheat_fixedlong_onset_medium_suppl_c.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_Wheat_fixedlong_onset_medium_suppl <- r1
values(r1_Wheat_fixedlong_onset_medium_suppl)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_Wheat_fixedlong_onset_medium_suppl,par.settings=RdBuTheme(),margin=F, main="Wheat:Onset medium supp more beneficial than fixed long strategy")

Wheat_onset_medium_supp=gplot(r1_Wheat_fixedlong_onset_medium_suppl) +
  geom_raster(aes(fill = factor(value)))+
  scale_fill_manual(values = c("#F8766D","#619CFF", "#00BA38"),na.value = "transparent",labels=c("Clearly worse","Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="Wheat:Onset, medium duration variety, supplemental irrigation rice planting",fill="Willingness to pay")
previous_theme <- theme_set(theme_bw())
Wheat_onset_medium_supp


ggsave("output/figures/Wheat_onset_medium_supp.png",dpi=300,width=6.88, height=4.16)


## Spatial system yield benefits -----------------------

### fixed long vs. fixed medium
m_Rice_fixedlong_fixedmedium <- read.csv("data/maxwell_output_fixedLong/RA_Rice_fixedlong_fixedmedium_c.csv")
m_Wheat_fixedlong_fixedmedium <- read.csv("data/maxwell_output_fixedLong/RA_Wheat_fixedlong_fixedmedium_c.csv")

colnames(m_Wheat_fixedlong_fixedmedium) <- paste("Wheat", colnames(m_Wheat_fixedlong_fixedmedium), sep = "_")
m_System_fixedlong_fixedmedium=bind_cols(m_Rice_fixedlong_fixedmedium,m_Wheat_fixedlong_fixedmedium)

m_System_fixedlong_fixedmedium$System_Riskiness_Comp=0

m_System_fixedlong_fixedmedium$System_Riskiness_Comp[m_System_fixedlong_fixedmedium$Riskiness_Comp==1 & 
                                                       m_System_fixedlong_fixedmedium$Wheat_Riskiness_Comp==1]=1
m_System_fixedlong_fixedmedium$System_Riskiness_Comp[m_System_fixedlong_fixedmedium$Riskiness_Comp==1 & 
                                                       m_System_fixedlong_fixedmedium$Wheat_Riskiness_Comp==0]=2
m_System_fixedlong_fixedmedium$System_Riskiness_Comp[m_System_fixedlong_fixedmedium$Riskiness_Comp==1 & 
                                                       m_System_fixedlong_fixedmedium$Wheat_Riskiness_Comp==-1]=3
m_System_fixedlong_fixedmedium$System_Riskiness_Comp[m_System_fixedlong_fixedmedium$Riskiness_Comp==0 & 
                                                       m_System_fixedlong_fixedmedium$Wheat_Riskiness_Comp==1]=4
m_System_fixedlong_fixedmedium$System_Riskiness_Comp[m_System_fixedlong_fixedmedium$Riskiness_Comp==0 & 
                                                       m_System_fixedlong_fixedmedium$Wheat_Riskiness_Comp==0]=5
m_System_fixedlong_fixedmedium$System_Riskiness_Comp[m_System_fixedlong_fixedmedium$Riskiness_Comp==0 & 
                                                       m_System_fixedlong_fixedmedium$Wheat_Riskiness_Comp==-1]=6
m_System_fixedlong_fixedmedium$System_Riskiness_Comp[m_System_fixedlong_fixedmedium$Riskiness_Comp==-1 & 
                                                       m_System_fixedlong_fixedmedium$Wheat_Riskiness_Comp==1]=7
m_System_fixedlong_fixedmedium$System_Riskiness_Comp[m_System_fixedlong_fixedmedium$Riskiness_Comp==-1 & 
                                                       m_System_fixedlong_fixedmedium$Wheat_Riskiness_Comp==0]=8
m_System_fixedlong_fixedmedium$System_Riskiness_Comp[m_System_fixedlong_fixedmedium$Riskiness_Comp==-1 & 
                                                       m_System_fixedlong_fixedmedium$Wheat_Riskiness_Comp==-1]=9


v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_System_fixedlong_fixedmedium <- r1
values(r1_System_fixedlong_fixedmedium )[t]<- m_System_fixedlong_fixedmedium$System_Riskiness_Comp
library(rasterVis)
levelplot(r1_System_fixedlong_fixedmedium ,par.settings=RdBuTheme(),margin=F, main="System:Fixed medium more beneficial than fixed long strategy")








levelplot(r1_System_fixedlong_fixedmedium,par.settings=RdBuTheme(),margin=F, main="System:Fixed medium more beneficial than fixed long strategy")

System_fixedmedium=gplot(r1_System_fixedlong_fixedmedium) +
  geom_raster(aes(fill = factor(value)))+
  scale_fill_manual(values = c("#619CFF","#00BA38"),na.value = "transparent",labels=c("Rice only","Both rice and wheat",""))+
  labs(x="Longitude",y="Latitude",title="System: Fixed, medium duration variety rice planting strategy",fill="Crop with clear benefits")
previous_theme <- theme_set(theme_bw())
System_fixedmedium

ggsave("output/figures/System_fixedmedium.png",dpi=300,width=6.88, height=4.16)

### fixed long vs. onset long
r1_System_fixedlong_onset_long=r1_Wheat_fixedlong_onset_long+r1_Rice_fixedlong_onset_long

levelplot(r1_System_fixedlong_onset_long,par.settings=RdBuTheme(),margin=F, main="System:Onset long more beneficial than fixed long strategy")

System_fixedmedium=gplot(r1_System_fixedlong_onset_long) +
  geom_raster(aes(fill = factor(value)))+
  scale_fill_manual(values = c("#619CFF","#00BA38"),na.value = "transparent",labels=c("Rice only","Both rice and wheat",""))+
  labs(x="Longitude",y="Latitude",title="System: Fixed, medium duration variety rice planting strategy",fill="Crop with clear benefits")
previous_theme <- theme_set(theme_bw())
System_fixedmedium

ggsave("output/figures/System_fixedmedium.png",dpi=300,width=6.88, height=4.16)




