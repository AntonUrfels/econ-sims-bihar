%pkg install io-2.6.4.tar.gz
pkg load io


# RENTED Models ----------------------------------------------------------------

% 1 rice_wheat-Wheat fixed long versus farmer practice ---------------------------------------------
ndataseq01060216=xlsread('rice_wheat_farmer_practice_fixedlong_rented_pprof_IGP.xlsx')
CreateWTPBoundsbyCell
CreateTableData

xlswrite('RA_rice_wheat_fixedlong_farmer_practice_IGP.xlsx',RA)
xlswrite('DescriptiveStat_rice_wheat_fixedlong_farmer_practice.xlsx',DescriptiveStat)

clear
RA=xlsread('RA_rice_wheat_fixedlong_farmer_practice_IGP.xlsx')
CreateFigureData
xlswrite('CELL30MIDMAP_rice_wheat_fixedlong_farmer_practice.xlsx',CELL30MIDMAP)
xlswrite('Price_wheatSensitivity_rice_wheat_fixedlong_farmer_practice.xlsx',PriceSensitivity)


% 2 rice_wheat fixedlong versus fixed medium --------------------------------------------
clear
ndataseq01060216=xlsread('rice_wheat_fixed_medium_fixedlong_rented_pprof_IGP.xlsx')
CreateWTPBoundsbyCell
CreateTableData

%CreateFigureData
xlswrite('RA_rice_wheat_fixedlong_fixedmedium_IGP.xlsx',RA)
#xlswrite('RAwOutliers.xlsx',RAwOutliers)
%xlswrite('CELL30MIDMAP.xlsx',CELL30MIDMAP)
xlswrite('DescriptiveStat_rice_wheat_fixedlong_fixedmedium.xlsx',DescriptiveStat)
%xlswrite('Price_wheatSensitivity.xlsx',Price_wheatSensitivity)

clear
RA=xlsread('RA_rice_wheat_fixedlong_fixedmedium_IGP.xlsx')
CreateFigureData
xlswrite('CELL30MIDMAP_rice_wheat_fixedlong_fixedmedium.xlsx',CELL30MIDMAP)
xlswrite('Price_wheatSensitivity_rice_wheat_fixedlong_fixedmedium.xlsx',PriceSensitivity)



% 3 rice_wheat fixedlong versus onset long --------------------------------------------
clear
ndataseq01060216=xlsread('rice_wheat_onset_long_fixedlong_rented_pprof_IGP.xlsx')
CreateWTPBoundsbyCell
CreateTableData

%CreateFigureData
xlswrite('RA_rice_wheat_fixedlong_onset_long_IGP.xlsx',RA)
#xlswrite('RAwOutliers.xlsx',RAwOutliers)
%xlswrite('CELL30MIDMAP.xlsx',CELL30MIDMAP)
xlswrite('DescriptiveStat_rice_wheat_fixedlong_onset_long.xlsx',DescriptiveStat)
%xlswrite('Price_wheatSensitivity.xlsx',Price_wheatSensitivity)


clear
RA=xlsread('RA_rice_wheat_fixedlong_onset_long_IGP.xlsx')
CreateFigureData
xlswrite('CELL30MIDMAP_rice_wheat_fixedlong_onset_long.xlsx',CELL30MIDMAP)
xlswrite('Price_wheatSensitivity_rice_wheat_fixedlong_onset_long.xlsx',PriceSensitivity)



% 4 rice_wheat fixedlong versus onset medium
clear
ndataseq01060216=xlsread('rice_wheat_onset_medium_fixedlong_rented_pprof_IGP.xlsx')
CreateWTPBoundsbyCell
CreateTableData

%CreateFigureData
xlswrite('RA_rice_wheat_fixedlong_onset_medium_IGP.xlsx',RA)
#xlswrite('RAwOutliers.xlsx',RAwOutliers)
%xlswrite('CELL30MIDMAP.xlsx',CELL30MIDMAP)
xlswrite('DescriptiveStat_rice_wheat_fixedlong_onset_medium.xlsx',DescriptiveStat)
%xlswrite('Price_wheatSensitivity.xlsx',Price_wheatSensitivity)


clear
RA=xlsread('RA_rice_wheat_fixedlong_onset_medium_IGP.xlsx')
CreateFigureData
xlswrite('CELL30MIDMAP_rice_wheat_fixedlong_onset_medium.xlsx',CELL30MIDMAP)
xlswrite('Price_wheatSensitivity_rice_wheat_fixedlong_onset_medium.xlsx',PriceSensitivity)

% 5 rice_wheat fixedlong versus onset long suppl
clear
ndataseq01060216=xlsread('rice_wheat_onset_long_suppl_fixedlong_rented_pprof_IGP.xlsx')
CreateWTPBoundsbyCell
CreateTableData

%CreateFigureData
xlswrite('RA_rice_wheat_fixedlong_onset_long_suppl_IGP.xlsx',RA)
#xlswrite('RAwOutliers.xlsx',RAwOutliers)
%xlswrite('CELL30MIDMAP.xlsx',CELL30MIDMAP)
xlswrite('DescriptiveStat_rice_wheat_fixedlong_onset_long_suppl.xlsx',DescriptiveStat)
%xlswrite('Price_wheatSensitivity.xlsx',Price_wheatSensitivity)

clear
RA=xlsread('RA_rice_wheat_fixedlong_onset_long_suppl_IGP.xlsx')
CreateFigureData
xlswrite('CELL30MIDMAP_rice_wheat_fixedlong_onset_long_suppl.xlsx',CELL30MIDMAP)
xlswrite('Price_wheatSensitivity_rice_wheat_fixedlong_onset_long_suppl.xlsx',PriceSensitivity)

% 6 rice_wheat fixedlong versus onset medium suppl
clear
ndataseq01060216=xlsread('rice_wheat_onset_medium_suppl_fixedlong_rented_pprof_IGP.xlsx')
CreateWTPBoundsbyCell
CreateTableData

xlswrite('RA_rice_wheat_fixedlong_onset_medium_suppl_IGP.xlsx',RA)
#xlswrite('RAwOutliers.xlsx',RAwOutliers)
%xlswrite('CELL30MIDMAP.xlsx',CELL30MIDMAP)
xlswrite('DescriptiveStat_rice_wheat_fixedlong_onset_medium_suppl.xlsx',DescriptiveStat)
%xlswrite('Price_wheatSensitivity.xlsx',Price_wheatSensitivity)

clear
RA=xlsread('RA_rice_wheat_fixedlong_onset_medium_suppl_IGP.xlsx')
CreateFigureData
xlswrite('CELL30MIDMAP_rice_wheat_fixedlong_onset_medium_suppl.xlsx',CELL30MIDMAP)
xlswrite('Price_wheatSensitivity_rice_wheat_fixedlong_onset_medium_suppl.xlsx',PriceSensitivity)











