%Dielectric layers with widths in geometric progression
clc;
n_1=1;
nSi=3.5
na=3.29;
nb=1.53;
r=1.15;   %geometric progression ratio
ta0=40e-9;
tb0=70e-9;
%ta0=92.33e-9;
%tb0=114.25e-9;
N=8; %number of bilayers to be used
%i=1:1:N;
ta=ta0*(r.^[0:N]);  %generate geometric progression with 'r' as the ratio
tb=tb0*(r.^[0:N]);
opt_ta=na.*ta;
opt_tb=nb.*tb;

newt1=[opt_tb;opt_ta];
%newt_50=[opt_tb_50;opt_ta_50];

theta_d0=8;         %angle of incidence at the slab in degrees
theta_dl=50;
lmd0=300e-9;                    % starting wavelength of light in free space
lmdf=2000e-9;
c = 3e8;                %speed of light in vaccum
angle = [theta_d0:5:theta_dl];
wavelength = [lmd0:1e-9:lmdf];
wavelength2 = 630e-9;
freq = c./wavelength;

mode = 'te';



% a 6 bilayer with gp and LH combo
n61 = [n_1,repmat([nb,na],1,6),nb];
%n61_Si = [nSi,repmat([nb,na],1,6),nb];
l61_gp=[newt1(1:2*6)];
%l61_gp_ni=1e-9.*[nb*100,na*50,nb*110,na*55,nb*121,na*60,nb*133,na*66,nb*146,na*73,nb*161,na*80];
[r61_gp,z]=multidiel(n61,l61_gp,wavelength,theta_d0,mode);
%[r61_gp_Si,z]=multidiel(n61_Si,l61_gp_Si,wavelength,theta_d,mode);

n6_3 = [n_1,repmat([nb,na],1,6),nb];
%l6=[nb*100e-9,na*50e-9,nb*125e-9,na*62.5e-9,nb*140e-9,na*70e-9,nb*150e-9,na*75e-9,nb*180e-9,na*90e-9,nb*200e-9,na*100e-9];
%l6_gp6=[newt_50(1:2*6)];
%[r6_3,z]=multidiel(n6_3,l6_gp6,wavelength,theta_d0,mode);

% a 6 bilayer w/o gp
l6=[repmat([na*ta0,nb*tb0],1,6),na*ta0];
[r6,z]=multidiel(n6,l6,wavelength,theta_d0,mode);


% a 6 bilayer w/o gp and LH combo
n62=[n_1,repmat([nb,na],1,6),nb];
l62=[repmat([nb*tb0,na*ta0],1,6)];
[r62,z]=multidiel(n62,l62,wavelength,theta_d0,mode);


% a 8 bilayer with gp and LH combo
n81 = [n_1,repmat([nb,na],1,N),nb];
l81_gp=[newt1(1:2*N)];
[r81_gp,z]=multidiel(n81,l81_gp,wavelength2,angle,mode);

% a 8 bilayer with gp and LH combo and Si as incident medium
n81_Si = [nSi,repmat([nb,na],1,N),nb];
l81_gp_Si=[newt1(1:2*N)];
[r81_gp_Si,z]=multidiel(n81_Si,l81_gp_Si,wavelength,theta_d0,mode);

% a 8 bilayer w/o gp and LH combo
n8=[n_1,repmat([nb,na],1,N),nb];
l8=[repmat([nb*tb0,na*ta0],1,N)];
[r8lh,z]=multidiel(n8,l8,wavelength,theta_d0,mode);

% a 8 bilayer w/o gp
n8=[n_1,na,repmat([nb,na],1,8),n_1];
l8=[repmat([na*ta0,nb*tb0],1,8),na*ta0];
[r8,z]=multidiel(n8,l8,wavelength,theta_d0,mode);

%data = {wavelength' 100*abs(r4_gp).^2' 100*abs(r61_gp).^2' 100*abs(r81_gp).^2'};
%xlswrite('35-70nm.xlsx', data, 'Reflectance data for different bilayers', 'A3');

plot(wavelength*1e9,abs(r81_gp).^2,'-b','linewidth',2);
%hold on;
%plot(wavelength*1e9,abs(r8lh).^2,'-k','linewidth',2);
grid on;
xlabel('Wavelength (nm)','FontSize',16);
ylabel('Reflectance','Fontsize',16);
title('Reflectance plot at TE, normal incidence, 50 nm / 100 nm, 6 bilayers under geometric progression','FontSize',16);
%legend('With air as incident medium', 'With Si as incident medium');
%figure;



