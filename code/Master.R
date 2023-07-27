# Run the following code chronologically 
# install.packages("pacman")
pacman::p_load(stringr, readxl, lubridate, readr, MASS, copula, gridExtra, ggpubr, fdrtool, dplyr, ggplot2, rootSolve)


#Set working directory
setwd("##INPUT##")

# Bihar Models
#Create Figure 1
source("code/R_Bihar/1_WTP_fixedlongasbaseline_Bihar.R")

#Creates Figures 2-3
source("Code/.R")

#Creates Figures 4-5, A1
source("Code/.R")

#Creates Figures 7-8
source("Code/.R")

#Creates Figures 9 
source("Code/HMS_AJAE_PolicySim4.R")

# IGP Models