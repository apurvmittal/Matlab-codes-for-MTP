
%Trying to understand how can one design a stack for a necessary BW
clear all;
n_1=1;
na=3.24;
nb=1.53;
r=1.1;   %geometric progression ratio
ta0=50e-9;
tb0=100e-9;
N=8;
ta=ta0*(r.^[0:N]);  %generate geometric progression with 'r' as the ratio
tb=tb0*(r.^[0:N]);
opt_ta=na.*ta;
opt_tb=nb.*tb;
newt=[opt_ta;opt_tb];
newt1=[opt_tb;opt_ta];

theta_d=8;         %angle of incidence at the slab in degrees
lmd0=300e-9;                    % starting wavelength of light in free space
lmdf=2000e-9;
c = 3e8;                %speed of light in vaccum
wavelength = [lmd0:1e-9:lmdf];
freq = c./wavelength;

mode = 'te';

% a 6 bilayer with gp
n6 = [n_1,repmat([nb,na],1,1),nb];
l6 =[newt1(1:2)];
[r,z]=multidiel(n6,l6,wavelength,theta_d,mode);

plot(wavelength*1e9,abs(r).^2,'-r','linewidth',2);
