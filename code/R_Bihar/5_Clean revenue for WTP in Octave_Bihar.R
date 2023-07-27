
# REVENUE ----------------------------------------------------------------------
library(dplyr)
library(data.table)
library(tidyr)
library(rio)


# RICE-WHEAT --------------------------------------------------------------------------

## RICE-WHEAT-- Fixed long ---------------------------------------


rice_wheat_fixed_long_rev=read.csv("maxwell_interpolated_prices/rice_wheat_fixed_long_rev.csv")

rice_wheat_fixed_long_rev$x=NULL
rice_wheat_fixed_long_rev$y=NULL

rice_wheat_fixed_long_rev[rice_wheat_fixed_long_rev < 0] <- NA
rice_wheat_fixed_long_rev=rename(rice_wheat_fixed_long_rev,ID=X)


rice_wheat_fixed_long_rev$rice_wheat_area=rep(1,3429)


rice_wheat_fixed_long_rev_long <- melt(setDT(rice_wheat_fixed_long_rev), id.vars = c("ID","rice_wheat_area"),value.name=c("fixed_long_rice_wheat_revenue") ,variable.name = "year")

rice_wheat_fixed_long_rev_long$year=as.numeric(gsub('[^0-9]', '',rice_wheat_fixed_long_rev_long$year))

## Rice-Wheat-- Baseline ---------------------------

rice_wheat_farmer_practice_rev=read.csv("maxwell_interpolated_prices/rice_wheat_farmer_practice_rev.csv")

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

export(rice_wheat_farmer_practice_rev_fixedlong,colNames=F,"maxwell_interpolated_prices/rice_wheat_farmer_practice_fixedlong_rev_s.xlsx")


## Fixed medium ------------------------------------
rice_wheat_fixed_medium_rev=read.csv("maxwell_interpolated_prices/rice_wheat_fixed_medium_rev.csv")

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

export(rice_wheat_fixed_medium_rev_fixedlong,colNames=F,"maxwell_interpolated_prices/rice_wheat_fixed_medium_fixedlong_rev_s.xlsx")

## Onset long --------------------
rice_wheat_onset_long_rev=read.csv("maxwell_interpolated_prices/rice_wheat_onset_long_rev.csv")

rice_wheat_onset_long_rev$x=NULL
rice_wheat_onset_long_rev$y=NULL

rice_wheat_onset_long_rev[rice_wheat_onset_long_rev < 0] <- NA
rice_wheat_onset_long_rev=rename(rice_wheat_onset_long_rev,ID=X)

rice_wheat_onset_long_rev_long <- melt(setDT(rice_wheat_onset_long_rev), id.vars = c("ID"),value.name=c("onset_long_rice_wheat_revenue") ,variable.name = "year")
rice_wheat_onset_long_rev_long$year=as.numeric(gsub('[^0-9]', '',rice_wheat_onset_long_rev_long$year))

rice_wheat_onset_long_rev_fixedlong=merge(rice_wheat_fixed_long_rev_long,rice_wheat_onset_long_rev_long,by=c("ID","year"))

#rice_wheat_onset_long_rev_fixedlong$year=rice_wheat_onset_long_rev_fixedlong$year-1982

rice_wheat_onset_long_rev_fixedlong$onset_long_rice_wheat_revenue[is.na(rice_wheat_onset_long_rev_fixedlong$onset_long_rice_wheat_revenue)]=0
rice_wheat_onset_long_rev_fixedlong$fixed_long_rice_wheat_revenue[is.na(rice_wheat_onset_long_rev_fixedlong$fixed_long_rice_wheat_revenue)]=0

# Rearranging so that fixed long is column number 5 because its the baseline
rice_wheat_onset_long_rev_fixedlong=rice_wheat_onset_long_rev_fixedlong[,c(1,2,3,5,4)]

export(rice_wheat_onset_long_rev_fixedlong,colNames=F,"maxwell_interpolated_prices/rice_wheat_onset_long_fixedlong_rev_s.xlsx")

## Onset medium ------------------------
rice_wheat_onset_medium_rev=read.csv("maxwell_interpolated_prices/rice_wheat_onset_medium_rev.csv")

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

export(rice_wheat_onset_medium_rev_fixedlong,colNames=F,"maxwell_interpolated_prices/rice_wheat_onset_medium_fixedlong_rev_s.xlsx")

## Onset long suppl -----------
rice_wheat_onset_long_suppl_rev=read.csv("maxwell_interpolated_prices/rice_wheat_onset_long_suppl_rev.csv")

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

export(rice_wheat_onset_long_suppl_rev_fixedlong,colNames=F,"maxwell_interpolated_prices/rice_wheat_onset_long_suppl_fixedlong_rev_s.xlsx")

## Onset medium suppl ---------------------------------------
rice_wheat_onset_medium_suppl_rev=read.csv("maxwell_interpolated_prices/rice_wheat_onset_medium_suppl_rev.csv")

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

export(rice_wheat_onset_medium_suppl_rev_fixedlong,colNames=F,"maxwell_interpolated_prices/rice_wheat_onset_medium_suppl_fixedlong_rev_s.xlsx")
