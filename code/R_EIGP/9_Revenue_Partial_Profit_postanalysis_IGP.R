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

### Fixed long versus farmer practice -------------------
m <- read.csv("data/maxwell_output_fixedLong_revenue_IGP/RA_rice_wheat_farmer_practice_fixedlong_rev_IGP.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_RA_rice_wheat_rev_farmer_practice_fixedlong_c<- r1

values(r1_RA_rice_wheat_rev_farmer_practice_fixedlong_c)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_RA_rice_wheat_rev_farmer_practice_fixedlong_c,par.settings=RdBuTheme(),margin=F, main="Rice-Wheat Revenue:Farmer practice more beneficial than fixed long strategy")


rice_wheat_farmer_practice_rev=gplot(r1_RA_rice_wheat_rev_farmer_practice_fixedlong_c) +
  geom_raster(aes(fill = factor(value)), show.legend = FALSE)+
  scale_fill_manual(values = c("#F8766D","#619CFF", "#00BA38"),na.value = "transparent",labels=c("Clearly worse","Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="Rice-Wheat:S0-S1",fill="Willingness to pay")
previous_theme <- theme_set(theme_bw(base_size = 16))
rice_wheat_farmer_practice_rev

ggsave("output/figures_IGP_IGP/rice_wheat_farmer_practice_rev_IGP.png",dpi=300,width=3.88, height=3.16)


# Fixed long versus fixed medium -----------------------------
m <- read.csv("data/maxwell_output_fixedLong_revenue_IGP/RA_rice_wheat_fixedlong_fixedmedium_rev_IGP.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_RA_rice_wheat_rev_fixed_medium_fixedlong_c<- r1

values(r1_RA_rice_wheat_rev_fixed_medium_fixedlong_c)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_RA_rice_wheat_rev_fixed_medium_fixedlong_c,par.settings=RdBuTheme(),margin=F, main="Rice-Wheat Revenue:Fixed medium more beneficial than fixed long strategy")


rice_wheat_fixed_medium_rev=gplot(r1_RA_rice_wheat_rev_fixed_medium_fixedlong_c) +
  geom_raster(aes(fill = factor(value)), show.legend = FALSE)+
  scale_fill_manual(values = c("#F8766D","#619CFF", "#00BA38"),na.value = "transparent",labels=c("Clearly worse","Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="Rice-wheat: S2-S1",fill="Willingness to pay")
previous_theme <- theme_set(theme_bw(base_size = 16))
rice_wheat_fixed_medium_rev

ggsave("output/figures_IGP_IGP/rice_wheat_fixed_medium_rev_IGP.png",dpi=300,width=3.88, height=3.16)


# Fixed long versus onset  -------------------------------------
m <- read.csv("data/maxwell_output_fixedLong_revenue_IGP/RA_rice_wheat_fixedlong_onset_long_rev_IGP.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_RA_rice_wheat_rev_onset_long_fixedlong_c<- r1

values(r1_RA_rice_wheat_rev_onset_long_fixedlong_c)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_RA_rice_wheat_rev_onset_long_fixedlong_c,par.settings=RdBuTheme(),margin=F, main="Rice-Wheat Revenue:Onset long more beneficial than fixed long strategy")


rice_wheat_onset_long_rev=gplot(r1_RA_rice_wheat_rev_onset_long_fixedlong_c) +
  geom_raster(aes(fill = factor(value)), show.legend = FALSE)+
  scale_fill_manual(values = c("#F8766D","#619CFF", "#00BA38"),na.value = "transparent",labels=c("Clearly worse","Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="Rice-wheat:S3-S1",fill="Willingness to pay")
previous_theme <- theme_set(theme_bw(base_size = 16))
rice_wheat_onset_long_rev

ggsave("output/figures_IGP_IGP/rice_wheat_onset_long_rev_IGP.png",dpi=300,width=3.88, height=3.16)


# Upper bound ------------
r1_RA_rice_wheat_rev_onset_long_fixedlong_c_WTP_Up<- r1

values(r1_RA_rice_wheat_rev_onset_long_fixedlong_c_WTP_Up)[t]<- m$BaseMinPropSOSDComp*-1
library(rasterVis)
UpperWTP_riceonsetlong=levelplot(r1_RA_rice_wheat_rev_onset_long_fixedlong_c_WTP_Up,par.settings=RdBuTheme(),
          margin=F, contour = TRUE, main="Upper WTP (Rs./ha) bound for rice onset long")

UpperWTP_riceonsetlong

png("output/figures_IGP_IGP/UpperWTP_riceonsetlong_IGP.png")
UpperWTP_riceonsetlong
dev.off()
# Lower bound ---------
r1_RA_rice_wheat_rev_onset_long_fixedlong_c_WTP_low<- r1

values(r1_RA_rice_wheat_rev_onset_long_fixedlong_c_WTP_low)[t]<- m$CompMinPropSOSDBase*-1
library(rasterVis)
LowerWTP_riceonsetlong=levelplot(r1_RA_rice_wheat_rev_onset_long_fixedlong_c_WTP_low,par.settings=RdBuTheme(),
          margin=F, contour = TRUE, main="Lower WTP (Rs./ha) bound for rice onset long")
LowerWTP_riceonsetlong

png("output/figures_IGP_IGP/LowerWTP_riceonsetlong_IGP.png")
LowerWTP_riceonsetlong
dev.off()


# # Fixed long versus onset medium ------------------
m <- read.csv("data/maxwell_output_fixedLong_revenue_IGP/RA_rice_wheat_fixedlong_onset_medium_rev_IGP.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_RA_rice_wheat_rev_onset_medium_fixedlong_c<- r1

values(r1_RA_rice_wheat_rev_onset_medium_fixedlong_c)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_RA_rice_wheat_rev_onset_medium_fixedlong_c,par.settings=RdBuTheme(),margin=F, main="Rice-Wheat Revenue:Onset medium more beneficial than fixed long strategy")


rice_wheat_onset_medium_rev=gplot(r1_RA_rice_wheat_rev_onset_medium_fixedlong_c) +
  geom_raster(aes(fill = factor(value)), show.legend = FALSE)+
  scale_fill_manual(values = c("#F8766D","#619CFF", "#00BA38"),na.value = "transparent",labels=c("Clearly worse","Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="Rice-wheat: S5-S1",fill="Willingness to pay")
previous_theme <- theme_set(theme_bw(base_size = 16))
rice_wheat_onset_medium_rev

ggsave("output/figures_IGP_IGP/rice_wheat_onset_medium_rev_IGP.png",dpi=300,width=3.88, height=3.16)


# Fixed long versus onset_long_suppl ----------------------------
m <- read.csv("data/maxwell_output_fixedLong_revenue_IGP/RA_rice_wheat_fixedlong_onset_long_suppl_rev_IGP.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_RA_rice_wheat_rev_onset_long_suppl_fixedlong_c<- r1

values(r1_RA_rice_wheat_rev_onset_long_suppl_fixedlong_c)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_RA_rice_wheat_rev_onset_long_suppl_fixedlong_c,par.settings=RdBuTheme(),margin=F, main="Rice-Wheat Revenue:Onset long suppl more beneficial than fixed long strategy")


rice_wheat_onset_long_suppl_rev=gplot(r1_RA_rice_wheat_rev_onset_long_suppl_fixedlong_c) +
  geom_raster(aes(fill = factor(value)), show.legend = FALSE)+
  scale_fill_manual(values = c("#F8766D","#619CFF", "#00BA38"),na.value = "transparent",labels=c("Clearly worse","Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="Rice-wheat: S4-S1",fill="Willingness to pay")
previous_theme <- theme_set(theme_bw(base_size = 16))
rice_wheat_onset_long_suppl_rev

ggsave("output/figures_IGP_IGP/rice_wheat_onset_long_suppl_rev_IGP.png",dpi=300,width=3.88, height=3.16)


# Fixed long versus onset medium suppl ------------------
m <- read.csv("data/maxwell_output_fixedLong_revenue_IGP/RA_rice_wheat_fixedlong_onset_medium_suppl_rev_IGP.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_RA_rice_wheat_rev_onset_medium_supp_fixedlong_c<- r1

values(r1_RA_rice_wheat_rev_onset_medium_supp_fixedlong_c)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_RA_rice_wheat_rev_onset_medium_supp_fixedlong_c,par.settings=RdBuTheme(),margin=F, main="Rice-Wheat Revenue:Onset medium suppl more beneficial than fixed long strategy")


rice_wheat_onset_medium_supp_rev=gplot(r1_RA_rice_wheat_rev_onset_medium_supp_fixedlong_c) +
  geom_raster(aes(fill = factor(value)))+
  theme(legend.position="bottom")
  scale_fill_manual(values = c("#F8766D","#619CFF", "#00BA38"),na.value = "transparent",labels=c("Clearly worse","Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="Rice-Wheat: S6-S1",fill="Willingness to pay")
previous_theme <- theme_set(theme_bw(base_size = 16))
rice_wheat_onset_medium_supp_rev

ggsave("output/figures_IGP_IGP/rice_wheat_onset_medium_supp_rev_IGP.png",dpi=300,width=3.88, height=3.16)


library(cowplot)

rice_wheat_onset_medium_supp_rev=gplot(r1_RA_rice_wheat_rev_onset_medium_supp_fixedlong_c) +
  geom_raster(aes(fill = factor(value)))+
  theme(legend.position="bottom")+
scale_fill_manual(values = c("#F8766D","#619CFF", "#00BA38"),na.value = "transparent",labels=c("Clearly worse","Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="Rice-Wheat: S6-S1",fill="Willingness to pay")
previous_theme <- theme_set(theme_bw(base_size = 16))
rice_wheat_onset_medium_supp_rev







#PARTIAL PROFIT -----------------------------
m <- read.csv("data/maxwell_output_fixedLong_prof_IGP/RA_rice_wheat_farmer_practice_fixedlong_prof_IGP.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_RA_rice_wheat_pprof_farmer_practice_fixedlong_c<- r1

values(r1_RA_rice_wheat_pprof_farmer_practice_fixedlong_c)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_RA_rice_wheat_pprof_farmer_practice_fixedlong_c,par.settings=RdBuTheme(),margin=F, main="Rice-Wheat pprofenue:Farmer practice more beneficial than fixed long strategy")


rice_wheat_farmer_practice_pprof=gplot(r1_RA_rice_wheat_pprof_farmer_practice_fixedlong_c) +
  geom_raster(aes(fill = factor(value)), show.legend = FALSE)+
  scale_fill_manual(values = c("#F8766D","#619CFF", "#00BA38"),na.value = "transparent",labels=c("Clearly worse","Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="S0-S1",fill="Willingness to pay")
ppprofious_theme <- theme_set(theme_bw(base_size = 16))
rice_wheat_farmer_practice_pprof

ggsave("output/figures_IGP/rice_wheat_farmer_practice_pprof_IGP.png",dpi=300,width=3.88, height=3.16)

#
### Fixed long versus fixed medium -----------------------------
m <- read.csv("data/maxwell_output_fixedLong_prof_IGP/RA_rice_wheat_fixedlong_fixedmedium_prof_IGP.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_RA_rice_wheat_pprof_fixed_medium_fixedlong_c<- r1

values(r1_RA_rice_wheat_pprof_fixed_medium_fixedlong_c)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_RA_rice_wheat_pprof_fixed_medium_fixedlong_c,par.settings=RdBuTheme(),margin=F, main="Rice-Wheat pprofenue:Fixed medium more beneficial than fixed long strategy")


rice_wheat_fixed_medium_pprof=gplot(r1_RA_rice_wheat_pprof_fixed_medium_fixedlong_c) +
  geom_raster(aes(fill = factor(value)), show.legend = FALSE)+
  scale_fill_manual(values = c("#F8766D","#619CFF", "#00BA38"),na.value = "transparent",labels=c("Clearly worse","Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="S2-S1",fill="Willingness to pay")
ppprofious_theme <- theme_set(theme_bw(base_size = 16))
rice_wheat_fixed_medium_pprof

ggsave("output/figures_IGP/rice_wheat_fixed_medium_pprof_IGP.png",dpi=300,width=3.88, height=3.16)

### Fixed long versus onset  -------------------------------------
m <- read.csv("data/maxwell_output_fixedLong_prof_IGP/RA_rice_wheat_fixedlong_onset_long_prof_IGP.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_RA_rice_wheat_pprof_onset_long_fixedlong_c<- r1

values(r1_RA_rice_wheat_pprof_onset_long_fixedlong_c)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_RA_rice_wheat_pprof_onset_long_fixedlong_c,par.settings=RdBuTheme(),margin=F, main="Rice-Wheat pprofenue:Onset long more beneficial than fixed long strategy")


rice_wheat_onset_long_pprof=gplot(r1_RA_rice_wheat_pprof_onset_long_fixedlong_c) +
  geom_raster(aes(fill = factor(value)), show.legend = FALSE)+
  scale_fill_manual(values = c("#F8766D","#619CFF", "#00BA38"),na.value = "transparent",labels=c("Clearly worse","Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="S3-S1",fill="Willingness to pay")
ppprofious_theme <- theme_set(theme_bw(base_size = 16))
rice_wheat_onset_long_pprof

ggsave("output/figures_IGP/rice_wheat_onset_long_prof_IGP.png",dpi=300,width=3.88, height=3.16)


r1_RA_rice_wheat_pprof_onset_long_fixedlong_c_WTP_Up<- r1

values(r1_RA_rice_wheat_pprof_onset_long_fixedlong_c_WTP_Up)[t]<- m$BaseMinPropSOSDComp*-1
library(rasterVis)
UpperWTP_riceonsetlong_prof=levelplot(r1_RA_rice_wheat_pprof_onset_long_fixedlong_c_WTP_Up,par.settings=RdBuTheme(),
                                      margin=F, contour = TRUE, main="Upper WTP (Rs./ha)")

UpperWTP_riceonsetlong_prof

png("output/figures_IGP/UpperWTP_riceonsetlong_prof_IGP.png",pointsize = 30,width = 380, height = 380)
UpperWTP_riceonsetlong_prof
dev.off()

UpperWTP_riceonsetlong_prof_usd=levelplot(r1_RA_rice_wheat_pprof_onset_long_fixedlong_c_WTP_Up/80,par.settings=RdBuTheme(),
                                      margin=F, contour = TRUE, main="Upper WTP (US$/ha) bound")

UpperWTP_riceonsetlong_prof_usd

png("output/figures_IGP/UpperWTP_riceonsetlong_prof_IGP_usd.png",pointsize = 30,width = 380, height = 380)
UpperWTP_riceonsetlong_prof_usd
dev.off()

# Lower bound ---------
r1_RA_rice_wheat_pprof_onset_long_fixedlong_c_WTP_low<- r1

values(r1_RA_rice_wheat_pprof_onset_long_fixedlong_c_WTP_low)[t]<- m$CompMinPropSOSDBase*-1
library(rasterVis)
LowerWTP_riceonsetlong_prof=levelplot(r1_RA_rice_wheat_pprof_onset_long_fixedlong_c_WTP_low,par.settings=RdBuTheme(),
                                      margin=F, contour = TRUE, main="Lower WTP (Rs./ha) bound")
LowerWTP_riceonsetlong_prof
png("output/figures_IGP/LowerWTP_riceonsetlong_prof_IGP.png",pointsize = 30,width = 380, height = 380)
LowerWTP_riceonsetlong_prof
dev.off()


LowerWTP_riceonsetlong_prof_usd=levelplot(r1_RA_rice_wheat_pprof_onset_long_fixedlong_c_WTP_low/80,par.settings=RdBuTheme(),
                                      margin=F, contour = TRUE, main="Lower WTP (US$/ha) bound for rice onset long")
LowerWTP_riceonsetlong_prof_usd
png("output/figures_IGP/LowerWTP_riceonsetlong_prof_IGP_usd.png",pointsize = 30,width = 380, height = 380)
LowerWTP_riceonsetlong_prof_usd
dev.off()




### Fixed long versus onset_long_suppl ----------------------------
m <- read.csv("data/maxwell_output_fixedLong_prof_IGP/RA_rice_wheat_fixedlong_onset_long_suppl_prof_IGP.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_RA_rice_wheat_pprof_onset_long_suppl_fixedlong_c<- r1

values(r1_RA_rice_wheat_pprof_onset_long_suppl_fixedlong_c)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_RA_rice_wheat_pprof_onset_long_suppl_fixedlong_c,par.settings=RdBuTheme(),margin=F, main="Rice-Wheat profit :Onset long suppl more beneficial than fixed long strategy")


rice_wheat_onset_long_suppl_pprof=gplot(r1_RA_rice_wheat_pprof_onset_long_suppl_fixedlong_c) +
  geom_raster(aes(fill = factor(value)), show.legend = FALSE)+
  scale_fill_manual(values = c("#F8766D","#619CFF", "#00BA38"),na.value = "transparent",labels=c("Clearly worse","Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="S4-S1",fill="Willingness to pay")
ppprofious_theme <- theme_set(theme_bw(base_size = 16))
rice_wheat_onset_long_suppl_pprof

ggsave("output/figures_IGP/rice_wheat_onset_long_suppl_pprof_IGP.png",dpi=300,width=3.88, height=3.16)

### Fixed long versus onset medium ------------------
m <- read.csv("data/maxwell_output_fixedLong_prof_IGP/RA_rice_wheat_fixedlong_onset_medium_prof_IGP.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_RA_rice_wheat_pprof_onset_medium_fixedlong_c<- r1

values(r1_RA_rice_wheat_pprof_onset_medium_fixedlong_c)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_RA_rice_wheat_pprof_onset_medium_fixedlong_c,par.settings=RdBuTheme(),margin=F, main="Rice-Wheat profit:Onset medium more beneficial than fixed long strategy")


rice_wheat_onset_medium_pprof=gplot(r1_RA_rice_wheat_pprof_onset_medium_fixedlong_c) +
  geom_raster(aes(fill = factor(value)), show.legend = FALSE)+
  scale_fill_manual(values = c("#F8766D","#619CFF", "#00BA38"),na.value = "transparent",labels=c("Clearly worse","Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="S5-S1",fill="Willingness to pay")
ppprofious_theme <- theme_set(theme_bw(base_size = 16))
rice_wheat_onset_medium_pprof

ggsave("output/figures_IGP/rice_wheat_onset_medium_pprof_IGP.png",dpi=300,width=3.88, height=3.16)

## Fixed long versus onset medium suppl ------------------
m <- read.csv("data/maxwell_output_fixedLong_prof_IGP/RA_rice_wheat_fixedlong_onset_medium_suppl_prof_IGP.csv")

v <- as.vector(getValues(r1))
t <- which(!is.na(v))

r1_RA_rice_wheat_pprof_onset_medium_supp_fixedlong_c<- r1

values(r1_RA_rice_wheat_pprof_onset_medium_supp_fixedlong_c)[t]<- m$Riskiness_Comp
library(rasterVis)
levelplot(r1_RA_rice_wheat_pprof_onset_medium_supp_fixedlong_c,par.settings=RdBuTheme(),margin=F, main="Rice-Wheat profit:Onset medium suppl more beneficial than fixed long strategy")


rice_wheat_onset_medium_supp_pprof=gplot(r1_RA_rice_wheat_pprof_onset_medium_supp_fixedlong_c) +
  geom_raster(aes(fill = factor(value)), show.legend = FALSE)+
  scale_fill_manual(values = c("#F8766D","#619CFF", "#00BA38"),na.value = "transparent",labels=c("Clearly worse","Better or worse","Clearly better",""))+
  labs(x="Longitude",y="Latitude",title="S6-S1",fill="Willingness to pay")
ppprofious_theme <- theme_set(theme_bw(base_size = 16))
rice_wheat_onset_medium_supp_pprof

ggsave("output/figures_IGP/rice_wheat_onset_medium_supp_pprof_IGP.png",dpi=300,width=3.88, height=3.16)


