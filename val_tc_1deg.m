%former: Triple Collocation (2008-2011)
% Triple collocation: define errors for each pixel and degree of info content
% of SMOS, SMAP, and GLDAS data (2015)

%slhf_modis_ref_reshape = reshape(slhf_modis_ref,21904,48);
%slhf_fluxnet_ref_reshape = reshape(slhf_fluxnet_ref,21904,48);
%slhf_ecmwf_ref_reshape = reshape(slhf_ecmwf_ref,21904,48);

sm_smap_reshape = reshape(sm_smap, 21904,48);
sm_smos_reshape = reshape(sm_smos, 21904,48);
sm_gldas_reshape = reshape(sm_gldas, 21904,48);


for i = 1:21904
    % cov1 = nancov(slhf_modis_ref_reshape(i,:),slhf_modis_ref_reshape(i,:));
    cov1 = nancov(sm_smap_reshape(i,:),sm_smap_reshape(i,:));
    c11(i, 1) = cov1(1, 2);
    % cov2 = nancov(slhf_fluxnet_ref_reshape(i,:),slhf_fluxnet_ref_reshape(i,:));
    cov2 = nancov(sm_smos_reshape(i,:),sm_smos_reshape(i,:));
    c22(i, 1) = cov2(1, 2);
    % cov3 = nancov(slhf_ecmwf_ref_reshape(i,:),slhf_ecmwf_ref_reshape(i,:));
    cov3 = nancov(sm_gldas_reshape(i,:),sm_gldas_reshape(i,:));
    c33(i, 1) = cov3(1, 2);
    % cov4 = nancov(slhf_modis_ref_reshape(i,:),slhf_fluxnet_ref_reshape(i,:));
    cov4 = nancov(sm_smap_reshape(i,:),sm_smos_reshape(i,:));
    c12(i, 1) = cov4(1, 2);
    % cov5 = nancov(slhf_modis_ref_reshape(i,:),slhf_ecmwf_ref_reshape(i,:));
    cov5 = nancov(sm_smap_reshape(i,:),sm_gldas_reshape(i,:));
    c13(i, 1) = cov5(1, 2);
    % cov6 = nancov(slhf_fluxnet_ref_reshape(i,:),slhf_ecmwf_ref_reshape(i,:));
    cov6 = nancov(sm_smos_reshape(i,:),sm_gldas_reshape(i,:));
    c23(i, 1) = cov6(1, 2);
end
clear i cov1 cov2 cov3 cov4 cov5 cov6

%--------------------------------------------------------------    
% Calculate rmse_tc_1   
for i = 1:21904
    temp1 = c11(i, 1)-(c12(i, 1).*c13(i, 1))./c23(i, 1);
    if temp1 > 0
        rmse_tc_1(1, i) = sqrt(temp1);
    else
        rmse_tc_1(1, i) = NaN;
    end
    clear temp1
end
clear i
  
% Reshape to 1 degree map
ind = find(~isnan(land_mask_1d(:)'));
%former: vector =zeros(1, 64800);
vector = zeros(1, 391384);
vector(vector == 0) = NaN;

for i = 1:21904
    vector(1, ind(i)) = rmse_tc_1(1, i);
end
clear i
%former: vector = reshape(vector, 180, 360);
vector = reshape(vector, 406, 964);
slhf_rmse_tc_1 = vector;
clear vector ind rmse_tc_1

%--------------------------------------------------------------    
% Calculate rmse_tc_2   
for i = 1:21904
    temp2 = c22(i, 1)-(c12(i, 1).*c23(i, 1))./c13(i, 1);
    if temp2 > 0
        rmse_tc_2(1, i) = sqrt(temp2);
    else
        rmse_tc_2(1, i) = NaN;
    end
    clear temp2
end
clear i

% former: Reshape to 1 degree map
% Reshape to 36 km projection
ind = find(~isnan(land_mask_1d(:)'));
% vector =zeros(1, 64800);
vector = zeros (1, 391384);
vector(vector == 0) = NaN;

for i = 1:21904
    vector(1, ind(i)) = rmse_tc_2(1, i);
end
clear i
% vector = reshape(vector, 180, 360);
vector = reshape(vector, 406, 964);
slhf_rmse_tc_2 = vector;
clear vector ind rmse_tc_2

%--------------------------------------------------------------    
% Calculate rmse_tc_3   
for i = 1:21904
    temp3 = c33(i, 1)-(c13(i, 1).*c23(i, 1))./c12(i, 1);
    if temp3 > 0
        rmse_tc_3(1, i) = sqrt(temp3);
    else
        rmse_tc_3(1, i) = NaN;
    end
    clear temp3
end
clear i

% Reshape to 1 degree map
ind = find(~isnan(land_mask_1d(:)'));
% vector =zeros(1, 64800);
vector = zeros(1, 391384);
vector(vector == 0) = NaN;

for i = 1:21904
    vector(1, ind(i)) = rmse_tc_3(1, i);
end
clear i
%former: vector = reshape(vector, 180, 360);
vector = reshape(vector, 406, 964);
slhf_rmse_tc_3 = vector;
clear vector ind rmse_tc_3
clear c11 c22 c33 c12 c13 c23 sm_smap_reshape sm_gldas_reshape...
        sm_smos_reshape sm_smap_reshape sm_gldas_reshape...
        sm_smos_reshape
% clear c11 c22 c33 c12 c13 c23 slhf_modis_ref_reshape slhf_ecmwf_ref_reshape...
%    slhf_fluxnet_ref_reshape slhf_modis_ref_reshape slhf_ecmwf_ref_reshape...
%    slhf_fluxnet_ref_reshape

% clear slhf_modis_ref slhf_fluxnet_ref slhf_ecmwf_ref slhf_modis_ref...
%     slhf_fluxnet_ref slhf_ecmwf_ref


