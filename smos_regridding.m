%% Read SMAP Soil Moisture Data
cd /Users/isabelwang/Documents/MATLAB/SMAP/SMAP_L3
h5disp('SMAP_L3_SM_P_20150331_R13080_001.h5');

file_name = dir('*.h5');
for i = 1:length(file_name)
    lat = h5read(file_name(i).name,'/Soil_Moisture_Retrieval_Data/latitude_centroid');
    lat = fliplr(rot90(lat,-1));
    lat(lat == -9999) = NaN;
    lat_smap{i} = lat;
    clear lat
end
clear i

file_name = dir('*.h5');
for i = 1:length(file_name)
    lon = h5read(file_name(i).name,'/Soil_Moisture_Retrieval_Data/longitude_centroid');
    lon = fliplr(rot90(lon,-1));
    lon(lon == -9999) = NaN;
    lon_smap{i} = lon;
    clear lon
end
clear i

for i = 1:length(file_name)
    sm = h5read(file_name(i).name,'/Soil_Moisture_Retrieval_Data/soil_moisture');
    sm = fliplr(rot90(sm,-1));
    sm(sm == -9999) = NaN;
    sm_smap{i} = sm;
    clear sm
end
clear i file_name

%% Load EASE ver2 36 km lat/lon
cd /Users/isabelwang/Documents/MATLAB/scripts
load('coord_36km')
% Generate 2d lat/lon templates
[lon_ease36km,lat_ease36km] = meshgrid(lon_ease_1d,lat_ease_1d);
clear lon_ease_1d lat_ease_1d

%% Read GLDAS Soil Moisture Data
addpath(genpath('/Users/isabelwang/Documents/MATLAB/nctoolbox-1.1.3'))
run setup_nctoolbox
cd /Users/isabelwang/Documents/MATLAB/GLDAS/001
ds=ncgeodataset('GLDAS_NOAH025SUBP_3H.A2015001.0000.001.2015037193230.grb');
ds.metadata

lat = ds.geovariable('lat');
for i = 1:size(lat)
    lat_gldas_1d(i) = double(lat(i));
end
lat_gldas_1d = lat_gldas_1d';
lat_gldas_1d = flipud(lat_gldas_1d);
clear i lat

lon = ds.geovariable('lon');
for i = 1:size(lon)
    lon_gldas_1d(i) = double(lon(i));
end
lon_gldas_1d = lon_gldas_1d';
clear i lon

[lon_gldas,lat_gldas] = meshgrid(lon_gldas_1d,lat_gldas_1d);
clear lon_gldas_1d lat_gldas_1d

sm = ds.geovariable('Soil_moisture_content_layer_between_two_depths_below_surface_layer');
sm.attributes
sm_gldas = sm.data(1, end, :, :);
% size(sm_gldas)
sm_gldas= squeeze(double(sm_gldas));
sm_gldas = flipud(sm_gldas);
clear sm ds ans

%% Regrid GLDAS data to EASE Ver2 36 km
for s=1:405
    for t=1:963
        d_lat = abs(lat_ease36km(s+1,t)-lat_ease36km(s,t))/2;
        d_lon = abs(lon_ease36km(s,t+1)-lon_ease36km(s,t))/2;
        temp_lat=find(lat_gldas>lat_ease36km(s,t)-d_lat...
            &lat_gldas<lat_ease36km(s,t)+d_lat);
        temp_lon=find(lon_gldas>lon_ease36km(s,t)-d_lon...
            &lon_gldas<lon_ease36km(s,t)+d_lon);
        grid_match{s,t}=intersect(temp_lat,temp_lon);
        sm_gldas_regrid(s,t)=nanmean(sm_gldas(grid_match{s,t}));
    end
end

for s=406
    for t=964
        d_lat = abs(lat_ease36km(s,t)-lat_ease36km(s-1,t))/2;
        d_lon = abs(lon_ease36km(s,t)-lon_ease36km(s,t-1))/2;
        temp_lat=find(lat_gldas>lat_ease36km(s,t)-d_lat...
            &lat_gldas<lat_ease36km(s,t)+d_lat);
        temp_lon=find(lon_gldas>lon_ease36km(s,t)-d_lon...
            &lon_gldas<lon_ease36km(s,t)+d_lon);
        grid_match{s,t}=intersect(temp_lat,temp_lon);
        sm_gldas_regrid(s,t)=nanmean(sm_gldas(grid_match{s,t}));
    end
end
clear s t temp_lat temp_lon d_lat d_lon temp_lat temp_lon grid_match
