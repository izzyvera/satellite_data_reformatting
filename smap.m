%% Read SMAP Soil Moisture Data (EASE 36 km) 
cd('/Users/isabelwang/Documents/MATLAB/SMAP/SMAP_L3');
fileread = dir('*.h5');

for i = 1:length(fileread)
    sm_temp = h5read(fileread(i).name,'/Soil_Moisture_Retrieval_Data/soil_moisture');
    % sm_temp = h5readatt(fileread(i).name, '/Soil_Moisture_Retrieval_Data', 'soil_moisture');
    sm_temp(sm_temp == -9999) = NaN;
    sm_smap(:,:,i) = fliplr(rot90(double(sm_temp),-1));
    
    str_name(:,i) = str2num(fileread(i).name(14:21));
    
    tb_h_temp = h5read(fileread(i).name,'/Soil_Moisture_Retrieval_Data/tb_h_corrected');
    tb_v_temp = h5read(fileread(i).name,'/Soil_Moisture_Retrieval_Data/tb_v_corrected');  
end

% lat_smap = h5read(fileread(i).name,'/Soil_Moisture_Retrieval_Data/latitude');
% lon_smap = h5read(fileread(i).name,'/Soil_Moisture_Retrieval_Data/longitude');