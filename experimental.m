%Trying to estimate the thicknesses of the layers according to the
%experimental values. Just remember the experimental BW for two cases - 28/4/14

clear all;
n_1=1;
na=3.29;
na_k=3.24+1i*1e-9;
nb=1.53;
r=1.1;   %geometric progression ratio
%ta0=60.83e-9;
%tb0=76e-9;
ta0=50e-9;
tb0=100e-9;
%ta1=82.33e-9;
%tb1=114.25e-9;
ta1=92.33e-9;
tb1=114.25e-9;
%ta1=50e-9;
%tb1=100e-9;
%ta2=33e-9;
%tb2=66e-9;
%ta0=25e-9;
%tb0=50e-9;

N=6; %number of bilayers to be used
%i=1:1:N;
ta=ta0*(r.^[0:N]);  %generate geometric progression with 'r' as the ratio
tb=tb0*(r.^[0:N]);
opt_ta=na.*ta;
opt_tb=nb.*tb;
newt=[opt_tb;opt_ta];

ta_5=ta1*(r.^[0:N+2]);  %generate geometric progression with 'r' as the ratio
tb_5=tb1*(r.^[0:N+2]);
opt_ta_5=na.*ta_5;
opt_tb_5=nb.*tb_5;
newt1=[opt_tb_5;opt_ta_5];

%ta_2=ta2*(r.^[0:N]);  %generate geometric progression with 'r' as the ratio
%tb_2=tb2*(r.^[0:N]);
%opt_ta_2=na.*ta_2;
%opt_tb_2=nb.*tb_2;
%newt2=[opt_tb_2;opt_ta_2];

theta_d=8;         % angle of incidence at the slab in degrees
lmd0=300e-9;       % starting wavelength of light in free space
lmdf=2000e-9;
c = 3e8;           % speed of light in vaccum
wavelength = [lmd0:1e-9:lmdf];
freq = c./wavelength;

mode = 'te';
mode2 = 'tm';
% a 12 bilayer with 25 nm/50 nm and 50 nm/100 nm combination
n6=[n_1,repmat([nb,na],1,N),nb];
n6_k=[n_1,repmat([nb,na_k],1,N),nb];
n61=[n_1,repmat([nb,na],1,N+1),nb];
n62=[n_1,repmat([nb,na],1,N+2),nb];

l6_25=[newt(1:2*N)];
l6_50=[newt1(1:2*N)];
l6_501=[newt1(1:2*(N+1))];
l6_502=[newt1(1:2*(N+2))];

%l6_33=[newt2(1:2*N)];

%l6_gp1=[l6_gp,l6_gp_5];
[r6_25,z]=multidiel(n6,l6_25,wavelength,theta_d,mode);

[r6_50,z]=multidiel(n6,l6_50,wavelength,theta_d,mode);
[r6_50_k,z]=multidiel(n6_k,l6_50,wavelength,theta_d,mode);

%[r6_33,z]=multidiel(n6,l6_33,wavelength,theta_d,mode);
[r6_50_1,z]=multidiel(n61,l6_501,wavelength,theta_d,mode2);
[r6_50_2,z]=multidiel(n62,l6_502,wavelength,theta_d,mode2);

%[r12,z]=multidiel(n6,l6_50,wavelength,theta_d,mode)
%the experimental results
data=load('res.txt');
figure;
%plot(data(:,1),data(:,2),'r','linewidth',2);
%hold on;
%plot(data(:,1),data(:,3),'k','linewidth',2);
%hold on;
%plot(wavelength*1e9,100*abs(r6_25).^2,'-b','linewidth',2);
%hold on;
%plot(wavelength*1e9,100*abs(r6_33).^2,'-c','linewidth',2);
%hold on;
plot(wavelength*1e9,100*abs(r6_50).^2,'-r','linewidth',2);
hold on;
plot(wavelength*1e9,100*abs(r6_25).^2,'-b','linewidth',2);
%plot(wavelength*1e9,100*abs(r6_50_2).^2,'-k','linewidth',2);

%plot(wavelength*1e9,100*abs(r6_50_k).^2,'-c','linewidth',2);


xlabel('Wavelength (nm)');
ylabel('% Reflectance');
title('Reflectance plot at TE for 50 / 100 nm bilayer stacks');
legend('6 bilayers','7 bilayers','8 bilayers');
grid on
