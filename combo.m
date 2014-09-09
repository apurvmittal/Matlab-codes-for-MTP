%Dielectric mirror with 12 bilayers: 6 bilayers of 25 nm / 50 nm and 6
%bilayers of 50 nm / 100 nm and gp = 1.1

clear all;
n_1=1;
na=3.24;
nb=1.53;
r=1.15;   %geometric progression ratio
ta0=35e-9;
tb0=70e-9;
ta1=50e-9;
tb1=100e-9;

N=6; %number of bilayers to be used
%i=1:1:N;
ta=ta0*(r.^[0:N]);  %generate geometric progression with 'r' as the ratio
tb=tb0*(r.^[0:N]);
opt_ta=na.*ta;
opt_tb=nb.*tb;
newt=[opt_ta;opt_tb];
newtlh=[opt_tb;opt_ta];

ta_5=ta1*(r.^[0:N]);  %generate geometric progression with 'r' as the ratio
tb_5=tb1*(r.^[0:N]);
opt_ta_5=na.*ta_5;
opt_tb_5=nb.*tb_5;
newt1=[opt_ta_5;opt_tb_5];
newt1lh=[opt_tb_5;opt_ta_5];

theta_d=8;         %angle of incidence at the slab in degrees
lmd0=200e-9;                    % starting wavelength of light in free space
lmdf=2000e-9;
c = 3e8;                %speed of light in vaccum
wavelength = [lmd0:1e-9:lmdf];
freq = c./wavelength;

mode = 'te';

% a 12 bilayer with 25 nm/50 nm and 50 nm/100 nm combination
n12=[n_1,na,repmat([nb,na],1,2*N),nb];
l6_gp=newt(1:2*N);
l6_gp_5=[newt1(1:2*N),na*ta1*2];
l12_gp=[l6_gp,l6_gp_5];
[r12_gp,z]=multidiel(n12,l12_gp,wavelength,theta_d,mode);

% a 12 bilayer with 25 nm/50 nm and 50 nm/100 nm, LH combination 
n12lh=[n_1,repmat([nb,na],1,2*N),nb];
l6_gplh=newtlh(1:2*N);
l6_gp_5lh=[newt1lh(1:2*N)];
l12_gplh=[l6_gplh,l6_gp_5lh];
[r12_gplh,z]=multidiel(n12lh,l12_gplh,wavelength,theta_d,mode);

n6lh=[n_1,repmat([nb,na],1,6),nb];
[r6_gplh,z]=multidiel(n6lh,l6_gplh,wavelength,theta_d,mode);

n6lh=[n_1,repmat([nb,na],1,6),nb];
[r6_5gplh,z]=multidiel(n6lh,l6_gp_5lh,wavelength,theta_d,mode);



plot(wavelength*1e9,abs(r6_5gplh).^2,'-k','linewidth',2);
hold on;
plot(wavelength*1e9,abs(r12_gplh).^2,'-b','linewidth',2);
plot(wavelength*1e9,abs(r6_gplh).^2,'-r','linewidth',2);

xlabel('Wavelength (nm)');
ylabel('Reflectance');
title('Reflectance plot at TE, normal incidence, GP = 1.1');
legend('12 bilayers','3 bilayers','4 bilayers','6 bilayers','6 bilayers w/o gp');
grid on
