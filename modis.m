% Read MODIS NVDI
cd('/Users/isa/Documents/MATLAB/MODIS13C2_92715_92716');
fileread = dir('*.hdf');

for i = 1:length(fileread)
    nvdi_temp = double(hdfread(fileread(i).name, '/MOD_Grid_monthly_CMG_VI/Data Fields/CMG 0.05 Deg Monthly NDVI')); 
    nvdi_temp(nvdi_temp == -3000) = NaN;
    nvdi_temp = nvdi_temp/10000;
end
        
% Read MODIS Tsurf (night)
cd('/Users/isa/Documents/MATLAB/MOD11C1_92715_92716');
fileread = dir('*.hdf');

for i = 1:length(fileread) 
    tsurf_temp = double(hdfread(fileread(i).name, '/MODIS_CMG_3MIN_LST/Data Fields/LST_Night_CMG'));
    tsurf_temp(nvdi_temp == 0) = NaN;
    tsurf_temp = tsurf_temp * 0.02;
end
