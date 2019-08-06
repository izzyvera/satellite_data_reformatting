filename = 'SMAPLandMask36KM.mat';
land_mask = matfile(filename);
for i = 1:406
    for j = 1:964
        if (land_mask(:) == 1)
            land_pixel = (land_mask ==1);
            if (nvdi_temp(:) == land_pixel)
                upperleft = (SMAPCornerLats(i:j:1), SMAPCornerLons(i:j:1)
                lowerleftlat = SMAPCornerLats(i:j:2), SMAPCorner
                lowerrightlat = SMAPCornerLats(i:j:3);
                upperrightlat = SMAPCornerLats(i:j:4);
                if ((nvdi_temp <= upperleftlat) && (nvdi_temp))
            end
        end
    end
end