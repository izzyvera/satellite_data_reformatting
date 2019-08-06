% function  [column,row] = geo2easeGrid(latitude,longitude);
function  [column,row] = geo2easeGrid(lat_gldas,lon_gldas)

%Function that convert geographic coordinates to North azimuthal equal-area map with 25 km
%resolution pixel (EASE-Grid or NL)

%Constant
R=6371.228;     %Earth radius
C=25.067525;    %Pixel size
r0=360;         %Column origin
s0=360;         %Row origin
 
%Convert geographic coordinate in degrees to radian
% lambda=(longitude*pi)/180;
% phi=(latitude*pi)/180;

lambda=(lon_gldas*pi)/180;
phi=(lat_gldas*pi)/180;

%North azimuthal equal-area map projection
%See NSIDC web pages for more details (http://nsidc.org/data/ease/ease_grid.html)
column=(round(2* R/C * sin(lambda) .* sin(pi/4 - phi/2)+r0)+1);
row=(round(2* R/C * cos(lambda) .* sin(pi/4 - phi/2)+s0)+1);
%We add one because Matlab matrix start at 1,1 but in EASE-Grid the first pixel is 0,0

        