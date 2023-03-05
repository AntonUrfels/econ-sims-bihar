%pkg install io-2.6.4.tar.gz
pkg load io


% 1 Rice fixedlong versus fixed long ---------------------------------------------
ndataseq01060216=xlsread('rice_baseline_fixedlong_IGP.xlsx')
CreateWTPBoundsbyCell
#CreateTableData


xlswrite('RA_Rice_baseline_fixedlong.xlsx',RA)
#xlswrite('RAwOutliers.xlsx',RAwOutliers)
%xlswrite('CELL30MIDMAP.xlsx',CELL30MIDMAP)
#xlswrite('DescriptiveStat_Rice_fixedlong_fixedlong.xlsx',DescriptiveStat)
%xlswrite('PriceSensitivity.xlsx',PriceSensitivity)

clear
RA=xlsread('RA_Rice_baseline_fixedlong.xlsx')
CreateFigureData
xlswrite('CELL30MIDMAP_Rice_fixedlong_fixedlong.xlsx',CELL30MIDMAP)
xlswrite('PriceSensitivity_Rice_fixedlong_fixedlong.xlsx',PriceSensitivity)


% 2 Rice fixedlong versus fixed medium --------------------------------------------
clear
ndataseq01060216=xlsread('rice_fixedlong_fixedmedium_IGP.xlsx')
CreateWTPBoundsbyCell
CreateTableData

%CreateFigureData
xlswrite('RA_Rice_fixedlong_fixedmedium.xlsx',RA)
#xlswrite('RAwOutliers.xlsx',RAwOutliers)
%xlswrite('CELL30MIDMAP.xlsx',CELL30MIDMAP)
xlswrite('DescriptiveStat_Rice_fixedlong_fixedmedium.xlsx',DescriptiveStat)
%xlswrite('PriceSensitivity.xlsx',PriceSensitivity)

clear
RA=xlsread('RA_Rice_fixedlong_fixedmedium.xlsx')
CreateFigureData
xlswrite('CELL30MIDMAP_Rice_fixedlong_fixedmedium.xlsx',CELL30MIDMAP)
xlswrite('PriceSensitivity_Rice_fixedlong_fixedmedium.xlsx',PriceSensitivity)



% 3 Rice fixedlong versus onset long --------------------------------------------
clear
ndataseq01060216=xlsread('rice_fixedlong_onset_long_IGP.xlsx')
CreateWTPBoundsbyCell
CreateTableData

%CreateFigureData
xlswrite('RA_Rice_fixedlong_onset_long.xlsx',RA)
#xlswrite('RAwOutliers.xlsx',RAwOutliers)
%xlswrite('CELL30MIDMAP.xlsx',CELL30MIDMAP)
xlswrite('DescriptiveStat_Rice_fixedlong_onset_long.xlsx',DescriptiveStat)
%xlswrite('PriceSensitivity.xlsx',PriceSensitivity)


clear
RA=xlsread('RA_Rice_fixedlong_onset_long.xlsx')
CreateFigureData
xlswrite('CELL30MIDMAP_Rice_fixedlong_onset_long.xlsx',CELL30MIDMAP)
xlswrite('PriceSensitivity_Rice_fixedlong_onset_long.xlsx',PriceSensitivity)



% 4 Rice fixedlong versus onset medium
clear
ndataseq01060216=xlsread('rice_fixedlong_onset_medium_IGP.xlsx')
CreateWTPBoundsbyCell
CreateTableData

%CreateFigureData
xlswrite('RA_Rice_fixedlong_onset_medium.xlsx',RA)
#xlswrite('RAwOutliers.xlsx',RAwOutliers)
%xlswrite('CELL30MIDMAP.xlsx',CELL30MIDMAP)
xlswrite('DescriptiveStat_Rice_fixedlong_onset_medium.xlsx',DescriptiveStat)
%xlswrite('PriceSensitivity.xlsx',PriceSensitivity)


clear
RA=xlsread('RA_Rice_fixedlong_onset_medium.xlsx')
CreateFigureData
xlswrite('CELL30MIDMAP_Rice_fixedlong_onset_medium.xlsx',CELL30MIDMAP)
xlswrite('PriceSensitivity_Rice_fixedlong_onset_medium.xlsx',PriceSensitivity)

% 5 Rice fixedlong versus onset long suppl
clear
ndataseq01060216=xlsread('rice_fixedlong_onset_long_suppl_IGP.xlsx')
CreateWTPBoundsbyCell
CreateTableData

%CreateFigureData
xlswrite('RA_Rice_fixedlong_onset_long_suppl.xlsx',RA)
#xlswrite('RAwOutliers.xlsx',RAwOutliers)
%xlswrite('CELL30MIDMAP.xlsx',CELL30MIDMAP)
xlswrite('DescriptiveStat_Rice_fixedlong_onset_long_suppl.xlsx',DescriptiveStat)
%xlswrite('PriceSensitivity.xlsx',PriceSensitivity)

clear
RA=xlsread('RA_Rice_fixedlong_onset_long_suppl.xlsx')
CreateFigureData
xlswrite('CELL30MIDMAP_Rice_fixedlong_onset_long_suppl.xlsx',CELL30MIDMAP)
xlswrite('PriceSensitivity_Rice_fixedlong_onset_long_suppl.xlsx',PriceSensitivity)

% 6 Rice fixedlong versus onset medium suppl
clear
ndataseq01060216=xlsread('rice_fixedlong_onset_medium_suppl_IGP.xlsx')
CreateWTPBoundsbyCell
CreateTableData

%CreateFigureData
xlswrite('RA_Rice_fixedlong_onset_medium_suppl.xlsx',RA)
#xlswrite('RAwOutliers.xlsx',RAwOutliers)
%xlswrite('CELL30MIDMAP.xlsx',CELL30MIDMAP)
xlswrite('DescriptiveStat_Rice_fixedlong_onset_medium_suppl.xlsx',DescriptiveStat)
%xlswrite('PriceSensitivity.xlsx',PriceSensitivity)

clear
RA=xlsread('RA_Rice_fixedlong_onset_medium_suppl.xlsx')
CreateFigureData
xlswrite('CELL30MIDMAP_Rice_fixedlong_onset_medium_suppl.xlsx',CELL30MIDMAP)
xlswrite('PriceSensitivity_Rice_fixedlong_onset_medium_suppl.xlsx',PriceSensitivity)








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             WHEAT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1 wheat fixedlong versus fixed long ---------------------------------------------
 clear
 ndataseq01060216=xlsread('wheat_baseline_long_IGP.xlsx')
  CreateWTPBoundsbyCell
  CreateTableData

  %CreateFigureData
  xlswrite('RA_wheat_baseline_fixedlong.xlsx',RA)
  #xlswrite('RAwOutliers.xlsx',RAwOutliers)
  %xlswrite('CELL30MIDMAP.xlsx',CELL30MIDMAP)
  xlswrite('DescriptiveStat_wheat_baseline_fixedlong.xlsx',DescriptiveStat)
  %xlswrite('PwheatSensitivity.xlsx',PwheatSensitivity)

clear
RA=xlsread('RA_wheat_baseline_fixedlong.xlsx')
CreateFigureData
xlswrite('CELL30MIDMAP_wheat_baseline_fixedlong.xlsx',CELL30MIDMAP)
xlswrite('PriceSensitivity_wheat_baseline_fixedlong.xlsx',PriceSensitivity)

  % 2 wheat fixedlong versus fixed medium --------------------------------------------
    clear
  ndataseq01060216=xlsread('wheat_fixedlong_fixedmedium_IGP.xlsx')
  CreateWTPBoundsbyCell
  CreateTableData

  %CreateFigureData
  xlswrite('RA_wheat_fixedlong_fixedmedium.xlsx',RA)
  #xlswrite('RAwOutliers.xlsx',RAwOutliers)
  %xlswrite('CELL30MIDMAP.xlsx',CELL30MIDMAP)
  xlswrite('DescriptiveStat_wheat_fixedlong_fixedmedium.xlsx',DescriptiveStat)
  %xlswrite('PwheatSensitivity.xlsx',PwheatSensitivity)

clear
RA=xlsread('RA_wheat_fixedlong_fixedmedium.xlsx')
CreateFigureData
xlswrite('CELL30MIDMAP_wheat_fixedlong_fixedmedium.xlsx',CELL30MIDMAP)
xlswrite('PriceSensitivity_wheat_fixedlong_fixedmedium.xlsx',PriceSensitivity)

  % 3 wheat fixedlong versus onset long --------------------------------------------
  clear
  ndataseq01060216=xlsread('wheat_fixedlong_onset_long_IGP.xlsx')
  CreateWTPBoundsbyCell
  CreateTableData

  %CreateFigureData
  xlswrite('RA_wheat_fixedlong_onset_long.xlsx',RA)
  #xlswrite('RAwOutliers.xlsx',RAwOutliers)
  %xlswrite('CELL30MIDMAP.xlsx',CELL30MIDMAP)
  xlswrite('DescriptiveStat_wheat_fixedlong_onset_long.xlsx',DescriptiveStat)
  %xlswrite('PwheatSensitivity.xlsx',PwheatSensitivity)

clear
RA=xlsread('RA_wheat_fixedlong_onset_long.xlsx')
CreateFigureData
xlswrite('CELL30MIDMAP_wheat_fixedlong_onset_long.xlsx',CELL30MIDMAP)
xlswrite('PriceSensitivity_wheat_fixedlong_onset_long.xlsx',PriceSensitivity)

  % 4 wheat fixedlong versus onset medium
  clear
  ndataseq01060216=xlsread('wheat_fixedlong_onset_medium_IGP.xlsx')
  CreateWTPBoundsbyCell
  CreateTableData

  %CreateFigureData
  xlswrite('RA_wheat_fixedlong_onset_medium.xlsx',RA)
  #xlswrite('RAwOutliers.xlsx',RAwOutliers)
  %xlswrite('CELL30MIDMAP.xlsx',CELL30MIDMAP)
  xlswrite('DescriptiveStat_wheat_fixedlong_onset_medium.xlsx',DescriptiveStat)
  %xlswrite('PwheatSensitivity.xlsx',PwheatSensitivity)

clear
RA=xlsread('RA_wheat_fixedlong_onset_medium.xlsx')
CreateFigureData
xlswrite('CELL30MIDMAP_wheat_fixedlong_onset_medium.xlsx',CELL30MIDMAP)
xlswrite('PriceSensitivity_wheat_fixedlong_onset_medium.xlsx',PriceSensitivity)

  % 5 wheat fixedlong versus onset long suppl
  clear
  ndataseq01060216=xlsread('wheat_fixedlong_onset_long_suppl_IGP.xlsx')
  CreateWTPBoundsbyCell
  CreateTableData

  %CreateFigureData
  xlswrite('RA_wheat_fixedlong_onset_long_suppl.xlsx',RA)
  #xlswrite('RAwOutliers.xlsx',RAwOutliers)
  %xlswrite('CELL30MIDMAP.xlsx',CELL30MIDMAP)
  xlswrite('DescriptiveStat_wheat_fixedlong_onset_long_suppl.xlsx',DescriptiveStat)
  %xlswrite('PwheatSensitivity.xlsx',PwheatSensitivity)

clear
RA=xlsread('RA_wheat_fixedlong_onset_long_suppl.xlsx')
CreateFigureData
xlswrite('CELL30MIDMAP_wheat_fixedlong_onset_long_suppl.xlsx',CELL30MIDMAP)
xlswrite('PriceSensitivity_wheat_fixedlong_onset_long_suppl.xlsx',PriceSensitivity)

  % 6 wheat fixedlong versus onset medium suppl
  clear
  ndataseq01060216=xlsread('wheat_fixedlong_onset_medium_suppl_IGP.xlsx')
  CreateWTPBoundsbyCell
  CreateTableData

  %CreateFigureData
  xlswrite('RA_wheat_fixedlong_onset_medium_suppl.xlsx',RA)
  #xlswrite('RAwOutliers.xlsx',RAwOutliers)
  %xlswrite('CELL30MIDMAP.xlsx',CELL30MIDMAP)
  xlswrite('DescriptiveStat_wheat_fixedlong_onset_medium_suppl_IGP.xlsx',DescriptiveStat)
  %xlswrite('PwheatSensitivity.xlsx',PwheatSensitivity)

clear
RA=xlsread('RA_wheat_fixedlong_onset_medium_suppl.xlsx')
CreateFigureData
xlswrite('CELL30MIDMAP_wheat_fixedlong_onset_medium_suppl_IGP.xlsx',CELL30MIDMAP)
xlswrite('PriceSensitivity_wheat_fixedlong_onset_medium_suppl_IGP.xlsx',PriceSensitivity)







