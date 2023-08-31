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
source("code/R_EIGP/Yield_postanalysis_IGP.R")

# 





## Partial profits