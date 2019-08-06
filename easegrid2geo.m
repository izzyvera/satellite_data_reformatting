function [latitude, longitude] = easegrid2geo(column, row)

% function converts EASE grid (Global Cylindrical equal-area grid with 25 km
% resolution, true at 30 deg N/S) to geographic coordinates.

% constants
R=6371.228;     %Earth radius
C=25.067525;    %Pixel size
r0=-179.6109;   %Column origin
s0=-83.5171;    %Row origin

% convert Global Cylindrical equal-area map projection to regular grid
lambda = (C/R)*(column - r0) / cos(30);
phi = (C/R)*(row - s0) * cos(30);

% convert radians to geographic coordinates in degrees
longitude = (180*lambda)/pi;
latitude = (180*phi)/pi;

% nearest neighbor method (alternative): avg all EASE grid pixels, drop into single pixel for regular grid 
end

