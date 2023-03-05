
# packages ------------------
library(rio)
library(dplyr)

# Import RA --------------------------------------------------------------------

## RICE -----------------------------------------------------
RA_Rice_baseline_fixedlong<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Rice_baseline_fixedlong.xlsx", sheet="Sheet1", col_names = FALSE)
RA_Rice_fixedlong_fixedmedium<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Rice_fixedlong_fixedmedium.xlsx", sheet="Sheet1", col_names = FALSE)
RA_Rice_fixedlong_onset_long<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Rice_fixedlong_onset_long.xlsx", sheet="Sheet1", col_names = FALSE)
RA_Rice_fixedlong_onset_medium<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Rice_fixedlong_onset_medium.xlsx", sheet="Sheet1", col_names = FALSE)
RA_Rice_fixedlong_onset_long_suppl<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Rice_fixedlong_onset_long_suppl.xlsx", sheet="Sheet1", col_names = FALSE)
RA_Rice_fixedlong_onset_medium_suppl<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Rice_fixedlong_onset_medium_suppl.xlsx", sheet="Sheet1", col_names = FALSE)



# RA column names
# %  1 = cellID
# %  2 = Comparison Technology ID
# %  3 = Base Technology ID
# %  4 = Mean Yield for Comp
# %  5 = Standard Deviation of Yield for Comp
# %  6 = CV of Yield for Comp
# %  7 = Maximum Yield for Comp
# %  8 = Minimum Yield for Comp
# %  9 = Probability of Crop Failure for Comp
# % 10 = Min Proportion for Comp to SOSD Base
# % 11 = Mean Yield for Base
# % 12 = Standard Deviation of Yield for Base
# % 13 = CV of Yield for Base
# % 14 = Maximum Yield for Base
# % 15 = Minimum Yield for Base
# % 16 = Probability of Crop Failure for Base
# % 17 = Min Proportion for Base to SOSD Comp
# % 18 = Difference in mean Comp - Base
# % 19 = Difference in standard deviation Comp - Base
# % 20 = Difference in CV Comp - Base
# % 21 = Difference in Prob of Crop Failure Comp - Base
# % 22 = Min Proportion for Comp to SOSD Base divided by average base yield
# % 23 = Min Proportion for Base to SOSD Comp divided by average base yield
# % 24 = Comp More Risky (-1)/less Risky (1)/ Indeterminant (0) compared to Base
# % 25 = Wheat Area

columnnames=c("CellID","CompID","BaseID","CompYield_Mean","CompYield_SD",
              "CompYield_CV","CompYield_Max","CompYield_Min","CompCropFailureProb","CompMinPropSOSDBase",
              "BaseYield_Mean","BaseYield_SD","BaseYield_CV","BaseYield_Max","BaseYield_Min",
              "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
              "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbaseyield","MinProp_BaseSOSDComp_Divdbaseyield",
              "Riskiness_Comp","RiceArea")

names(RA_Rice_fixedlong_fixedlong)[1:25]=c("CellID","CompID","BaseID","CompYield_Mean","CompYield_SD",
                                          "CompYield_CV","CompYield_Max","CompYield_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                          "BaseYield_Mean","BaseYield_SD","BaseYield_CV","BaseYield_Max","BaseYield_Min",
                                          "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                          "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbaseyield","MinProp_BaseSOSDComp_Divdbaseyield",
                                          "Riskiness_Comp","RiceArea")

names(RA_Rice_fixedlong_fixedmedium)[1:25]=c("CellID","CompID","BaseID","CompYield_Mean","CompYield_SD",
                                            "CompYield_CV","CompYield_Max","CompYield_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                            "BaseYield_Mean","BaseYield_SD","BaseYield_CV","BaseYield_Max","BaseYield_Min",
                                            "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                            "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbaseyield","MinProp_BaseSOSDComp_Divdbaseyield",
                                            "Riskiness_Comp","RiceArea")

names(RA_Rice_fixedlong_onset_long)[1:25]=c("CellID","CompID","BaseID","CompYield_Mean","CompYield_SD",
                                           "CompYield_CV","CompYield_Max","CompYield_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                           "BaseYield_Mean","BaseYield_SD","BaseYield_CV","BaseYield_Max","BaseYield_Min",
                                           "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                           "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbaseyield","MinProp_BaseSOSDComp_Divdbaseyield",
                                           "Riskiness_Comp","RiceArea")

names(RA_Rice_fixedlong_onset_medium)[1:25]=c("CellID","CompID","BaseID","CompYield_Mean","CompYield_SD",
                                             "CompYield_CV","CompYield_Max","CompYield_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                             "BaseYield_Mean","BaseYield_SD","BaseYield_CV","BaseYield_Max","BaseYield_Min",
                                             "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                             "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbaseyield","MinProp_BaseSOSDComp_Divdbaseyield",
                                             "Riskiness_Comp","RiceArea")

names(RA_Rice_fixedlong_onset_long_suppl)[1:25]=c("CellID","CompID","BaseID","CompYield_Mean","CompYield_SD",
                                                 "CompYield_CV","CompYield_Max","CompYield_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                                 "BaseYield_Mean","BaseYield_SD","BaseYield_CV","BaseYield_Max","BaseYield_Min",
                                                 "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                                 "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbaseyield","MinProp_BaseSOSDComp_Divdbaseyield",
                                                 "Riskiness_Comp","RiceArea")

names(RA_Rice_fixedlong_onset_medium_suppl)[1:25]=c("CellID","CompID","BaseID","CompYield_Mean","CompYield_SD",
                                                   "CompYield_CV","CompYield_Max","CompYield_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                                   "BaseYield_Mean","BaseYield_SD","BaseYield_CV","BaseYield_Max","BaseYield_Min",
                                                   "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                                   "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbaseyield","MinProp_BaseSOSDComp_Divdbaseyield",
                                                   "Riskiness_Comp","RiceArea")

write.csv(RA_Rice_baseline_fixedlong,"D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Rice_baseline_fixedlong_c.csv")
write.csv(RA_Rice_fixedlong_fixedmedium,"D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Rice_fixedlong_fixedmedium_c.csv")
write.csv(RA_Rice_fixedlong_onset_long,"D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Rice_fixedlong_onset_long_c.csv")
write.csv(RA_Rice_fixedlong_onset_medium,"D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Rice_fixedlong_onset_medium_c.csv")
write.csv(RA_Rice_fixedlong_onset_long_suppl,"D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Rice_fixedlong_onset_long_suppl_c.csv")
write.csv(RA_Rice_fixedlong_onset_medium_suppl,"D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Rice_fixedlong_onset_medium_suppl_c.csv")

## WHEAT --------------------------------------------
RA_Wheat_baseline_fixedlong<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Wheat_baseline_fixedlong.xlsx", sheet="Sheet1", col_names = FALSE)
RA_Wheat_fixedlong_fixedmedium<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Wheat_fixedlong_fixedmedium.xlsx", sheet="Sheet1", col_names = FALSE)
RA_Wheat_fixedlong_onset_long<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Wheat_fixedlong_onset_long.xlsx", sheet="Sheet1", col_names = FALSE)
RA_Wheat_fixedlong_onset_medium<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Wheat_fixedlong_onset_medium.xlsx", sheet="Sheet1", col_names = FALSE)
RA_Wheat_fixedlong_onset_long_suppl<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Wheat_fixedlong_onset_long_suppl.xlsx", sheet="Sheet1", col_names = FALSE)
RA_Wheat_fixedlong_onset_medium_suppl<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Wheat_fixedlong_onset_medium_suppl.xlsx", sheet="Sheet1", col_names = FALSE)



# RA column names
# %  1 = cellID
# %  2 = Comparison Technology ID
# %  3 = Base Technology ID
# %  4 = Mean Yield for Comp
# %  5 = Standard Deviation of Yield for Comp
# %  6 = CV of Yield for Comp
# %  7 = Maximum Yield for Comp
# %  8 = Minimum Yield for Comp
# %  9 = Probability of Crop Failure for Comp
# % 10 = Min Proportion for Comp to SOSD Base
# % 11 = Mean Yield for Base
# % 12 = Standard Deviation of Yield for Base
# % 13 = CV of Yield for Base
# % 14 = Maximum Yield for Base
# % 15 = Minimum Yield for Base
# % 16 = Probability of Crop Failure for Base
# % 17 = Min Proportion for Base to SOSD Comp
# % 18 = Difference in mean Comp - Base
# % 19 = Difference in standard deviation Comp - Base
# % 20 = Difference in CV Comp - Base
# % 21 = Difference in Prob of Crop Failure Comp - Base
# % 22 = Min Proportion for Comp to SOSD Base divided by average base yield
# % 23 = Min Proportion for Base to SOSD Comp divided by average base yield
# % 24 = Comp More Risky (-1)/less Risky (1)/ Indeterminant (0) compared to Base
# % 25 = Wheat Area

columnnames=c("CellID","CompID","BaseID","CompYield_Mean","CompYield_SD",
              "CompYield_CV","CompYield_Max","CompYield_Min","CompCropFailureProb","CompMinPropSOSDBase",
              "BaseYield_Mean","BaseYield_SD","BaseYield_CV","BaseYield_Max","BaseYield_Min",
              "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
              "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbaseyield","MinProp_BaseSOSDComp_Divdbaseyield",
              "Riskiness_Comp","WheatArea")

names(RA_Wheat_baseline_fixedlong)[1:25]=c("CellID","CompID","BaseID","CompYield_Mean","CompYield_SD",
                                           "CompYield_CV","CompYield_Max","CompYield_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                           "BaseYield_Mean","BaseYield_SD","BaseYield_CV","BaseYield_Max","BaseYield_Min",
                                           "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                           "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbaseyield","MinProp_BaseSOSDComp_Divdbaseyield",
                                           "Riskiness_Comp","WheatArea")

names(RA_Wheat_fixedlong_fixedmedium)[1:25]=c("CellID","CompID","BaseID","CompYield_Mean","CompYield_SD",
                                             "CompYield_CV","CompYield_Max","CompYield_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                             "BaseYield_Mean","BaseYield_SD","BaseYield_CV","BaseYield_Max","BaseYield_Min",
                                             "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                             "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbaseyield","MinProp_BaseSOSDComp_Divdbaseyield",
                                             "Riskiness_Comp","WheatArea")

names(RA_Wheat_fixedlong_onset_long)[1:25]=c("CellID","CompID","BaseID","CompYield_Mean","CompYield_SD",
                                            "CompYield_CV","CompYield_Max","CompYield_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                            "BaseYield_Mean","BaseYield_SD","BaseYield_CV","BaseYield_Max","BaseYield_Min",
                                            "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                            "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbaseyield","MinProp_BaseSOSDComp_Divdbaseyield",
                                            "Riskiness_Comp","WheatArea")

names(RA_Wheat_fixedlong_onset_medium)[1:25]=c("CellID","CompID","BaseID","CompYield_Mean","CompYield_SD",
                                              "CompYield_CV","CompYield_Max","CompYield_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                              "BaseYield_Mean","BaseYield_SD","BaseYield_CV","BaseYield_Max","BaseYield_Min",
                                              "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                              "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbaseyield","MinProp_BaseSOSDComp_Divdbaseyield",
                                              "Riskiness_Comp","WheatArea")

names(RA_Wheat_fixedlong_onset_long_suppl)[1:25]=c("CellID","CompID","BaseID","CompYield_Mean","CompYield_SD",
                                                  "CompYield_CV","CompYield_Max","CompYield_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                                  "BaseYield_Mean","BaseYield_SD","BaseYield_CV","BaseYield_Max","BaseYield_Min",
                                                  "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                                  "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbaseyield","MinProp_BaseSOSDComp_Divdbaseyield",
                                                  "Riskiness_Comp","WheatArea")

names(RA_Wheat_fixedlong_onset_medium_suppl)[1:25]=c("CellID","CompID","BaseID","CompYield_Mean","CompYield_SD",
                                                    "CompYield_CV","CompYield_Max","CompYield_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                                    "BaseYield_Mean","BaseYield_SD","BaseYield_CV","BaseYield_Max","BaseYield_Min",
                                                    "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                                    "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbaseyield","MinProp_BaseSOSDComp_Divdbaseyield",
                                                    "Riskiness_Comp","WheatArea")

write.csv(RA_Wheat_baseline_fixedlong,"D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Wheat_baseline_fixedlong_c.csv")
write.csv(RA_Wheat_fixedlong_fixedmedium,"D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Wheat_fixedlong_fixedmedium_c.csv")
write.csv(RA_Wheat_fixedlong_onset_long,"D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Wheat_fixedlong_onset_long_c.csv")
write.csv(RA_Wheat_fixedlong_onset_medium,"D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Wheat_fixedlong_onset_medium_c.csv")
write.csv(RA_Wheat_fixedlong_onset_long_suppl,"D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Wheat_fixedlong_onset_long_suppl_c.csv")
write.csv(RA_Wheat_fixedlong_onset_medium_suppl,"D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/RA_Wheat_fixedlong_onset_medium_suppl_c.csv")


# Import Descriptive stats -------------------------------
# %   1 = Weighted Mean   UB
# %   2 = Weighted S.D.   UB
# %   3 = Minimum         UB
# %   4 = 10th Percentile UB
# %   5 = 25th Percentile UB
# %   6 = Median          UB
# %   7 = 75th Percentile UB
# %   8 = 90th Percentile UB
# %   9 = Maximum         UB
# %  10 = Weighted Mean   LB
# %  11 = Weighted S.D.   LB
# %  12 = Minimum         LB
# %  13 = 10th Percentile LB
# %  14 = 25th Percentile LB
# %  15 = Median          LB
# %  16 = 75th Percentile LB
# %  17 = 90th Percentile LB
# %  18 = Maximum         LB
# %  19 = Proportion of Acres in Green
# %  20 = Proportion of Acres in Yellow
# %  21 = Proportion of Acres in Red
# %  22 = Total Acres
# %  23 = Number of Cells

## Rice -------------------------------------------------
Statistics=c("WeightedMean_UB","WeightedSD_UB","Min_UB","Percentile10_UB","Percentile25_UB","Median_UB","Percentile75_UB","Percentile90_UB","Max_UB",
             "WeightedMean_LB","WeightedSD_LB","Min_LB","Percentile10_LB","Percentile25_LB","Median_LB","Percentile75_LB","Percentile90_LB","Max_LB",
             "PropLandinGreen","PropLandinYellow","PropLandinRed","TotalAcres","NumberofCells")

Statistics=as.data.frame(Statistics)

DescriptiveStat_Rice_baseline_fixedlong<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/DescriptiveStat_Rice_baseline_fixedlong.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Rice_fixedlong_fixedmedium<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/DescriptiveStat_Rice_fixedlong_fixedmedium.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Rice_fixedlong_onset_long<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/DescriptiveStat_Rice_fixedlong_onset_long.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Rice_fixedlong_onset_long_suppl<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/DescriptiveStat_Rice_fixedlong_onset_long_suppl.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Rice_fixedlong_onset_medium<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/DescriptiveStat_Rice_fixedlong_onset_medium.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Rice_fixedlong_onset_medium_suppl<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/DescriptiveStat_Rice_fixedlong_onset_medium_suppl.xlsx", sheet="Sheet1", col_names = FALSE)


DescriptiveStat_Rice_All_Scenarios=bind_cols(Statistics,DescriptiveStat_Rice_baseline_fixedlong,
                                             DescriptiveStat_Rice_fixedlong_fixedmedium,
                                             DescriptiveStat_Rice_fixedlong_onset_long,
                                             DescriptiveStat_Rice_fixedlong_onset_long_suppl,
                                             DescriptiveStat_Rice_fixedlong_onset_medium,
                                             DescriptiveStat_Rice_fixedlong_onset_medium_suppl)

names(DescriptiveStat_Rice_All_Scenarios)[1:7]=c("Statistics","Rice_farmerpractice","Rice_medium_long","Rice_onset_long",
                                                 "Rice_onset_long_suppl","Rice_onset_medium","Rice_onset_medium_suppl")


write.csv(DescriptiveStat_Rice_All_Scenarios,"D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/DescriptiveStat_Rice_All_Scenarios_FixedLongasBaseline.csv")

## Wheat -------------------------
Statistics=c("WeightedMean_UB","WeightedSD_UB","Min_UB","Percentile10_UB","Percentile25_UB","Median_UB","Percentile75_UB","Percentile90_UB","Max_UB",
             "WeightedMean_LB","WeightedSD_LB","Min_LB","Percentile10_LB","Percentile25_LB","Median_LB","Percentile75_LB","Percentile90_LB","Max_LB",
             "PropLandinGreen","PropLandinYellow","PropLandinRed","TotalAcres","NumberofCells")

Statistics=as.data.frame(Statistics)

DescriptiveStat_Wheat_baseline_fixedlong<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/DescriptiveStat_Wheat_baseline_fixedlong.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Wheat_fixedlong_fixedmedium<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/DescriptiveStat_Wheat_fixedlong_fixedmedium.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Wheat_fixedlong_onset_long<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/DescriptiveStat_Wheat_fixedlong_onset_long.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Wheat_fixedlong_onset_long_suppl<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/DescriptiveStat_Wheat_fixedlong_onset_long_suppl.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Wheat_fixedlong_onset_medium<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/DescriptiveStat_Wheat_fixedlong_onset_medium.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Wheat_fixedlong_onset_medium_suppl<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/DescriptiveStat_Wheat_fixedlong_onset_medium_suppl.xlsx", sheet="Sheet1", col_names = FALSE)


DescriptiveStat_Wheat_All_Scenarios=bind_cols(Statistics,DescriptiveStat_Wheat_baseline_fixedlong,
                                              DescriptiveStat_Wheat_fixedlong_fixedmedium,
                                              DescriptiveStat_Wheat_fixedlong_onset_long,
                                              DescriptiveStat_Wheat_fixedlong_onset_long_suppl,
                                              DescriptiveStat_Wheat_fixedlong_onset_medium,
                                              DescriptiveStat_Wheat_fixedlong_onset_medium_suppl)

names(DescriptiveStat_Wheat_All_Scenarios)[1:7]=c("Statistics","Wheat_farmerpractice","Wheat_medium_long","Wheat_onset_long",
                                                  "Wheat_onset_long_suppl","Wheat_onset_medium","Wheat_onset_medium_suppl")


write.csv(DescriptiveStat_Wheat_All_Scenarios,"D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/DescriptiveStat_Wheat_All_Scenarios_FixedlongasBaseline.csv")
write.csv(DescriptiveStat_Wheat_All_Scenarios,"DescriptiveStat_Wheat_All_Scenarios_FixedlongasBaseline.csv")

# Import price sensitive analysis ----------------------------------------------------------------

## Rice ------------------------------------------------------------------------------------------
PriceSensitivity_Rice_baseline_fixedlong=import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/PriceSensitivity_Rice_baseline_fixedlong.xlsx", sheet="Sheet1", col_names = FALSE)
names(PriceSensitivity_Rice_baseline_fixedlong)[1:3]=c("Rice_baseline_fixedlong_cost_share","Rice_baseline_fixedlong_share_in_green","Rice_baseline_fixedlong_share_in_red")

PriceSensitivity_Rice_fixedlong_fixedmedium=import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/PriceSensitivity_Rice_fixedlong_fixedmedium.xlsx", sheet="Sheet1", col_names = FALSE)
names(PriceSensitivity_Rice_fixedlong_fixedmedium)[1:3]=c("Rice_fixedlong_fixedmedium_cost_share","Rice_fixedlong_fixedmedium_share_in_green","Rice_fixedlong_fixedmedium_share_in_red")

PriceSensitivity_Rice_fixedlong_onset_long=import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/PriceSensitivity_Rice_fixedlong_onset_long.xlsx", sheet="Sheet1", col_names = FALSE)
names(PriceSensitivity_Rice_fixedlong_onset_long)[1:3]=c("Rice_fixedlong_onset_long_cost_share","Rice_fixedlong_onset_long_share_in_green","Rice_baseline_fixedlong_share_in_red")

PriceSensitivity_Rice_fixedlong_onset_long_suppl=import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/PriceSensitivity_Rice_fixedlong_onset_long_suppl.xlsx", sheet="Sheet1", col_names = FALSE)
names(PriceSensitivity_Rice_fixedlong_onset_long_suppl)[1:3]=c("Rice_fixedlong_onset_long_suppl_cost_share","Rice_fixedlong_onset_long_suppl_share_in_green","Rice_fixedlong_onset_long_suppl_share_in_red")

PriceSensitivity_Rice_fixedlong_onset_medium=import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/PriceSensitivity_Rice_fixedlong_onset_medium.xlsx", sheet="Sheet1", col_names = FALSE)
names(PriceSensitivity_Rice_fixedlong_onset_medium)[1:3]=c("Rice_fixedlong_onset_medium_cost_share","Rice_fixedlong_onset_medium_share_in_green","Rice_fixedlong_onset_medium_share_in_red")

PriceSensitivity_Rice_fixedlong_onset_medium_suppl=import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/PriceSensitivity_Rice_fixedlong_onset_medium_suppl.xlsx", sheet="Sheet1", col_names = FALSE)
names(PriceSensitivity_Rice_fixedlong_onset_medium_suppl)[1:3]=c("Rice_fixedlong_onset_medium_suppl_cost_share","Rice_fixedlong_onset_medium_suppl_share_in_green","Rice_fixedlong_onset_medium_suppl_share_in_red")


PriceSensitivity_Rice_ALL=bind_cols(PriceSensitivity_Rice_baseline_fixedlong,PriceSensitivity_Rice_fixedlong_fixedmedium,
                                    PriceSensitivity_Rice_fixedlong_onset_long,PriceSensitivity_Rice_fixedlong_onset_long_suppl,
                                    PriceSensitivity_Rice_fixedlong_onset_medium,PriceSensitivity_Rice_fixedlong_onset_medium_suppl)

PriceSensitivity_Rice_ALL_green=subset(PriceSensitivity_Rice_ALL,select=c("Rice_baseline_fixedlong_cost_share","Rice_baseline_fixedlong_share_in_green",
                                                                          "Rice_fixedlong_fixedmedium_share_in_green","Rice_fixedlong_onset_long_share_in_green",
                                                                          "Rice_fixedlong_onset_long_suppl_share_in_green","Rice_fixedlong_onset_medium_share_in_green",
                                                                          "Rice_fixedlong_onset_medium_suppl_share_in_green"))
library(data.table)
PriceSensitivity_Rice_ALL_green_long <- melt(setDT(PriceSensitivity_Rice_ALL_green), id.vars = c("Rice_baseline_fixedlong_cost_share"),value.name=c("share_in_green") ,variable.name = "Clearly_better")

names(PriceSensitivity_Rice_ALL_green_long)[1]="Price_sensitivity"

PriceSensitivity_Rice_ALL_green_long$Scenario[PriceSensitivity_Rice_ALL_green_long$Clearly_better=="Rice_baseline_fixedlong_share_in_green"]="Farmer practice"
PriceSensitivity_Rice_ALL_green_long$Scenario[PriceSensitivity_Rice_ALL_green_long$Clearly_better=="Rice_fixedlong_fixedmedium_share_in_green"]="Rice fixed medium"
PriceSensitivity_Rice_ALL_green_long$Scenario[PriceSensitivity_Rice_ALL_green_long$Clearly_better=="Rice_fixedlong_onset_long_share_in_green"]="Rice onset long"
PriceSensitivity_Rice_ALL_green_long$Scenario[PriceSensitivity_Rice_ALL_green_long$Clearly_better=="Rice_fixedlong_onset_long_suppl_share_in_green"]="Rice onset long suppl"
PriceSensitivity_Rice_ALL_green_long$Scenario[PriceSensitivity_Rice_ALL_green_long$Clearly_better=="Rice_fixedlong_onset_medium_share_in_green"]="Rice onset medium"
PriceSensitivity_Rice_ALL_green_long$Scenario[PriceSensitivity_Rice_ALL_green_long$Clearly_better=="Rice_fixedlong_onset_medium_suppl_share_in_green"]="Rice onset medium suppl"






library(ggplot2)
PriceSensitivity_Rice_ALL_greenplot<-ggplot(PriceSensitivity_Rice_ALL_green_long, aes(x=Price_sensitivity, y=share_in_green, color=Scenario)) +
  geom_line(size=1.1)+
  #scale_size_manual(values = c(4,2,2,2,2,2) ) +
  scale_color_manual( values = c("steelblue", "darkgreen", "darkred", "orange","black","grey"))+
  scale_x_continuous(limits=c(-1,21),expand=c(0,0),breaks=seq(0,21,4))+
  scale_y_continuous(limits=c(0,1),expand=c(0,0),breaks=seq(0,1,0.1))+
  theme(axis.text.x = element_text(size=12,color="black"))+
  labs(y="Technology clearly beneficial \n (share of farms)",x="x input-output price ratio(Rs.10)")
previous_theme <- theme_set(theme_bw())
PriceSensitivity_Rice_ALL_greenplot

ggsave("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/PriceSensitivity_Rice_ALL_greenplot_FixedlongasBaseline.png",dpi=300)







## Wheat -----------------------------------------------------------------------------------------
PriceSensitivity_wheat_baseline_fixedlong=import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/PriceSensitivity_wheat_baseline_fixedlong.xlsx", sheet="Sheet1", col_names = FALSE)
names(PriceSensitivity_wheat_baseline_fixedlong)[1:3]=c("wheat_baseline_fixedlong_cost_share","wheat_baseline_fixedlong_share_in_green","wheat_baseline_fixedlong_share_in_red")

PriceSensitivity_wheat_fixedlong_fixedmedium=import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/PriceSensitivity_wheat_fixedlong_fixedmedium.xlsx", sheet="Sheet1", col_names = FALSE)
names(PriceSensitivity_wheat_fixedlong_fixedmedium)[1:3]=c("wheat_fixedlong_fixedmedium_cost_share","wheat_fixedlong_fixedmedium_share_in_green","wheat_fixedlong_fixedmedium_share_in_red")

PriceSensitivity_wheat_fixedlong_onset_long=import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/PriceSensitivity_wheat_fixedlong_onset_long.xlsx", sheet="Sheet1", col_names = FALSE)
names(PriceSensitivity_wheat_fixedlong_onset_long)[1:3]=c("wheat_fixedlong_onset_long_cost_share","wheat_fixedlong_onset_long_share_in_green","wheat_fixedlong_onset_long_share_in_red")

PriceSensitivity_wheat_fixedlong_onset_long_suppl=import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/PriceSensitivity_wheat_fixedlong_onset_long_suppl.xlsx", sheet="Sheet1", col_names = FALSE)
names(PriceSensitivity_wheat_fixedlong_onset_long_suppl)[1:3]=c("wheat_fixedlong_onset_long_suppl_cost_share","wheat_fixedlong_onset_long_suppl_share_in_green","wheat_fixedlong_onset_long_suppl_share_in_red")

PriceSensitivity_wheat_fixedlong_onset_medium=import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/PriceSensitivity_wheat_fixedlong_onset_medium.xlsx", sheet="Sheet1", col_names = FALSE)
names(PriceSensitivity_wheat_fixedlong_onset_medium)[1:3]=c("wheat_fixedlong_onset_medium_cost_share","wheat_fixedlong_onset_medium_share_in_green","wheat_fixedlong_onset_medium_share_in_red")

PriceSensitivity_wheat_fixedlong_onset_medium_suppl=import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/PriceSensitivity_wheat_fixedlong_onset_medium_suppl.xlsx", sheet="Sheet1", col_names = FALSE)
names(PriceSensitivity_wheat_fixedlong_onset_medium_suppl)[1:3]=c("wheat_fixedlong_onset_medium_suppl_cost_share","wheat_fixedlong_onset_medium_suppl_share_in_green","wheat_fixedlong_onset_medium_suppl_share_in_red")

PriceSensitivity_wheat_ALL=bind_cols(PriceSensitivity_wheat_baseline_fixedlong,PriceSensitivity_wheat_fixedlong_fixedmedium,
                                     PriceSensitivity_wheat_fixedlong_onset_long,PriceSensitivity_wheat_fixedlong_onset_long_suppl,
                                     PriceSensitivity_wheat_fixedlong_onset_medium,PriceSensitivity_wheat_fixedlong_onset_medium_suppl)

PriceSensitivity_wheat_ALL_green=subset(PriceSensitivity_wheat_ALL,select=c("wheat_baseline_fixedlong_cost_share","wheat_baseline_fixedlong_share_in_green",
                                                                            "wheat_fixedlong_fixedmedium_share_in_green","wheat_fixedlong_onset_long_share_in_green",
                                                                            "wheat_fixedlong_onset_long_suppl_share_in_green","wheat_fixedlong_onset_medium_share_in_green",
                                                                            "wheat_fixedlong_onset_medium_suppl_share_in_green"))
library(data.table)
PriceSensitivity_wheat_ALL_green_long <- melt(setDT(PriceSensitivity_wheat_ALL_green), id.vars = c("wheat_baseline_fixedlong_cost_share"),value.name=c("share_in_green") ,variable.name = "Clearly_better")

names(PriceSensitivity_wheat_ALL_green_long)[1]="Price_sensitivity"

PriceSensitivity_wheat_ALL_green_long$Scenario[PriceSensitivity_wheat_ALL_green_long$Clearly_better=="wheat_baseline_fixedlong_share_in_green"]="Farmer practice"
PriceSensitivity_wheat_ALL_green_long$Scenario[PriceSensitivity_wheat_ALL_green_long$Clearly_better=="wheat_fixedlong_fixedmedium_share_in_green"]="Wheat fixed medium"
PriceSensitivity_wheat_ALL_green_long$Scenario[PriceSensitivity_wheat_ALL_green_long$Clearly_better=="wheat_fixedlong_onset_long_share_in_green"]="Wheat onset long"
PriceSensitivity_wheat_ALL_green_long$Scenario[PriceSensitivity_wheat_ALL_green_long$Clearly_better=="wheat_fixedlong_onset_long_suppl_share_in_green"]="Wheat onset long suppl"
PriceSensitivity_wheat_ALL_green_long$Scenario[PriceSensitivity_wheat_ALL_green_long$Clearly_better=="wheat_fixedlong_onset_medium_share_in_green"]="Wheat onset medium"
PriceSensitivity_wheat_ALL_green_long$Scenario[PriceSensitivity_wheat_ALL_green_long$Clearly_better=="wheat_fixedlong_onset_medium_suppl_share_in_green"]="Wheat onset medium suppl"


library(ggplot2)
PriceSensitivity_wheat_ALL_greenplot<-ggplot(PriceSensitivity_wheat_ALL_green_long, aes(x=Price_sensitivity, y=share_in_green, color=Scenario)) +
  geom_line(size=1.1)+
  #scale_size_manual(values = c(4,2,2,2,2,2) ) +
  scale_color_manual( values = c("steelblue", "darkgreen", "darkred", "orange","black","grey"))+
  scale_x_continuous(limits=c(-1,21),expand=c(0,0),breaks=seq(0,21,4))+
  scale_y_continuous(limits=c(0,1),expand=c(0,0),breaks=seq(0,1,0.1))+
  theme(axis.text.x = element_text(size=12,color="black"))+
  labs(y="Technology clearly beneficial \n (share of farms)",x="x input-output price ratio(Rs.10)")
previous_theme <- theme_set(theme_bw())
PriceSensitivity_wheat_ALL_greenplot

ggsave("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbaseline/PriceSensitivity_wheat_ALL_greenplot_FixedlongasBaseline.png",dpi=300)








# System Revenue frontier comparisons --------------------------------------------------
# Import RA --------------------------------------------------------------------

## RICE-WHEAT -----------------------------------------------------
RA_rice_wheat_farmer_practice_fixedlong<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_revenue/RA_rice_wheat_fixedlong_farmer_practice.xlsx", sheet="Sheet1", col_names = FALSE)
RA_rice_wheat_fixedlong_fixedmedium<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_revenue/RA_rice_wheat_fixedlong_fixedmedium.xlsx", sheet="Sheet1", col_names = FALSE)
RA_rice_wheat_fixedlong_onset_long<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_revenue/RA_rice_wheat_fixedlong_onset_long.xlsx", sheet="Sheet1", col_names = FALSE)
RA_rice_wheat_fixedlong_onset_medium<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_revenue/RA_rice_wheat_fixedlong_onset_medium.xlsx", sheet="Sheet1", col_names = FALSE)
RA_rice_wheat_fixedlong_onset_long_suppl<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_revenue/RA_rice_wheat_fixedlong_onset_long_suppl.xlsx", sheet="Sheet1", col_names = FALSE)
RA_rice_wheat_fixedlong_onset_medium_suppl<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_revenue/RA_rice_wheat_fixedlong_onset_medium_suppl.xlsx", sheet="Sheet1", col_names = FALSE)



# RA column names
# %  1 = cellID
# %  2 = Comparison Technology ID
# %  3 = Base Technology ID
# %  4 = Mean revenue for Comp
# %  5 = Standard Deviation of revenue for Comp
# %  6 = CV of revenue for Comp
# %  7 = Maximum revenue for Comp
# %  8 = Minimum revenue for Comp
# %  9 = Probability of Crop Failure for Comp
# % 10 = Min Proportion for Comp to SOSD Base
# % 11 = Mean revenue for Base
# % 12 = Standard Deviation of revenue for Base
# % 13 = CV of revenue for Base
# % 14 = Maximum revenue for Base
# % 15 = Minimum revenue for Base
# % 16 = Probability of Crop Failure for Base
# % 17 = Min Proportion for Base to SOSD Comp
# % 18 = Difference in mean Comp - Base
# % 19 = Difference in standard deviation Comp - Base
# % 20 = Difference in CV Comp - Base
# % 21 = Difference in Prob of Crop Failure Comp - Base
# % 22 = Min Proportion for Comp to SOSD Base divided by average base revenue
# % 23 = Min Proportion for Base to SOSD Comp divided by average base revenue
# % 24 = Comp More Risky (-1)/less Risky (1)/ Indeterminant (0) compared to Base
# % 25 = Wheat Area

columnnames=c("CellID","CompID","BaseID","Comprevenue_Mean","Comprevenue_SD",
              "Comprevenue_CV","Comprevenue_Max","Comprevenue_Min","CompCropFailureProb","CompMinPropSOSDBase",
              "Baserevenue_Mean","Baserevenue_SD","Baserevenue_CV","Baserevenue_Max","Baserevenue_Min",
              "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
              "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbaserevenue","MinProp_BaseSOSDComp_Divdbaserevenue",
              "Riskiness_Comp","RiceArea")

names(RA_rice_wheat_farmer_practice_fixedlong)[1:25]=c("CellID","CompID","BaseID","Comprevenue_Mean","Comprevenue_SD",
                                           "Comprevenue_CV","Comprevenue_Max","Comprevenue_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                           "Baserevenue_Mean","Baserevenue_SD","Baserevenue_CV","Baserevenue_Max","Baserevenue_Min",
                                           "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                           "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbaserevenue","MinProp_BaseSOSDComp_Divdbaserevenue",
                                           "Riskiness_Comp","RiceArea")

names(RA_rice_wheat_fixedlong_fixedmedium)[1:25]=c("CellID","CompID","BaseID","Comprevenue_Mean","Comprevenue_SD",
                                             "Comprevenue_CV","Comprevenue_Max","Comprevenue_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                             "Baserevenue_Mean","Baserevenue_SD","Baserevenue_CV","Baserevenue_Max","Baserevenue_Min",
                                             "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                             "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbaserevenue","MinProp_BaseSOSDComp_Divdbaserevenue",
                                             "Riskiness_Comp","RiceArea")

names(RA_rice_wheat_fixedlong_onset_long)[1:25]=c("CellID","CompID","BaseID","Comprevenue_Mean","Comprevenue_SD",
                                            "Comprevenue_CV","Comprevenue_Max","Comprevenue_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                            "Baserevenue_Mean","Baserevenue_SD","Baserevenue_CV","Baserevenue_Max","Baserevenue_Min",
                                            "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                            "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbaserevenue","MinProp_BaseSOSDComp_Divdbaserevenue",
                                            "Riskiness_Comp","RiceArea")

names(RA_rice_wheat_fixedlong_onset_medium)[1:25]=c("CellID","CompID","BaseID","Comprevenue_Mean","Comprevenue_SD",
                                              "Comprevenue_CV","Comprevenue_Max","Comprevenue_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                              "Baserevenue_Mean","Baserevenue_SD","Baserevenue_CV","Baserevenue_Max","Baserevenue_Min",
                                              "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                              "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbaserevenue","MinProp_BaseSOSDComp_Divdbaserevenue",
                                              "Riskiness_Comp","RiceArea")

names(RA_rice_wheat_fixedlong_onset_long_suppl)[1:25]=c("CellID","CompID","BaseID","Comprevenue_Mean","Comprevenue_SD",
                                                  "Comprevenue_CV","Comprevenue_Max","Comprevenue_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                                  "Baserevenue_Mean","Baserevenue_SD","Baserevenue_CV","Baserevenue_Max","Baserevenue_Min",
                                                  "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                                  "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbaserevenue","MinProp_BaseSOSDComp_Divdbaserevenue",
                                                  "Riskiness_Comp","RiceArea")

names(RA_rice_wheat_fixedlong_onset_medium_suppl)[1:25]=c("CellID","CompID","BaseID","Comprevenue_Mean","Comprevenue_SD",
                                                    "Comprevenue_CV","Comprevenue_Max","Comprevenue_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                                    "Baserevenue_Mean","Baserevenue_SD","Baserevenue_CV","Baserevenue_Max","Baserevenue_Min",
                                                    "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                                    "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbaserevenue","MinProp_BaseSOSDComp_Divdbaserevenue",
                                                    "Riskiness_Comp","RiceArea")

write.csv(RA_rice_wheat_farmer_practice_fixedlong,"D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_revenue/RA_rice_wheat_farmer_practice_fixedlong_rev.csv")
write.csv(RA_rice_wheat_fixedlong_fixedmedium,"D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_revenue/RA_rice_wheat_fixedlong_fixedmedium_rev.csv")
write.csv(RA_rice_wheat_fixedlong_onset_long,"D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_revenue/RA_rice_wheat_fixedlong_onset_long_rev.csv")
write.csv(RA_rice_wheat_fixedlong_onset_medium,"D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_revenue/RA_rice_wheat_fixedlong_onset_medium_rev.csv")
write.csv(RA_rice_wheat_fixedlong_onset_long_suppl,"D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_revenue/RA_rice_wheat_fixedlong_onset_long_suppl_rev.csv")
write.csv(RA_rice_wheat_fixedlong_onset_medium_suppl,"D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_revenue/RA_rice_wheat_fixedlong_onset_medium_suppl_rev.csv")

# # Import Descriptive stats -------------------------------
# %   1 = Weighted Mean   UB
# %   2 = Weighted S.D.   UB
# %   3 = Minimum         UB
# %   4 = 10th Percentile UB
# %   5 = 25th Percentile UB
# %   6 = Median          UB
# %   7 = 75th Percentile UB
# %   8 = 90th Percentile UB
# %   9 = Maximum         UB
# %  10 = Weighted Mean   LB
# %  11 = Weighted S.D.   LB
# %  12 = Minimum         LB
# %  13 = 10th Percentile LB
# %  14 = 25th Percentile LB
# %  15 = Median          LB
# %  16 = 75th Percentile LB
# %  17 = 90th Percentile LB
# %  18 = Maximum         LB
# %  19 = Proportion of Acres in Green
# %  20 = Proportion of Acres in Yellow
# %  21 = Proportion of Acres in Red
# %  22 = Total Acres
# %  23 = Number of Cells

## Rice-Wheat -------------------------------------------------
Statistics=c("WeightedMean_UB","WeightedSD_UB","Min_UB","Percentile10_UB","Percentile25_UB","Median_UB","Percentile75_UB","Percentile90_UB","Max_UB",
             "WeightedMean_LB","WeightedSD_LB","Min_LB","Percentile10_LB","Percentile25_LB","Median_LB","Percentile75_LB","Percentile90_LB","Max_LB",
             "PropLandinGreen","PropLandinYellow","PropLandinRed","TotalAcres","NumberofCells")

Statistics=as.data.frame(Statistics)

DescriptiveStat_Rice_farmer_practice_fixedlong<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_revenue/DescriptiveStat_rice_wheat_fixedlong_farmer_practice.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Rice_fixedlong_fixedmedium<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_revenue/DescriptiveStat_rice_wheat_fixedlong_fixedmedium.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Rice_fixedlong_onset_long<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_revenue/DescriptiveStat_rice_wheat_fixedlong_onset_long.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Rice_fixedlong_onset_long_suppl<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_revenue/DescriptiveStat_rice_wheat_fixedlong_onset_long_suppl.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Rice_fixedlong_onset_medium<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_revenue/DescriptiveStat_rice_wheat_fixedlong_onset_medium.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Rice_fixedlong_onset_medium_suppl<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_revenue/DescriptiveStat_rice_wheat_fixedlong_onset_medium_suppl.xlsx", sheet="Sheet1", col_names = FALSE)


DescriptiveStat_Rice_Wheat_All_Scenarios=bind_cols(Statistics,DescriptiveStat_Rice_farmer_practice_fixedlong,
                                             DescriptiveStat_Rice_fixedlong_fixedmedium,
                                             DescriptiveStat_Rice_fixedlong_onset_long,
                                             DescriptiveStat_Rice_fixedlong_onset_long_suppl,
                                             DescriptiveStat_Rice_fixedlong_onset_medium,
                                             DescriptiveStat_Rice_fixedlong_onset_medium_suppl)

names(DescriptiveStat_Rice_Wheat_All_Scenarios)[1:7]=c("Statistics","Rice_Wheat_farmerpractice","Rice_Wheat_medium_long","Rice_Wheat_onset_long",
                                                 "Rice_Wheat_onset_long_suppl","Rice_Wheat_onset_medium","Rice_Wheat_onset_medium_suppl")


write.csv(DescriptiveStat_Rice_Wheat_All_Scenarios,"D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_revenue/DescriptiveStat_Rice_Wheat_Revenue_All_Scenarios_FixedLongasBaseline.csv")




# Partial profit --------------------------------------------------------------

## RICE-WHEAT -----------------------------------------------------
RA_rice_wheat_farmer_practice_fixedlong<- import("code/Octave_Bihar_PartialProfit/RA_rice_wheat_fixedlong_farmer_practice.xlsx", sheet="Sheet1", col_names = FALSE)
RA_rice_wheat_fixedlong_fixedmedium<- import("code/Octave_Bihar_PartialProfit/RA_rice_wheat_fixedlong_fixedmedium.xlsx", sheet="Sheet1", col_names = FALSE)
RA_rice_wheat_fixedlong_onset_long<- import("code/Octave_Bihar_PartialProfit/RA_rice_wheat_fixedlong_onset_long.xlsx", sheet="Sheet1", col_names = FALSE)
RA_rice_wheat_fixedlong_onset_medium<- import("code/Octave_Bihar_PartialProfit/RA_rice_wheat_fixedlong_onset_medium.xlsx", sheet="Sheet1", col_names = FALSE)
RA_rice_wheat_fixedlong_onset_long_suppl<- import("code/Octave_Bihar_PartialProfit/RA_rice_wheat_fixedlong_onset_long_suppl.xlsx", sheet="Sheet1", col_names = FALSE)
RA_rice_wheat_fixedlong_onset_medium_suppl<- import("code/Octave_Bihar_PartialProfit/RA_rice_wheat_fixedlong_onset_medium_suppl.xlsx", sheet="Sheet1", col_names = FALSE)



# RA column names
# %  1 = cellID
# %  2 = Comparison Technology ID
# %  3 = Base Technology ID
# %  4 = Mean pprofenue for Comp
# %  5 = Standard Deviation of pprofenue for Comp
# %  6 = CV of pprofenue for Comp
# %  7 = Maximum pprofenue for Comp
# %  8 = Minimum pprofenue for Comp
# %  9 = Probability of Crop Failure for Comp
# % 10 = Min Proportion for Comp to SOSD Base
# % 11 = Mean pprofenue for Base
# % 12 = Standard Deviation of pprofenue for Base
# % 13 = CV of pprofenue for Base
# % 14 = Maximum pprofenue for Base
# % 15 = Minimum pprofenue for Base
# % 16 = Probability of Crop Failure for Base
# % 17 = Min Proportion for Base to SOSD Comp
# % 18 = Difference in mean Comp - Base
# % 19 = Difference in standard deviation Comp - Base
# % 20 = Difference in CV Comp - Base
# % 21 = Difference in Prob of Crop Failure Comp - Base
# % 22 = Min Proportion for Comp to SOSD Base divided by average base pprofenue
# % 23 = Min Proportion for Base to SOSD Comp divided by average base pprofenue
# % 24 = Comp More Risky (-1)/less Risky (1)/ Indeterminant (0) compared to Base
# % 25 = Wheat Area

columnnames=c("CellID","CompID","BaseID","Comppartialprofit_Mean","Comppartialprofit_SD",
              "Comppartialprofit_CV","Comppartialprofit_Max","Comppartialprofit_Min","CompCropFailureProb","CompMinPropSOSDBase",
              "Basepartialprofit_Mean","Basepartialprofit_SD","Basepartialprofit_CV","Basepartialprofit_Max","Basepartialprofit_Min",
              "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
              "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbasepartialprofit","MinProp_BaseSOSDComp_Divdbasepartialprofit",
              "Riskiness_Comp","RiceArea")

names(RA_rice_wheat_farmer_practice_fixedlong)[1:25]=c("CellID","CompID","BaseID","Comppartialprofit_Mean","Comppartialprofit_SD",
                                                       "Comppartialprofit_CV","Comppartialprofit_Max","Comppartialprofit_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                                       "Basepartialprofit_Mean","Basepartialprofit_SD","Basepartialprofit_CV","Basepartialprofit_Max","Basepartialprofit_Min",
                                                       "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                                       "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbasepartialprofit","MinProp_BaseSOSDComp_Divdbasepartialprofit",
                                                       "Riskiness_Comp","RiceArea")

names(RA_rice_wheat_fixedlong_fixedmedium)[1:25]=c("CellID","CompID","BaseID","Comppartialprofit_Mean","Comppartialprofit_SD",
                                                   "Comppartialprofit_CV","Comppartialprofit_Max","Comppartialprofit_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                                   "Basepartialprofit_Mean","Basepartialprofit_SD","Basepartialprofit_CV","Basepartialprofit_Max","Basepartialprofit_Min",
                                                   "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                                   "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbasepartialprofit","MinProp_BaseSOSDComp_Divdbasepartialprofit",
                                                   "Riskiness_Comp","RiceArea")

names(RA_rice_wheat_fixedlong_onset_long)[1:25]=c("CellID","CompID","BaseID","Comppartialprofit_Mean","Comppartialprofit_SD",
                                                  "Comppartialprofit_CV","Comppartialprofit_Max","Comppartialprofit_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                                  "Basepartialprofit_Mean","Basepartialprofit_SD","Basepartialprofit_CV","Basepartialprofit_Max","Basepartialprofit_Min",
                                                  "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                                  "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbasepartialprofit","MinProp_BaseSOSDComp_Divdbasepartialprofit",
                                                  "Riskiness_Comp","RiceArea")

names(RA_rice_wheat_fixedlong_onset_medium)[1:25]=c("CellID","CompID","BaseID","Comppartialprofit_Mean","Comppartialprofit_SD",
                                                    "Comppartialprofit_CV","Comppartialprofit_Max","Comppartialprofit_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                                    "Basepartialprofit_Mean","Basepartialprofit_SD","Basepartialprofit_CV","Basepartialprofit_Max","Basepartialprofit_Min",
                                                    "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                                    "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbasepartialprofit","MinProp_BaseSOSDComp_Divdbasepartialprofit",
                                                    "Riskiness_Comp","RiceArea")

names(RA_rice_wheat_fixedlong_onset_long_suppl)[1:25]=c("CellID","CompID","BaseID","Comppartialprofit_Mean","Comppartialprofit_SD",
                                                        "Comppartialprofit_CV","Comppartialprofit_Max","Comppartialprofit_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                                        "Basepartialprofit_Mean","Basepartialprofit_SD","Basepartialprofit_CV","Basepartialprofit_Max","Basepartialprofit_Min",
                                                        "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                                        "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbasepartialprofit","MinProp_BaseSOSDComp_Divdbasepartialprofit",
                                                        "Riskiness_Comp","RiceArea")

names(RA_rice_wheat_fixedlong_onset_medium_suppl)[1:25]=c("CellID","CompID","BaseID","Comppartialprofit_Mean","Comppartialprofit_SD",
                                                          "Comppartialprofit_CV","Comppartialprofit_Max","Comppartialprofit_Min","CompCropFailureProb","CompMinPropSOSDBase",
                                                          "Basepartialprofit_Mean","Basepartialprofit_SD","Basepartialprofit_CV","Basepartialprofit_Max","Basepartialprofit_Min",
                                                          "BaseCropFailureProb","BaseMinPropSOSDComp","Diff_Mean_CompBase","Diff_SD_CompBase","Diff_CV_CompBase",
                                                          "Diff_CropFailureProbCompBase","MinProp_CompSOSDBase_Divdbasepartialprofit","MinProp_BaseSOSDComp_Divdbasepartialprofit",
                                                          "Riskiness_Comp","RiceArea")

write.csv(RA_rice_wheat_farmer_practice_fixedlong,"code/Octave_Bihar_PartialProfit/RA_rice_wheat_farmer_practice_fixedlong_pprof.csv")
write.csv(RA_rice_wheat_fixedlong_fixedmedium,"code/Octave_Bihar_PartialProfit/RA_rice_wheat_fixedlong_fixedmedium_pprof.csv")
write.csv(RA_rice_wheat_fixedlong_onset_long,"code/Octave_Bihar_PartialProfit/RA_rice_wheat_fixedlong_onset_long_pprof.csv")
write.csv(RA_rice_wheat_fixedlong_onset_medium,"code/Octave_Bihar_PartialProfit/RA_rice_wheat_fixedlong_onset_medium_pprof.csv")
write.csv(RA_rice_wheat_fixedlong_onset_long_suppl,"code/Octave_Bihar_PartialProfit/RA_rice_wheat_fixedlong_onset_long_suppl_pprof.csv")
write.csv(RA_rice_wheat_fixedlong_onset_medium_suppl,"code/Octave_Bihar_PartialProfit/RA_rice_wheat_fixedlong_onset_medium_suppl_pprof.csv")

# # Import Descriptive stats -------------------------------
# %   1 = Weighted Mean   UB
# %   2 = Weighted S.D.   UB
# %   3 = Minimum         UB
# %   4 = 10th Percentile UB
# %   5 = 25th Percentile UB
# %   6 = Median          UB
# %   7 = 75th Percentile UB
# %   8 = 90th Percentile UB
# %   9 = Maximum         UB
# %  10 = Weighted Mean   LB
# %  11 = Weighted S.D.   LB
# %  12 = Minimum         LB
# %  13 = 10th Percentile LB
# %  14 = 25th Percentile LB
# %  15 = Median          LB
# %  16 = 75th Percentile LB
# %  17 = 90th Percentile LB
# %  18 = Maximum         LB
# %  19 = Proportion of Acres in Green
# %  20 = Proportion of Acres in Yellow
# %  21 = Proportion of Acres in Red
# %  22 = Total Acres
# %  23 = Number of Cells

## Rice-Wheat -------------------------------------------------
Statistics=c("WeightedMean_UB","WeightedSD_UB","Min_UB","Percentile10_UB","Percentile25_UB","Median_UB","Percentile75_UB","Percentile90_UB","Max_UB",
             "WeightedMean_LB","WeightedSD_LB","Min_LB","Percentile10_LB","Percentile25_LB","Median_LB","Percentile75_LB","Percentile90_LB","Max_LB",
             "PropLandinGreen","PropLandinYellow","PropLandinRed","TotalAcres","NumberofCells")

Statistics=as.data.frame(Statistics)

DescriptiveStat_Rice_farmer_practice_fixedlong<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_partialprofit/DescriptiveStat_rice_wheat_fixedlong_farmer_practice.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Rice_fixedlong_fixedmedium<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_partialprofit/DescriptiveStat_rice_wheat_fixedlong_fixedmedium.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Rice_fixedlong_onset_long<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_partialprofit/DescriptiveStat_rice_wheat_fixedlong_onset_long.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Rice_fixedlong_onset_long_suppl<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_partialprofit/DescriptiveStat_rice_wheat_fixedlong_onset_long_suppl.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Rice_fixedlong_onset_medium<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_partialprofit/DescriptiveStat_rice_wheat_fixedlong_onset_medium.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Rice_fixedlong_onset_medium_suppl<- import("D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_partialprofit/DescriptiveStat_rice_wheat_fixedlong_onset_medium_suppl.xlsx", sheet="Sheet1", col_names = FALSE)


DescriptiveStat_Rice_Wheat_All_Scenarios=bind_cols(Statistics,DescriptiveStat_Rice_farmer_practice_fixedlong,
                                                   DescriptiveStat_Rice_fixedlong_fixedmedium,
                                                   DescriptiveStat_Rice_fixedlong_onset_long,
                                                   DescriptiveStat_Rice_fixedlong_onset_long_suppl,
                                                   DescriptiveStat_Rice_fixedlong_onset_medium,
                                                   DescriptiveStat_Rice_fixedlong_onset_medium_suppl)

names(DescriptiveStat_Rice_Wheat_All_Scenarios)[1:7]=c("Statistics","Rice_Wheat_farmerpractice","Rice_Wheat_medium_long","Rice_Wheat_onset_long",
                                                       "Rice_Wheat_onset_long_suppl","Rice_Wheat_onset_medium","Rice_Wheat_onset_medium_suppl")


write.csv(DescriptiveStat_Rice_Wheat_All_Scenarios,"D:/OneDrive/CIMMYT/Papers/AntonCropSim/code/pairwisefixedlongasbase_partialprofit/DescriptiveStat_Rice_Wheat_partialprofit_All_Scenarios_FixedLongasBaseline.csv")







