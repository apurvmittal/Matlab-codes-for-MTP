
%The code introduces a variation in the thickness of the layers
%Dielectric layers with widths in geometric progression
clear all;

% wavelength profile
lmd0=300e-9;                    % starting wavelength of light in free space
lmdf=2000e-9;
c = 3e8;                %speed of light in vaccum
wavelength = [lmd0:10e-9:lmdf];
freq = c./wavelength;

theta_d=8;         %angle of incidence at the slab in degrees
mode = 'te';
% refractive indices
n_1=1;
na=3.24;
na2=2.93;
nb=1.53;

%thickness profile
r=1.15;   %geometric progression ratio
N=8; %number of bilayers to be used

ta0=35e-9;
tb0=70e-9;
ta=ta0*(r.^[0:N]);  %generate geometric progression with 'r' as the ratio
tb=tb0*(r.^[0:N]);
opt_ta=na2.*ta;
opt_tb=nb.*tb;
d=2;
t_sens=[opt_tb + ((-1)^(d))*0.2.*opt_tb; opt_ta + ((-1)^(d-1))*0.2.*opt_ta];

% simulated stack
n_sens = [n_1,repmat([nb,na],1,N),nb];
l_sens=[t_sens(1:2*N)];
[r_sens,z]=multidiel(n_sens,l_sens,wavelength,theta_d,mode);

% experimental stack
data=load('res35.txt');
figure;

% Plot
plot(data(:,1),data(:,2),'r','linewidth',2);
hold on;
plot(wavelength*1e9,100*abs(r_sens).^2,'-b','linewidth',2);

xlabel('Wavelength (nm)');
ylabel('Reflectance');
title('8 bilayers reflectance plot at TE, normal incidence, 35 nm / 70 nm under geometric progression');
legend('Experimental 35-70','Simulated 35-70 with variations in thickness 0.3');
grid on

