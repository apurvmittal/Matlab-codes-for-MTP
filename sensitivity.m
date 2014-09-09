%The code introduces a variation in the thickness of the layers
%Dielectric layers with widths in geometric progression
clear all;
n_1=1;
na=3.29;
na2=2.93;
nb=1.53;
r=1.15;   %geometric progression ratio
ta0=40e-9;
tb0=78e-9;

N=8; %number of bilayers to be used

ta=ta0*(r.^[0:N]);  %generate geometric progression with 'r' as the ratio
tb=tb0*(r.^[0:N]);
opt_ta=na.*ta;
opt_tb=nb.*tb;

r2 = 1.1;
ta1=50e-9;
tb1=100e-9;
ta2=ta1*(r2.^[0:6]);  %generate geometric progression with 'r' as the ratio
tb2=tb1*(r2.^[0:6]);
opt_ta_50=na.*ta2;
opt_tb_50=nb.*tb2;

newt=[opt_ta;opt_tb];
newt1=[opt_tb;opt_ta];
newt_50=[opt_tb_50;opt_ta_50];

d=2;

theta_d=8;         %angle of incidence at the slab in degrees
lmd0=300e-9;                    % starting wavelength of light in free space
lmdf=2000e-9;
c = 3e8;                %speed of light in vaccum
wavelength = [lmd0:10e-9:lmdf];
freq = c./wavelength;

mode = 'te';


% 6 bilayers with gp, LH and 50 / 100 nm stack
n6_3 = [n_1,repmat([nb,na],1,6),nb];
l6_gp6=[newt_50(1:2*6)];
[r6_3,z]=multidiel(n6_3,l6_gp6,wavelength,theta_d,mode);

% 8 bilayers, 35 / 70 nm stack for sensitivity analysis
n_sens = [n_1,repmat([nb,na2],1,N),nb];
%for i=0.05:0.05:0.35
  t_sens=[opt_tb + ((-1)^(d-1))*0.25.*opt_tb; opt_ta + ((-1)^(d))*0.4.*opt_ta];
  l_sens=[t_sens(1:2*N)];
  [r_sens,z]=multidiel(n_sens,l_sens, wavelength, theta_d, mode);
  plot(wavelength*1e9,100*abs(r_sens).^2,'linewidth',2);
  hold on;
%end
data=load('res35.txt');
%figure;

plot(data(:,1),data(:,2),'r','linewidth',2);
%hold on;
%plot(wavelength*1e9,abs(r62_gp).^2,'-r','linewidth',2);
%plot(wavelength*1e9,abs(r61_gp_air).^2,'-r','linewidth',2);
%plot(wavelength*1e9,abs(r4_gp).^2,'-c','linewidth',2);
%plot(wavelength*1e9,abs(r4).^2,'-_k','linewidth',2);

xlabel('Wavelength (nm)','FontSize',16);
ylabel('Reflectance (%)','FontSize',16);
title('8 bilayers reflectance plot at TE, normal incidence, 35 nm / 70 nm under geometric progression','FontSize',16);
legend('Simulated','Experimental','FontSize',12);
grid on


