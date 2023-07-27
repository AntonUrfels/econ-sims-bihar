# PARTIAL PROFIT ---------------------------------------------------------------
## RICE-WHEAT ------------------------------------------------------------------

## RICE-WHEAT-- Fixed long ---------------------------------------


rice_wheat_fixed_long_pprof=read.csv("data/maxwell_interpolated_prices/rice_wheat_fixed_long_rented_profit_pt.csv")

rice_wheat_fixed_long_pprof$x=NULL
rice_wheat_fixed_long_pprof$y=NULL

rice_wheat_fixed_long_pprof[rice_wheat_fixed_long_pprof < 0] <- NA

names(rice_wheat_fixed_long_pprof)[1]="ID"

rice_wheat_fixed_long_pprof$rice_wheat_area=rep(1,nrow(rice_wheat_fixed_long_pprof))

rice_wheat_fixed_long_pprof_long <- melt(setDT(rice_wheat_fixed_long_pprof), id.vars = c("ID","rice_wheat_area"),value.name=c("fixed_long_rice_wheat_pprof") ,variable.name = "year")

rice_wheat_fixed_long_pprof_long$year=as.numeric(gsub('[^0-9]', '',rice_wheat_fixed_long_pprof_long$year))

## Rice-Wheat-- Baseline ---------------------------

rice_wheat_farmer_practice_pprof=read.csv("data/maxwell_interpolated_prices/rice_wheat_farmer_practice_rented_profit_pt.csv")

rice_wheat_farmer_practice_pprof$x=NULL
rice_wheat_farmer_practice_pprof$y=NULL

rice_wheat_farmer_practice_pprof[rice_wheat_farmer_practice_pprof < 0] <- NA

names(rice_wheat_farmer_practice_pprof)[1]="ID"

rice_wheat_farmer_practice_pprof_long <- melt(setDT(rice_wheat_farmer_practice_pprof), id.vars = c("ID"),value.name=c("farmer_practice_rice_wheat_pprof") ,variable.name = "year")
rice_wheat_farmer_practice_pprof_long$year=as.numeric(gsub('[^0-9]', '',rice_wheat_farmer_practice_pprof_long$year))

rice_wheat_farmer_practice_pprof_fixedlong=merge(rice_wheat_fixed_long_pprof_long,rice_wheat_farmer_practice_pprof_long,by=c("ID","year"))

rice_wheat_farmer_practice_pprof_fixedlong$farmer_practice_rice_wheat_pprof[is.na(rice_wheat_farmer_practice_pprof_fixedlong$farmer_practice_rice_wheat_pprof)]=0
rice_wheat_farmer_practice_pprof_fixedlong$fixed_long_rice_wheat_pprof[is.na(rice_wheat_farmer_practice_pprof_fixedlong$fixed_long_rice_wheat_pprof)]=0

# Rearranging so that fixed long is column number 5 because its the baseline
rice_wheat_farmer_practice_rented_pprof_fixedlong=rice_wheat_farmer_practice_pprof_fixedlong[,c(1,2,3,5,4)]

export(rice_wheat_farmer_practice_rented_pprof_fixedlong,colNames=F,"code/Octave_Bihar_PartialProfit/rice_wheat_farmer_practice_fixedlong_rented_pprof.xlsx")


## Fixed medium --------------------------------
rice_wheat_fixed_medium_pprof=read.csv("data/maxwell_interpolated_prices/rice_wheat_fixed_medium_rented_profit_pt.csv")

rice_wheat_fixed_medium_pprof$x=NULL
rice_wheat_fixed_medium_pprof$y=NULL

rice_wheat_fixed_medium_pprof[rice_wheat_fixed_medium_pprof < 0] <- NA
names(rice_wheat_fixed_medium_pprof)[1]="ID"

rice_wheat_fixed_medium_pprof_long <- melt(setDT(rice_wheat_fixed_medium_pprof), id.vars = c("ID"),value.name=c("fixed_medium_rice_wheat_pprof") ,variable.name = "year")
rice_wheat_fixed_medium_pprof_long$year=as.numeric(gsub('[^0-9]', '',rice_wheat_fixed_medium_pprof_long$year))

rice_wheat_fixed_medium_pprof_fixedlong=merge(rice_wheat_fixed_long_pprof_long,rice_wheat_fixed_medium_pprof_long,by=c("ID","year"))


rice_wheat_fixed_medium_pprof_fixedlong$fixed_medium_rice_wheat_pprof[is.na(rice_wheat_fixed_medium_pprof_fixedlong$fixed_medium_rice_wheat_pprof)]=0
rice_wheat_fixed_medium_pprof_fixedlong$fixed_long_rice_wheat_pprof[is.na(rice_wheat_fixed_medium_pprof_fixedlong$fixed_long_rice_wheat_pprof)]=0

# Rearranging so that fixed long is column number 5 because its the baseline
rice_wheat_fixed_medium_pprof_fixedlong=rice_wheat_fixed_medium_pprof_fixedlong[,c(1,2,3,5,4)]

export(rice_wheat_fixed_medium_pprof_fixedlong,colNames=F,"code/Octave_Bihar_PartialProfit/rice_wheat_fixed_medium_fixedlong_rented_pprof.xlsx")

## Onset long --------------------
rice_wheat_onset_long_pprof=read.csv("data/maxwell_interpolated_prices/rice_wheat_onset_long_rented_profit_pt.csv")

rice_wheat_onset_long_pprof$x=NULL
rice_wheat_onset_long_pprof$y=NULL

rice_wheat_onset_long_pprof[rice_wheat_onset_long_pprof < 0] <- NA
names(rice_wheat_onset_long_pprof)[1]="ID"

rice_wheat_onset_long_pprof_long <- melt(setDT(rice_wheat_onset_long_pprof), id.vars = c("ID"),value.name=c("onset_long_rice_wheat_pprof") ,variable.name = "year")
rice_wheat_onset_long_pprof_long$year=as.numeric(gsub('[^0-9]', '',rice_wheat_onset_long_pprof_long$year))

rice_wheat_onset_long_pprof_fixedlong=merge(rice_wheat_fixed_long_pprof_long,rice_wheat_onset_long_pprof_long,by=c("ID","year"))

rice_wheat_onset_long_pprof_fixedlong$onset_long_rice_wheat_pprof[is.na(rice_wheat_onset_long_pprof_fixedlong$onset_long_rice_wheat_pprof)]=0
rice_wheat_onset_long_pprof_fixedlong$fixed_long_rice_wheat_pprof[is.na(rice_wheat_onset_long_pprof_fixedlong$fixed_long_rice_wheat_pprof)]=0

# Rearranging so that fixed long is column number 5 because its the baseline
rice_wheat_onset_long_pprof_fixedlong=rice_wheat_onset_long_pprof_fixedlong[,c(1,2,3,5,4)]

export(rice_wheat_onset_long_pprof_fixedlong,colNames=F,"code/Octave_Bihar_PartialProfit/rice_wheat_onset_long_fixedlong_rented_pprof.xlsx")

## Onset medium ------------------------
rice_wheat_onset_medium_pprof=read.csv("data/maxwell_interpolated_prices/rice_wheat_onset_medium_rented_profit_pt.csv")

rice_wheat_onset_medium_pprof$x=NULL
rice_wheat_onset_medium_pprof$y=NULL

rice_wheat_onset_medium_pprof[rice_wheat_onset_medium_pprof < 0] <- NA
names(rice_wheat_onset_medium_pprof)[1]="ID"

rice_wheat_onset_medium_pprof_long <- melt(setDT(rice_wheat_onset_medium_pprof), id.vars = c("ID"),value.name=c("onset_medium_rice_wheat_pprof") ,variable.name = "year")
rice_wheat_onset_medium_pprof_long$year=as.numeric(gsub('[^0-9]', '',rice_wheat_onset_medium_pprof_long$year))

rice_wheat_onset_medium_pprof_fixedlong=merge(rice_wheat_fixed_long_pprof_long,rice_wheat_onset_medium_pprof_long,by=c("ID","year"))

rice_wheat_onset_medium_pprof_fixedlong$onset_medium_rice_wheat_pprof[is.na(rice_wheat_onset_medium_pprof_fixedlong$onset_medium_rice_wheat_pprof)]=0
rice_wheat_onset_medium_pprof_fixedlong$fixed_long_rice_wheat_pprof[is.na(rice_wheat_onset_medium_pprof_fixedlong$fixed_long_rice_wheat_pprof)]=0

# Rearranging so that fixed long is column number 5 because its the baseline
rice_wheat_onset_medium_pprof_fixedlong=rice_wheat_onset_medium_pprof_fixedlong[,c(1,2,3,5,4)]

export(rice_wheat_onset_medium_pprof_fixedlong,colNames=F,"code/Octave_Bihar_PartialProfit/rice_wheat_onset_medium_fixedlong_rented_pprof.xlsx")

## Onset long suppl -----------
rice_wheat_onset_long_suppl_pprof=read.csv("data/maxwell_interpolated_prices/rice_wheat_onset_long_suppl_rented_profit_pt.csv")

rice_wheat_onset_long_suppl_pprof$x=NULL
rice_wheat_onset_long_suppl_pprof$y=NULL

rice_wheat_onset_long_suppl_pprof[rice_wheat_onset_long_suppl_pprof < 0] <- NA
names(rice_wheat_onset_long_suppl_pprof)[1]="ID"

rice_wheat_onset_long_suppl_pprof_long <- melt(setDT(rice_wheat_onset_long_suppl_pprof), id.vars = c("ID"),value.name=c("onset_long_suppl_rice_wheat_pprof") ,variable.name = "year")
rice_wheat_onset_long_suppl_pprof_long$year=as.numeric(gsub('[^0-9]', '',rice_wheat_onset_long_suppl_pprof_long$year))

rice_wheat_onset_long_suppl_pprof_fixedlong=merge(rice_wheat_fixed_long_pprof_long,rice_wheat_onset_long_suppl_pprof_long,by=c("ID","year"))

rice_wheat_onset_long_suppl_pprof_fixedlong$onset_long_suppl_rice_wheat_pprof[is.na(rice_wheat_onset_long_suppl_pprof_fixedlong$onset_long_suppl_rice_wheat_pprof)]=0
rice_wheat_onset_long_suppl_pprof_fixedlong$fixed_long_rice_wheat_pprof[is.na(rice_wheat_onset_long_suppl_pprof_fixedlong$fixed_long_rice_wheat_pprof)]=0

# Rearranging so that fixed long is column number 5 because its the baseline
rice_wheat_onset_long_suppl_pprof_fixedlong=rice_wheat_onset_long_suppl_pprof_fixedlong[,c(1,2,3,5,4)]

export(rice_wheat_onset_long_suppl_pprof_fixedlong,colNames=F,"code/Octave_Bihar_PartialProfit/rice_wheat_onset_long_suppl_fixedlong_rented_pprof.xlsx")

## Onset medium suppl ---------------------------------------
rice_wheat_onset_medium_suppl_pprof=read.csv("data/maxwell_interpolated_prices/rice_wheat_onset_medium_suppl_rented_profit_pt.csv")

rice_wheat_onset_medium_suppl_pprof$x=NULL
rice_wheat_onset_medium_suppl_pprof$y=NULL

rice_wheat_onset_medium_suppl_pprof[rice_wheat_onset_medium_suppl_pprof < 0] <- NA
names(rice_wheat_onset_medium_suppl_pprof)[1]="ID"

rice_wheat_onset_medium_suppl_pprof_long <- melt(setDT(rice_wheat_onset_medium_suppl_pprof), id.vars = c("ID"),value.name=c("onset_medium_suppl_rice_wheat_pprof") ,variable.name = "year")
rice_wheat_onset_medium_suppl_pprof_long$year=as.numeric(gsub('[^0-9]', '',rice_wheat_onset_medium_suppl_pprof_long$year))

rice_wheat_onset_medium_suppl_pprof_fixedlong=merge(rice_wheat_fixed_long_pprof_long,rice_wheat_onset_medium_suppl_pprof_long,by=c("ID","year"))

rice_wheat_onset_medium_suppl_pprof_fixedlong$onset_medium_suppl_rice_wheat_pprof[is.na(rice_wheat_onset_medium_suppl_pprof_fixedlong$onset_medium_suppl_rice_wheat_pprof)]=0
rice_wheat_onset_medium_suppl_pprof_fixedlong$fixed_long_rice_wheat_pprof[is.na(rice_wheat_onset_medium_suppl_pprof_fixedlong$fixed_long_rice_wheat_pprof)]=0

# Rearranging so that fixed long is column number 5 because its the baseline
rice_wheat_onset_medium_suppl_pprof_fixedlong=rice_wheat_onset_medium_suppl_pprof_fixedlong[,c(1,2,3,5,4)]

export(rice_wheat_onset_medium_suppl_pprof_fixedlong,colNames=F,"code/Octave_Bihar_PartialProfit/rice_wheat_onset_medium_suppl_fixedlong_rented_pprof.xlsx")
