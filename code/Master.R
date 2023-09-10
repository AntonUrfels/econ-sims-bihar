# Run the following code chronologically 


# Bihar Models ------------
source("explore.R")

##Yield ------------ 
#Run R code to create data file for optimization in Octave
source("code/R_Bihar/1_WTP_fixedlongasbaseline_Bihar.R")

# Run Octave Code in folder "Octave_Bihar"




# IGP Models ------------------
# Creates csv files with pixel level data
source("explore.R")

# Creates data for Octave optimization
source("code/R_EIGP/1_WTP_fixedlongbaseline_IGP/.R")

# Creates csv files of the Octave results with variable names
source("code/R_EIGP/2_WTP_results_fixedlongasbaseline_IGP.R")


## Yield 
#Creates figures on yield WTP
source("code/R_EIGP/3_Yield_postanalysis_IGP.R")

# Clean revenue data
source("code/R_EIGP/4_Create_Revenue_Data_IGP.R")

# clean revenue WTP IN Octave
source("code/R_EIGP/5_Clean revenue for WTP in Octave_IGP.R")

# 
source("code/R_EIGP/6_WTP_results_fixedlongasbaseline_rev_IGP.R")
#
source("code/R_EIGP/7_Clean_partial_profit_for_WTP_in_Octave_IGP.R")
#
source("code/R_EIGP/8_WTP_results_fixedlongasbaseline_prof_IGP.R")
#
source("code/R_EIGP/9_Revenue_Partial_Profit_postanalysis_IGP.R")
#
source("code/R_EIGP/10_Optimal_pixellevel_strategy_IGP.R")




## Partial profits