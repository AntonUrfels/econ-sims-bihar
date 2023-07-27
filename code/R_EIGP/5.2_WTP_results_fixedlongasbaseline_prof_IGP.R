library(rio)
library(dplyr)


# System profit frontier comparisons --------------------------------------------------
# Import RA --------------------------------------------------------------------

## RICE-WHEAT -----------------------------------------------------
RA_rice_wheat_farmer_practice_fixedlong<- import("code/Octace_IGP_PartialProfit/RA_rice_wheat_fixedlong_farmer_practice_IGP.xlsx", sheet="Sheet1", col_names = FALSE)
RA_rice_wheat_fixedlong_fixedmedium<- import("code/Octace_IGP_PartialProfit/RA_rice_wheat_fixedlong_fixedmedium_IGP.xlsx", sheet="Sheet1", col_names = FALSE)
RA_rice_wheat_fixedlong_onset_long<- import("code/Octace_IGP_PartialProfit/RA_rice_wheat_fixedlong_onset_long_IGP.xlsx", sheet="Sheet1", col_names = FALSE)
RA_rice_wheat_fixedlong_onset_medium<- import("code/Octace_IGP_PartialProfit/RA_rice_wheat_fixedlong_onset_medium_IGP.xlsx", sheet="Sheet1", col_names = FALSE)
RA_rice_wheat_fixedlong_onset_long_suppl<- import("code/Octace_IGP_PartialProfit/RA_rice_wheat_fixedlong_onset_long_suppl_IGP.xlsx", sheet="Sheet1", col_names = FALSE)
RA_rice_wheat_fixedlong_onset_medium_suppl<- import("code/Octace_IGP_PartialProfit/RA_rice_wheat_fixedlong_onset_medium_suppl_IGP.xlsx", sheet="Sheet1", col_names = FALSE)



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

write.csv(RA_rice_wheat_farmer_practice_fixedlong,"data/maxwell_output_fixedLong_revenue_IGP/RA_rice_wheat_farmer_practice_fixedlong_rev_IGP.csv")
write.csv(RA_rice_wheat_fixedlong_fixedmedium,"data/maxwell_output_fixedLong_revenue_IGP/RA_rice_wheat_fixedlong_fixedmedium_rev_IGP.csv")
write.csv(RA_rice_wheat_fixedlong_onset_long,"data/maxwell_output_fixedLong_revenue_IGP/RA_rice_wheat_fixedlong_onset_long_rev_IGP.csv")
write.csv(RA_rice_wheat_fixedlong_onset_medium,"data/maxwell_output_fixedLong_revenue_IGP/RA_rice_wheat_fixedlong_onset_medium_rev_IGP.csv")
write.csv(RA_rice_wheat_fixedlong_onset_long_suppl,"data/maxwell_output_fixedLong_revenue_IGP/RA_rice_wheat_fixedlong_onset_long_suppl_rev_IGP.csv")
write.csv(RA_rice_wheat_fixedlong_onset_medium_suppl,"data/maxwell_output_fixedLong_revenue_IGP/RA_rice_wheat_fixedlong_onset_medium_suppl_rev_IGP.csv")

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

DescriptiveStat_Rice_farmer_practice_fixedlong<- import("code/Octace_IGP_Revenue/DescriptiveStat_rice_wheat_fixedlong_farmer_practice_IGP.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Rice_fixedlong_fixedmedium<- import("code/Octace_IGP_Revenue/DescriptiveStat_rice_wheat_fixedlong_fixedmedium_IGP.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Rice_fixedlong_onset_long<- import("code/Octace_IGP_Revenue/DescriptiveStat_rice_wheat_fixedlong_onset_long_IGP.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Rice_fixedlong_onset_medium<- import("code/Octace_IGP_Revenue/DescriptiveStat_rice_wheat_fixedlong_onset_medium_IGP.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Rice_fixedlong_onset_long_suppl<- import("code/Octace_IGP_Revenue/DescriptiveStat_rice_wheat_fixedlong_onset_long_suppl_IGP.xlsx", sheet="Sheet1", col_names = FALSE)
DescriptiveStat_Rice_fixedlong_onset_medium_suppl<- import("code/Octace_IGP_Revenue/DescriptiveStat_rice_wheat_fixedlong_onset_medium_suppl_IGP.xlsx", sheet="Sheet1", col_names = FALSE)


DescriptiveStat_Rice_Wheat_All_Scenarios=bind_cols(Statistics,DescriptiveStat_Rice_farmer_practice_fixedlong,
                                                   DescriptiveStat_Rice_fixedlong_fixedmedium,
                                                   DescriptiveStat_Rice_fixedlong_onset_long,
                                                   DescriptiveStat_Rice_fixedlong_onset_long_suppl,
                                                   DescriptiveStat_Rice_fixedlong_onset_medium,
                                                   DescriptiveStat_Rice_fixedlong_onset_medium_suppl)

names(DescriptiveStat_Rice_Wheat_All_Scenarios)[1:7]=c("Statistics","Rice_Wheat_farmerpractice","Rice_Wheat_medium_long","Rice_Wheat_onset_long",
                                                       "Rice_Wheat_onset_long_suppl","Rice_Wheat_onset_medium","Rice_Wheat_onset_medium_suppl")


write.csv(DescriptiveStat_Rice_Wheat_All_Scenarios,"DescriptiveStat_Rice_Wheat_All_Scenarios_revenue_IGP.csv")
