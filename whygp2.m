%Dielectric layers with widths in geometric progression
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
lmd0=50e-9;                    % starting wavelength of light in free space
lmdf=2000e-9;
c = 3e8;                %speed of light in vaccum
wavelength = [lmd0:1e-9:lmdf];
freq = c./wavelength;

mode = 'te';

% a 6 bilayer with gp
n6 = [n_1,repmat([nb,na],1,6),nb];
%l6=[nb*100e-9,na*50e-9,nb*125e-9,na*62.5e-9,nb*140e-9,na*70e-9,nb*150e-9,na*75e-9,nb*180e-9,na*90e-9,nb*200e-9,na*100e-9];
l6_gp6=[newt(1:2*6)];
[r6,z]=multidiel(n6,l6_gp6,wavelength,theta_d,mode);

% a 6 bilayer with gp
n6_gp = [n_1,repmat([nb,na],1,N),nb];
%l6=[nb*100e-9,na*50e-9,nb*100e-9,na*50e-9,nb*140e-9,na*70e-9,nb*160e-9,na*80e-9,nb*180e-9,na*90e-9,nb*200e-9,na*100e-9];
l6_gp8=[newt(1:2*N)];
[r8,z]=multidiel(n6_gp,l6_gp8,wavelength,theta_d,mode);

n61 = [n_1,repmat([nb,na],1,7),nb];
%l61=[nb*100e-9,na*50e-9,nb*100e-9,na*50e-9,nb*133e-9,na*66.5e-9,nb*146e-9,na*73.2e-9,nb*161e-9,na*80.5e-9,nb*177e-9,na*89e-9,nb*195e-9,na*97.4e-9];
l6_gp7=[newt(1:2*7)];
[r7,z]=multidiel(n61,l6_gp7,wavelength,theta_d,mode);

n62=[n_1,repmat([nb,na],1,N),nb];
l62=[repmat([nb*tb0,na*ta0],1,N)];
[r62,z]=multidiel(n62,l62,wavelength,theta_d,mode);

plot(wavelength*1e9,abs(r8).^2,'-b','linewidth',2);
hold on;
plot(wavelength*1e9,abs(r6).^2,'-r','linewidth',2);
plot(wavelength*1e9,abs(r7).^2,'-c','linewidth',2);
%plot(wavelength*1e9,abs(r4).^2,'-_k','linewidth',2);

xlabel('Wavelength (nm)');
ylabel('Reflectance');
title('8 bilayers reflectance plot at TE, normal incidence, 35 nm / 70 nm under geometric progression');
%legend('w/o gp','with gp and H-L scheme','with gp and L-H scheme');
%legend('without geometric progression','with geometric progression');
grid on

