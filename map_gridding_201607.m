%% Bring 21904 land pixel back to adhere to 360 x 180 map
% 21904 = land pixel picked out of total pixels 64800 (360 x 180) @ 1 deg res

estimates_input = t_ratio_weighted_est_20072015;
estimates_input(estimates_input == 0) = NaN;
land_mask_vector = land_mask_1d(:)';
ind = find(~isnan(land_mask_vector));
clear land_mask_vector
vector = zeros(1, 21904);
vector(vector == 0) = NaN;

for i = 1:108
    estimates_monthly = estimates_input((i-1)*21904+1:i*21904);
    map = vector;
    for n = 1:21904
        map(ind(n)) = estimates_monthly(n);
    end
    map = reshape(map, 180, 360);
     map(map == 0) = NaN;
    map_monthly{i} = map;
    clear map
end
t_ratio_20072015 = map_monthly;
clear i n ind land_mask_vector vector estimates_input map...
    estimates_monthly map_monthly

% for i = 1:108
%     slhf_20072015{i} = slhf_20072015{i}./10^6;
%     sshf_20072015{i} = sshf_20072015{i}./10^6;
%     gpp_20072015{i} = gpp_20072015{i}.*10^3;
%     npp_20072015{i} = npp_20072015{i}.*10^3;
% end
% clear i

    
    
    
    