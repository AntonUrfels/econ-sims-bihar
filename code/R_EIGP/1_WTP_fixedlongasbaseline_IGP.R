
# packages ---------------------------------------------------------------------
library(dplyr)
library(data.table)
library(tidyr)
library(rio)


# RICE--------------------------------------------------------------------------

## RICE-- Fixed long ---------------------------------------
rice_fixed_long=read.csv("output/rice_fixed_long_IGP.csv")
rice_fixed_long <- na_if(rice_fixed_long, '-99')  #Replace all -99 with NA
rice_fixed_long <- na_if(rice_fixed_long, '-999999')
rice_fixed_long=rename(rice_fixed_long,ID=X)

rice_fixed_long$rice_area=rep(1,nrow(rice_fixed_long))


rice_fixed_long_long <- melt(setDT(rice_fixed_long), id.vars = c("ID","rice_area"),value.name=c("fixed_long_rice_yield") ,variable.name = "year")

rice_fixed_long_long$year=as.numeric(gsub('[^0-9]', '',rice_fixed_long_long$year))

## RICE-- Baseline ---------------------------
rice_baseline=read.csv("output/rice_baseline_IGP.csv")
rice_baseline <- na_if(rice_baseline, '-99')  #Replace all -99 with NA
rice_baseline <- na_if(rice_baseline, '-999999')
rice_baseline=rename(rice_baseline,ID=X)
rice_baseline_long <- melt(setDT(rice_baseline), id.vars = c("ID"),value.name=c("baseline_rice_yield") ,variable.name = "year")
rice_baseline_long$year=as.numeric(gsub('[^0-9]', '',rice_baseline_long$year))

rice_baseline_fixedlong=merge(rice_fixed_long_long,rice_baseline_long,by=c("ID","year"))
rice_baseline_fixedlong$year=rice_baseline_fixedlong$year-1982

rice_baseline_fixedlong$baseline_rice_yield[is.na(rice_baseline_fixedlong$baseline_rice_yield)]=0
rice_baseline_fixedlong$fixed_long_rice_yield[is.na(rice_baseline_fixedlong$fixed_long_rice_yield)]=0

rice_baseline_fixedlong=rice_baseline_fixedlong[,c(1,2,3,5,4)]

export(rice_baseline_fixedlong,colNames=F,"code/Octave_EIGP/rice_baseline_fixedlong_IGP.xlsx")



## RICE-- fixed medium -------------------------------------------------
rice_fixed_medium=read.csv("output/rice_fixed_medium_IGP.csv")
rice_fixed_medium <- na_if(rice_fixed_medium, '-99')  #Replace all -99 with NA
rice_fixed_medium <- na_if(rice_fixed_medium, '-999999')  #Replace all -99 with NA
rice_fixed_medium=rename(rice_fixed_medium,ID=X)
rice_fixed_medium_long <- melt(setDT(rice_fixed_medium), id.vars = c("ID"),value.name=c("fixedmedium_rice_yield") ,variable.name = "year")
rice_fixed_medium_long$year=as.numeric(gsub('[^0-9]', '',rice_fixed_medium_long$year))

rice_fixedlong_fixedmedium=merge(rice_fixed_long_long,rice_fixed_medium_long,by=c("ID","year"))
rice_fixedlong_fixedmedium$year=rice_fixedlong_fixedmedium$year-1982

rice_fixedlong_fixedmedium$fixed_long_rice_yield[is.na(rice_fixedlong_fixedmedium$fixed_long_rice_yield)]=0
rice_fixedlong_fixedmedium$fixedmedium_rice_yield[is.na(rice_fixedlong_fixedmedium$fixedmedium_rice_yield)]=0

rice_fixedlong_fixedmedium=rice_fixedlong_fixedmedium[,c(1,2,3,5,4)]

export(rice_fixedlong_fixedmedium,colNames=F,"code/Octave_EIGP/rice_fixedlong_fixedmedium_IGP.xlsx")


## RICE-- On set long -----------------------------------------------------------------------------------------
rice_onset_long=read.csv("output/rice_onset_long_IGP.csv")
rice_onset_long <- na_if(rice_onset_long, '-99')  #Replace all -99 with NA
rice_onset_long <- na_if(rice_onset_long, '-999999')  #Replace all -99 with NA
rice_onset_long=rename(rice_onset_long,ID=X)
rice_onset_long_long <- melt(setDT(rice_onset_long), id.vars = c("ID"),value.name=c("onset_long_rice_yield") ,variable.name = "year")
rice_onset_long_long$year=as.numeric(gsub('[^0-9]', '',rice_onset_long_long$year))

rice_fixedlong_onset_long=merge(rice_fixed_long_long,rice_onset_long_long,by=c("ID","year"))
rice_fixedlong_onset_long$year=rice_fixedlong_onset_long$year-1982

rice_fixedlong_onset_long$fixedlong_rice_yield[is.na(rice_fixedlong_onset_long$fixed_long_rice_yield)]=0
rice_fixedlong_onset_long$onset_long_rice_yield[is.na(rice_fixedlong_onset_long$onset_long_rice_yield)]=0

rice_fixedlong_onset_long=rice_fixedlong_onset_long[,c(1,2,3,5,4)]

export(rice_fixedlong_onset_long,colNames=F,"code/Octave_EIGP/rice_fixedlong_onset_long_IGP.xlsx")


## RICE-- Onset medium -----------------------------------------------------------------------------------
rice_onset_medium=read.csv("output/rice_onset_medium_IGP.csv")
rice_onset_medium <- na_if(rice_onset_medium, '-99')  #Replace all -99 with NA
rice_onset_medium <- na_if(rice_onset_medium, '-999999')  #Replace all -99 with NA
rice_onset_medium=rename(rice_onset_medium,ID=X)
rice_onset_medium_long <- melt(setDT(rice_onset_medium), id.vars = c("ID"),value.name=c("onset_medium_rice_yield") ,variable.name = "year")
rice_onset_medium_long$year=as.numeric(gsub('[^0-9]', '',rice_onset_medium_long$year))

rice_fixedlong_onset_medium=merge(rice_fixed_long_long,rice_onset_medium_long,by=c("ID","year"))
rice_fixedlong_onset_medium$year=rice_fixedlong_onset_medium$year-1982

rice_fixedlong_onset_medium$fixedlong_rice_yield[is.na(rice_fixedlong_onset_medium$fixed_long_rice_yield)]=0
rice_fixedlong_onset_medium$onset_medium_rice_yield[is.na(rice_fixedlong_onset_medium$onset_medium_rice_yield)]=0

rice_fixedlong_onset_medium=rice_fixedlong_onset_medium[,c(1,2,3,5,4)]

export(rice_fixedlong_onset_medium,colNames=F,"code/Octave_EIGP/rice_fixedlong_onset_medium_IGP.xlsx")

## RICE-- onset long suppl --------------------------------------------------------------------------
rice_onset_long_suppl=read.csv("output/rice_onset_long_suppl_IGP.csv")
rice_onset_long_suppl <- na_if(rice_onset_long_suppl, '-99')  #Replace all -99 with NA
rice_onset_long_suppl <- na_if(rice_onset_long_suppl, '-999999')  #Replace all -99 with NA
rice_onset_long_suppl=rename(rice_onset_long_suppl,ID=X)
rice_onset_long_suppl_long <- melt(setDT(rice_onset_long_suppl), id.vars = c("ID"),value.name=c("onset_long_suppl_rice_yield") ,variable.name = "year")
rice_onset_long_suppl_long$year=as.numeric(gsub('[^0-9]', '',rice_onset_long_suppl_long$year))

rice_fixedlong_onset_long_suppl=merge(rice_fixed_long_long,rice_onset_long_suppl_long,by=c("ID","year"))
rice_fixedlong_onset_long_suppl$year=rice_fixedlong_onset_long_suppl$year-1982

rice_fixedlong_onset_long_suppl$fixedlong_rice_yield[is.na(rice_fixedlong_onset_long_suppl$fixedlong_rice_yield)]=0
rice_fixedlong_onset_long_suppl$onset_long_suppl_rice_yield[is.na(rice_fixedlong_onset_long_suppl$onset_long_suppl_rice_yield)]=0

rice_fixedlong_onset_long_suppl=rice_fixedlong_onset_long_suppl[,c(1,2,3,5,4)]


export(rice_fixedlong_onset_long_suppl,colNames=F,"code/Octave_EIGP/rice_fixedlong_onset_long_suppl_IGP.xlsx")

## RICE-- onset medium suppl --------------------------------------------------------------------------
rice_onset_medium_suppl=read.csv("output/rice_onset_medium_suppl_IGP.csv")
rice_onset_medium_suppl <- na_if(rice_onset_medium_suppl, '-99')  #Replace all -99 with NA
rice_onset_medium_suppl <- na_if(rice_onset_medium_suppl, '-999999')  #Replace all -99 with NA
rice_onset_medium_suppl=rename(rice_onset_medium_suppl,ID=X)
rice_onset_medium_suppl_long <- melt(setDT(rice_onset_medium_suppl), id.vars = c("ID"),value.name=c("onset_medium_suppl_rice_yield") ,variable.name = "year")
rice_onset_medium_suppl_long$year=as.numeric(gsub('[^0-9]', '',rice_onset_medium_suppl_long$year))

rice_fixedlong_onset_medium_suppl=merge(rice_fixed_long_long,rice_onset_medium_suppl_long,by=c("ID","year"))
rice_fixedlong_onset_medium_suppl$year=rice_fixedlong_onset_medium_suppl$year-1982

rice_fixedlong_onset_medium_suppl$fixedlong_rice_yield[is.na(rice_fixedlong_onset_medium_suppl$fixedlong_rice_yield)]=0
rice_fixedlong_onset_medium_suppl$onset_medium_suppl_rice_yield[is.na(rice_fixedlong_onset_medium_suppl$onset_medium_suppl_rice_yield)]=0

rice_fixedlong_onset_medium_suppl=rice_fixedlong_onset_medium_suppl[,c(1,2,3,5,4)]


export(rice_fixedlong_onset_medium_suppl,colNames=F,"code/Octave_EIGP/rice_fixedlong_onset_medium_suppl_IGP.xlsx")


# WHEAT ---------------------------------------------------------------------------------------------------
## wheat-- fixedlong ---------------------------------------
wheat_fixedlong=read.csv("output/wheat_fixed_long_IGP.csv")
wheat_fixedlong <- na_if(wheat_fixedlong, '-99')  #Replace all -99 with NA
wheat_fixedlong <- na_if(wheat_fixedlong, '-999999')  #Replace all -99 with NA
wheat_fixedlong=rename(wheat_fixedlong,ID=X)

wheat_fixedlong$wheat_area=rep(1,nrow(wheat_fixedlong))


wheat_fixedlong_long <- melt(setDT(wheat_fixedlong), id.vars = c("ID","wheat_area"),value.name=c("fixedlong_wheat_yield") ,variable.name = "year")

wheat_fixedlong_long$year=as.numeric(gsub('[^0-9]', '',wheat_fixedlong_long$year))


## wheat-- Baseline ---------------------------
wheat_baseline=read.csv("output/wheat_baseline_IGP.csv")
wheat_baseline <- na_if(wheat_baseline, '-99')  #Replace all -99 with NA
wheat_baseline <- na_if(wheat_baseline, '-999999')  #Replace all -99 with NA
wheat_baseline=rename(wheat_baseline,ID=X)
wheat_baseline_long <- melt(setDT(wheat_baseline), id.vars = c("ID"),value.name=c("baseline_wheat_yield") ,variable.name = "year")
wheat_baseline_long$year=as.numeric(gsub('[^0-9]', '',wheat_baseline_long$year))

wheat_baseline_long=merge(wheat_fixedlong_long,wheat_baseline_long,by=c("ID","year"))
wheat_baseline_long$year=wheat_baseline_long$year-1982

wheat_baseline_long$baseline_wheat_yield[is.na(wheat_baseline_long$baseline_wheat_yield)]=0
wheat_baseline_long$baseline_wheat_yield[is.na(wheat_baseline_long$baseline_wheat_yield)]=0

wheat_baseline_long=wheat_baseline_long[,c(1,2,3,5,4)]

export(wheat_baseline_long,colNames=F,"code/Octave_EIGP/wheat_baseline_long_IGP.xlsx")





## wheat-- fixed medium -------------------------------------------------
wheat_fixed_medium=read.csv("output/wheat_fixed_medium_IGP.csv")
wheat_fixed_medium <- na_if(wheat_fixed_medium, '-99')  #Replace all -99 with NA
wheat_fixed_medium <- na_if(wheat_fixed_medium, '-999999')  #Replace all -99 with NA
wheat_fixed_medium=rename(wheat_fixed_medium,ID=X)
wheat_fixed_medium_long <- melt(setDT(wheat_fixed_medium), id.vars = c("ID"),value.name=c("fixedmedium_wheat_yield") ,variable.name = "year")
wheat_fixed_medium_long$year=as.numeric(gsub('[^0-9]', '',wheat_fixed_medium_long$year))

wheat_fixedlong_fixedmedium=merge(wheat_fixedlong_long,wheat_fixed_medium_long,by=c("ID","year"))
wheat_fixedlong_fixedmedium$year=wheat_fixedlong_fixedmedium$year-1982

wheat_fixedlong_fixedmedium$fixedlong_wheat_yield[is.na(wheat_fixedlong_fixedmedium$fixedlong_wheat_yield)]=0
wheat_fixedlong_fixedmedium$fixedmedium_wheat_yield[is.na(wheat_fixedlong_fixedmedium$fixedmedium_wheat_yield)]=0

wheat_fixedlong_fixedmedium=wheat_fixedlong_fixedmedium[,c(1,2,3,5,4)]


export(wheat_fixedlong_fixedmedium,colNames=F,"code/Octave_EIGP/wheat_fixedlong_fixedmedium_IGP.xlsx")


## wheat-- On set long -----------------------------------------------------------------------------------------
wheat_onset_long=read.csv("output/wheat_onset_long_IGP.csv")
wheat_onset_long <- na_if(wheat_onset_long, '-99')  #Replace all -99 with NA
wheat_onset_long <- na_if(wheat_onset_long, '-999999')  #Replace all -99 with NA
wheat_onset_long=rename(wheat_onset_long,ID=X)
wheat_onset_long_long <- melt(setDT(wheat_onset_long), id.vars = c("ID"),value.name=c("onset_long_wheat_yield") ,variable.name = "year")
wheat_onset_long_long$year=as.numeric(gsub('[^0-9]', '',wheat_onset_long_long$year))

wheat_fixedlong_onset_long=merge(wheat_fixedlong_long,wheat_onset_long_long,by=c("ID","year"))
wheat_fixedlong_onset_long$year=wheat_fixedlong_onset_long$year-1982

wheat_fixedlong_onset_long$fixedlong_wheat_yield[is.na(wheat_fixedlong_onset_long$fixedlong_wheat_yield)]=0
wheat_fixedlong_onset_long$onset_long_wheat_yield[is.na(wheat_fixedlong_onset_long$onset_long_wheat_yield)]=0

wheat_fixedlong_onset_long=wheat_fixedlong_onset_long[,c(1,2,3,5,4)]

export(wheat_fixedlong_onset_long,colNames=F,"code/Octave_EIGP/wheat_fixedlong_onset_long_IGP.xlsx")

## wheat-- Onset medium -----------------------------------------------------------------------------------
wheat_onset_medium=read.csv("output/wheat_onset_medium_IGP.csv")
wheat_onset_medium <- na_if(wheat_onset_medium, '-99')  #Replace all -99 with NA
wheat_onset_medium <- na_if(wheat_onset_medium, '-999999')  #Replace all -99 with NA
wheat_onset_medium=rename(wheat_onset_medium,ID=X)
wheat_onset_medium_long <- melt(setDT(wheat_onset_medium), id.vars = c("ID"),value.name=c("onset_medium_wheat_yield") ,variable.name = "year")
wheat_onset_medium_long$year=as.numeric(gsub('[^0-9]', '',wheat_onset_medium_long$year))

wheat_fixedlong_onset_medium=merge(wheat_fixedlong_long,wheat_onset_medium_long,by=c("ID","year"))
wheat_fixedlong_onset_medium$year=wheat_fixedlong_onset_medium$year-1982

wheat_fixedlong_onset_medium$fixedlong_wheat_yield[is.na(wheat_fixedlong_onset_medium$fixedlong_wheat_yield)]=0
wheat_fixedlong_onset_medium$onset_medium_wheat_yield[is.na(wheat_fixedlong_onset_medium$onset_medium_wheat_yield)]=0

wheat_fixedlong_onset_medium=wheat_fixedlong_onset_medium[,c(1,2,3,5,4)]

export(wheat_fixedlong_onset_medium,colNames=F,"code/Octave_EIGP/wheat_fixedlong_onset_medium_IGP.xlsx")


## wheat-- onset long suppl --------------------------------------------------------------------------
wheat_onset_long_suppl=read.csv("output/wheat_onset_long_suppl_IGP.csv")
wheat_onset_long_suppl <- na_if(wheat_onset_long_suppl, '-99')  #Replace all -99 with NA
wheat_onset_long_suppl <- na_if(wheat_onset_long_suppl, '-999999')  #Replace all -99 with NA
wheat_onset_long_suppl=rename(wheat_onset_long_suppl,ID=X)
wheat_onset_long_suppl_long <- melt(setDT(wheat_onset_long_suppl), id.vars = c("ID"),value.name=c("onset_long_suppl_wheat_yield") ,variable.name = "year")
wheat_onset_long_suppl_long$year=as.numeric(gsub('[^0-9]', '',wheat_onset_long_suppl_long$year))

wheat_fixedlong_onset_long_suppl=merge(wheat_fixedlong_long,wheat_onset_long_suppl_long,by=c("ID","year"))
wheat_fixedlong_onset_long_suppl$year=wheat_fixedlong_onset_long_suppl$year-1982

wheat_fixedlong_onset_long_suppl$fixedlong_wheat_yield[is.na(wheat_fixedlong_onset_long_suppl$fixedlong_wheat_yield)]=0
wheat_fixedlong_onset_long_suppl$onset_long_suppl_wheat_yield[is.na(wheat_fixedlong_onset_long_suppl$onset_long_suppl_wheat_yield)]=0

wheat_fixedlong_onset_long_suppl=wheat_fixedlong_onset_long_suppl[,c(1,2,3,5,4)]

export(wheat_fixedlong_onset_long_suppl,colNames=F,"code/Octave_EIGP/wheat_fixedlong_onset_long_suppl_IGP.xlsx")


## wheat-- onset medium suppl --------------------------------------------------------------------------
wheat_onset_medium_suppl=read.csv("output/wheat_onset_medium_suppl_IGP.csv")
wheat_onset_medium_suppl <- na_if(wheat_onset_medium_suppl, '-99')  #Replace all -99 with NA
wheat_onset_medium_suppl <- na_if(wheat_onset_medium_suppl, '-999999')  #Replace all -99 with NA
wheat_onset_medium_suppl=rename(wheat_onset_medium_suppl,ID=X)
wheat_onset_medium_suppl_long <- melt(setDT(wheat_onset_medium_suppl), id.vars = c("ID"),value.name=c("onset_medium_suppl_wheat_yield") ,variable.name = "year")
wheat_onset_medium_suppl_long$year=as.numeric(gsub('[^0-9]', '',wheat_onset_medium_suppl_long$year))

wheat_fixedlong_onset_medium_suppl=merge(wheat_fixedlong_long,wheat_onset_medium_suppl_long,by=c("ID","year"))
wheat_fixedlong_onset_medium_suppl$year=wheat_fixedlong_onset_medium_suppl$year-1982

wheat_fixedlong_onset_medium_suppl$fixedlong_wheat_yield[is.na(wheat_fixedlong_onset_medium_suppl$fixedlong_wheat_yield)]=0
wheat_fixedlong_onset_medium_suppl$onset_medium_suppl_wheat_yield[is.na(wheat_fixedlong_onset_medium_suppl$onset_medium_suppl_wheat_yield)]=0

wheat_fixedlong_onset_medium_suppl=wheat_fixedlong_onset_medium_suppl[,c(1,2,3,5,4)]

export(wheat_fixedlong_onset_medium_suppl,colNames=F,"code/Octave_EIGP/wheat_fixedlong_onset_medium_suppl_IGP.xlsx")








##############################STOPPED HERE FOR IGP##########################################
# REVENUE ----------------------------------------------------------------------
library(dplyr)
library(data.table)
library(tidyr)
library(rio)


# RICE-WHEAT --------------------------------------------------------------------------

## RICE-- Fixed long ---------------------------------------


rice_wheat_fixed_long_rev=read.csv("Revenue/rice_wheat_fixed_long_rev.csv")

rice_wheat_fixed_long_rev$x=NULL
rice_wheat_fixed_long_rev$y=NULL

rice_wheat_fixed_long_rev[rice_wheat_fixed_long_rev < 0] <- NA
rice_wheat_fixed_long_rev=rename(rice_wheat_fixed_long_rev,ID=X)


rice_wheat_fixed_long_rev$rice_wheat_area=rep(1,3429)


rice_wheat_fixed_long_rev_long <- melt(setDT(rice_wheat_fixed_long_rev), id.vars = c("ID","rice_wheat_area"),value.name=c("fixed_long_rice_wheat_revenue") ,variable.name = "year")

rice_wheat_fixed_long_rev_long$year=as.numeric(gsub('[^0-9]', '',rice_wheat_fixed_long_rev_long$year))

## Rice-Wheat-- Baseline ---------------------------

rice_wheat_farmer_practice_rev=read.csv("Revenue/rice_wheat_farmer_practice_rev.csv")

rice_wheat_farmer_practice_rev$x=NULL
rice_wheat_farmer_practice_rev$y=NULL

rice_wheat_farmer_practice_rev[rice_wheat_farmer_practice_rev < 0] <- NA
rice_wheat_farmer_practice_rev=rename(rice_wheat_farmer_practice_rev,ID=X)

rice_wheat_farmer_practice_rev_long <- melt(setDT(rice_wheat_farmer_practice_rev), id.vars = c("ID"),value.name=c("farmer_practice_rice_wheat_revenue") ,variable.name = "year")
rice_wheat_farmer_practice_rev_long$year=as.numeric(gsub('[^0-9]', '',rice_wheat_farmer_practice_rev_long$year))

rice_wheat_farmer_practice_rev_fixedlong=merge(rice_wheat_fixed_long_rev_long,rice_wheat_farmer_practice_rev_long,by=c("ID","year"))

#rice_wheat_farmer_practice_rev_fixedlong$year=rice_wheat_farmer_practice_rev_fixedlong$year-1982

rice_wheat_farmer_practice_rev_fixedlong$farmer_practice_rice_wheat_revenue[is.na(rice_wheat_farmer_practice_rev_fixedlong$farmer_practice_rice_wheat_revenue)]=0
rice_wheat_farmer_practice_rev_fixedlong$fixed_long_rice_wheat_revenue[is.na(rice_wheat_farmer_practice_rev_fixedlong$fixed_long_rice_wheat_revenue)]=0

# Rearranging so that fixed long is column number 5 because its the baseline
rice_wheat_farmer_practice_rev_fixedlong=rice_wheat_farmer_practice_rev_fixedlong[,c(1,2,3,5,4)]

export(rice_wheat_farmer_practice_rev_fixedlong,colNames=F,"Revenue/rice_wheat_farmer_practice_fixedlong_rev_s.xlsx")


## Fixed medium ------------------------------------
rice_wheat_fixed_medium_rev=read.csv("Revenue/rice_wheat_fixed_medium_rev.csv")

rice_wheat_fixed_medium_rev$x=NULL
rice_wheat_fixed_medium_rev$y=NULL

rice_wheat_fixed_medium_rev[rice_wheat_fixed_medium_rev < 0] <- NA
rice_wheat_fixed_medium_rev=rename(rice_wheat_fixed_medium_rev,ID=X)

rice_wheat_fixed_medium_rev_long <- melt(setDT(rice_wheat_fixed_medium_rev), id.vars = c("ID"),value.name=c("fixed_medium_rice_wheat_revenue") ,variable.name = "year")
rice_wheat_fixed_medium_rev_long$year=as.numeric(gsub('[^0-9]', '',rice_wheat_fixed_medium_rev_long$year))

rice_wheat_fixed_medium_rev_fixedlong=merge(rice_wheat_fixed_long_rev_long,rice_wheat_fixed_medium_rev_long,by=c("ID","year"))

#rice_wheat_fixed_medium_rev_fixedlong$year=rice_wheat_fixed_medium_rev_fixedlong$year-1982

rice_wheat_fixed_medium_rev_fixedlong$fixed_medium_rice_wheat_revenue[is.na(rice_wheat_fixed_medium_rev_fixedlong$fixed_medium_rice_wheat_revenue)]=0
rice_wheat_fixed_medium_rev_fixedlong$fixed_long_rice_wheat_revenue[is.na(rice_wheat_fixed_medium_rev_fixedlong$fixed_long_rice_wheat_revenue)]=0

# Rearranging so that fixed long is column number 5 because its the baseline
rice_wheat_fixed_medium_rev_fixedlong=rice_wheat_fixed_medium_rev_fixedlong[,c(1,2,3,5,4)]

export(rice_wheat_fixed_medium_rev_fixedlong,colNames=F,"Revenue/rice_wheat_fixed_medium_fixedlong_rev_s.xlsx")

## Onset long --------------------
rice_wheat_onset_long_rev=read.csv("Revenue/rice_wheat_onset_long_rev.csv")

rice_wheat_onset_long_rev$x=NULL
rice_wheat_onset_long_rev$y=NULL

rice_wheat_onset_long_rev[rice_wheat_onset_long_rev < 0] <- NA
rice_wheat_onset_long_rev=rename(rice_wheat_onset_long_rev,ID=X)

rice_wheat_onset_long_rev_long <- melt(setDT(rice_wheat_onset_long_rev), id.vars = c("ID"),value.name=c("onset_long_rice_wheat_revenue") ,variable.name = "year")
rice_wheat_onset_long_rev_long$year=as.numeric(gsub('[^0-9]', '',rice_wheat_onset_long_rev_long$year))

rice_wheat_onset_long_rev_fixedlong=merge(rice_wheat_fixed_long_rev_long,rice_wheat_onset_long_rev_long,by=c("ID","year"))

#rice_wheat_onset_long_rev_fixedlong$year=rice_wheat_onset_long_rev_fixedlong$year-1982

rice_wheat_onset_long_rev_fixedlong$onset_long_rice_wheat_yield[is.na(rice_wheat_onset_long_rev_fixedlong$onset_long_rice_wheat_revenue)]=0
rice_wheat_onset_long_rev_fixedlong$fixed_long_rice_wheat_revenue[is.na(rice_wheat_onset_long_rev_fixedlong$fixed_long_rice_wheat_revenue)]=0

# Rearranging so that fixed long is column number 5 because its the baseline
rice_wheat_onset_long_rev_fixedlong=rice_wheat_onset_long_rev_fixedlong[,c(1,2,3,5,4)]

export(rice_wheat_onset_long_rev_fixedlong,colNames=F,"Revenue/rice_wheat_onset_long_fixedlong_rev_s.xlsx")

## Onset medium ------------------------
rice_wheat_onset_medium_rev=read.csv("Revenue/rice_wheat_onset_medium_rev.csv")

rice_wheat_onset_medium_rev$x=NULL
rice_wheat_onset_medium_rev$y=NULL

rice_wheat_onset_medium_rev[rice_wheat_onset_medium_rev < 0] <- NA
rice_wheat_onset_medium_rev=rename(rice_wheat_onset_medium_rev,ID=X)

rice_wheat_onset_medium_rev_long <- melt(setDT(rice_wheat_onset_medium_rev), id.vars = c("ID"),value.name=c("onset_medium_rice_wheat_revenue") ,variable.name = "year")
rice_wheat_onset_medium_rev_long$year=as.numeric(gsub('[^0-9]', '',rice_wheat_onset_medium_rev_long$year))

rice_wheat_onset_medium_rev_fixedlong=merge(rice_wheat_fixed_long_rev_long,rice_wheat_onset_medium_rev_long,by=c("ID","year"))

#rice_wheat_onset_medium_rev_fixedlong$year=rice_wheat_onset_medium_rev_fixedlong$year-1982

rice_wheat_onset_medium_rev_fixedlong$onset_medium_rice_wheat_yield[is.na(rice_wheat_onset_medium_rev_fixedlong$onset_medium_rice_wheat_revenue)]=0
rice_wheat_onset_medium_rev_fixedlong$fixed_long_rice_wheat_revenue[is.na(rice_wheat_onset_medium_rev_fixedlong$fixed_long_rice_wheat_revenue)]=0

# Rearranging so that fixed long is column number 5 because its the baseline
rice_wheat_onset_medium_rev_fixedlong=rice_wheat_onset_medium_rev_fixedlong[,c(1,2,3,5,4)]

export(rice_wheat_onset_medium_rev_fixedlong,colNames=F,"Revenue/rice_wheat_onset_medium_fixedlong_rev_s.xlsx")

## Onset long suppl -----------
rice_wheat_onset_long_suppl_rev=read.csv("Revenue/rice_wheat_onset_long_suppl_rev.csv")

rice_wheat_onset_long_suppl_rev$x=NULL
rice_wheat_onset_long_suppl_rev$y=NULL

rice_wheat_onset_long_suppl_rev[rice_wheat_onset_long_suppl_rev < 0] <- NA
rice_wheat_onset_long_suppl_rev=rename(rice_wheat_onset_long_suppl_rev,ID=X)

rice_wheat_onset_long_suppl_rev_long <- melt(setDT(rice_wheat_onset_long_suppl_rev), id.vars = c("ID"),value.name=c("onset_long_suppl_rice_wheat_revenue") ,variable.name = "year")
rice_wheat_onset_long_suppl_rev_long$year=as.numeric(gsub('[^0-9]', '',rice_wheat_onset_long_suppl_rev_long$year))

rice_wheat_onset_long_suppl_rev_fixedlong=merge(rice_wheat_fixed_long_rev_long,rice_wheat_onset_long_suppl_rev_long,by=c("ID","year"))

#rice_wheat_onset_long_suppl_rev_fixedlong$year=rice_wheat_onset_long_suppl_rev_fixedlong$year-1982

rice_wheat_onset_long_suppl_rev_fixedlong$onset_long_suppl_rice_wheat_yield[is.na(rice_wheat_onset_long_suppl_rev_fixedlong$onset_long_suppl_rice_wheat_revenue)]=0
rice_wheat_onset_long_suppl_rev_fixedlong$fixed_long_rice_wheat_revenue[is.na(rice_wheat_onset_long_suppl_rev_fixedlong$fixed_long_rice_wheat_revenue)]=0

# Rearranging so that fixed long is column number 5 because its the baseline
rice_wheat_onset_long_suppl_rev_fixedlong=rice_wheat_onset_long_suppl_rev_fixedlong[,c(1,2,3,5,4)]

export(rice_wheat_onset_long_suppl_rev_fixedlong,colNames=F,"Revenue/rice_wheat_onset_long_suppl_fixedlong_rev_s.xlsx")

## Onset medium suppl ---------------------------------------
rice_wheat_onset_medium_suppl_rev=read.csv("Revenue/rice_wheat_onset_medium_suppl_rev.csv")

rice_wheat_onset_medium_suppl_rev$x=NULL
rice_wheat_onset_medium_suppl_rev$y=NULL

rice_wheat_onset_medium_suppl_rev[rice_wheat_onset_medium_suppl_rev < 0] <- NA
rice_wheat_onset_medium_suppl_rev=rename(rice_wheat_onset_medium_suppl_rev,ID=X)

rice_wheat_onset_medium_suppl_rev_long <- melt(setDT(rice_wheat_onset_medium_suppl_rev), id.vars = c("ID"),value.name=c("onset_medium_suppl_rice_wheat_revenue") ,variable.name = "year")
rice_wheat_onset_medium_suppl_rev_long$year=as.numeric(gsub('[^0-9]', '',rice_wheat_onset_medium_suppl_rev_long$year))

rice_wheat_onset_medium_suppl_rev_fixedlong=merge(rice_wheat_fixed_long_rev_long,rice_wheat_onset_medium_suppl_rev_long,by=c("ID","year"))

#rice_wheat_onset_medium_suppl_rev_fixedlong$year=rice_wheat_onset_medium_suppl_rev_fixedlong$year-1982

rice_wheat_onset_medium_suppl_rev_fixedlong$onset_medium_suppl_rice_wheat_yield[is.na(rice_wheat_onset_medium_suppl_rev_fixedlong$onset_medium_suppl_rice_wheat_revenue)]=0
rice_wheat_onset_medium_suppl_rev_fixedlong$fixed_long_rice_wheat_revenue[is.na(rice_wheat_onset_medium_suppl_rev_fixedlong$fixed_long_rice_wheat_revenue)]=0

# Rearranging so that fixed long is column number 5 because its the baseline
rice_wheat_onset_medium_suppl_rev_fixedlong=rice_wheat_onset_medium_suppl_rev_fixedlong[,c(1,2,3,5,4)]

export(rice_wheat_onset_medium_suppl_rev_fixedlong,colNames=F,"Revenue/rice_wheat_onset_medium_suppl_fixedlong_rev_s.xlsx")

