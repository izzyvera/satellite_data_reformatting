%% Read GLDAS Soil Moisture Data (geographic) 
cd /Users/isa/Documents/MATLAB/nctoolbox-1.1.3
setup_nctoolbox
cd /Users/isa/Documents/MATLAB/GLDAS/001

% SM extraction
path_name = 'GLDAS_NOAH025SUBP_3H.A2015001.0000.001.2015037193230.grb';
nc = ncgeodataset(path_name); % open dataset
info = nc.metadata; % get attributes of file: return structure with attributes for each var
var = nc{'Soil_moisture_content_layer_between_two_depths_below_surface_layer'}(:); % retrieve var
sm_temp = squeeze(var(1,1,:,:)); % omit 1st time step, 1st level, and entire spatial domain of datase
sm_gldas = flipud(sm_temp);

path_name_coord = 'GLDAS_NOAH025SUBP_3H.A2015001.0000.001.2015037193230.grb';
nc = ncgeodataset(path_name_coord);
info_coord = nc.metadata;
lat_gldas = nc{'lat'}(:);
lon_gldas = nc{'lon'}(:);
