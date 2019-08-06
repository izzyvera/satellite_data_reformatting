%% Read SMOS Soil Moisture Data (EASE 36 km) 
addpath(genpath('/Users/isabelwang/Documents/MATLAB/nctoolbox-1.1.3'))
run setup_nctoolbox

% Descending retrieval extraction
cd /Users/isabelwang/Documents/MATLAB/smos_d
fileread = dir('*.nc');
for i = 1:length(fileread)
    path_name_d = 'SM_OPER_MIR_CLF31D_20150506T000000_20150506T235959_300_002_7.DBL.nc';
    ncd = ncgeodataset(path_name_d);
    info_d = ncd.metadata;
    % soil moisture var
    var_d_sm = ncd{'Soil_Moisture'}(:);
    var_d_smf = flipud(var_d_sm);
    % Tb var
    var_d_TbH = ncd{'Tb_Asl_Theta_B_H'}(:);
    var_d_TbV = ncd{'Tb_Asl_Theta_B_V'}(:);
    var_d_h = flipud(var_d_TbH);
    var_d_v = flipud(var_d_TbV);
    % row = ncd{'lat'}(:);
    % column = ncd{'lon'}(:);
end

% Ascending retrieval extraction
cd /Users/isabelwang/Documents/MATLAB/smos_a
fileread = dir('*.nc');

for i = 1:length(fileread)
    path_name_a = 'SM_OPER_MIR_CLF31A_20150506T000000_20150506T235959_300_002_7.DBL.nc';
    nca = ncgeodataset(path_name_a);
    info_a = nca.metadata;
    % soil moisture var
    var_a_sm = nca{'Soil_Moisture'}(:);
    var_a_smf = flipud(var_a_sm);
    % Tb var
    var_a_TbH = nca{'Tb_Asl_Theta_B_H'}(:);
    var_a_TbV = nca{'Tb_Asl_Theta_B_V'}(:);
    var_a_h = flipud(var_a_TbH);
    var_a_v = flipud(var_a_TbV);
    % row = nca{'lat'}(:);
    % column = nca{'lon'}(:);
end

% Average ascending and descending data to obtain daily average
sm_smos = (var_d_smf + var_a_smf)/2;

%
% Extract lat/lon info
path_name_coord = 'SM_RE04_MIR_CLF31A_20150101T000000_20150101T235959_300_001_7.DBL.nc';
nca = ncgeodataset(path_name_coord);
info_coord = nca.metadata;
lat_smos = nca{'lat'}(:);
lat_smos = flipud(lat_smos);
lon_smos = nca{'lon'}(:);
