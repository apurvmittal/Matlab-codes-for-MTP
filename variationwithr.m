%Dielectric layers with widths in geometric progression
%Variation in r
clear all;
n_1=1;
na=3.24;
nb=1.53;
r=1;   %geometric progression ratio
r2=1.075;
r3=1.125;
r4=1.3`;
%r5=1.2;

ta0=50e-9;
tb0=100e-9;
N=6; %number of bilayers to be used

ta1=ta0*(r.^[0:N]);  %generate geometric progression with 'r' as the ratio
tb1=tb0*(r.^[0:N]);

ta2=ta0*(r2.^[0:N]);  %generate geometric progression with 'r' as the ratio
tb2=tb0*(r2.^[0:N]);

ta3=ta0*(r3.^[0:N]);  %generate geometric progression with 'r' as the ratio
tb3=tb0*(r3.^[0:N]);

ta4=ta0*(r4.^[0:N]);  %generate geometric progression with 'r' as the ratio
tb4=tb0*(r4.^[0:N]);

opt_ta1=na.*ta1;
opt_tb1=nb.*tb1;
newt1=[opt_tb1;opt_ta1];

opt_ta2=na.*ta2;
opt_tb2=nb.*tb2;
newt2=[opt_tb2;opt_ta2];

opt_ta3=na.*ta3;
opt_tb3=nb.*tb3;
newt3=[opt_tb3;opt_ta3];

opt_ta4=na.*ta4;
opt_tb4=nb.*tb4;
newt4=[opt_tb4;opt_ta4];

theta_d=8;         %angle of incidence at the slab in degrees
lmd0=300e-9;                    % starting wavelength of light in free space
lmdf=2000e-9;
c = 3e8;                %speed of light in vaccum
wavelength = [lmd0:10e-9:lmdf];
freq = c./wavelength;

mode = 'te';


% a 6 bilayer with gp and LH combo
n61 = [n_1,repmat([nb,na],1,N),nb];
l61_gp=[newt1(1:2*N)];
l61_gp2=[newt2(1:2*N)];
l61_gp3=[newt3(1:2*N)];
l61_gp4=[newt4(1:2*N)];

[r61_gp,z]=multidiel(n61,l61_gp,wavelength,theta_d,mode);
[r61_gp2,z]=multidiel(n61,l61_gp2,wavelength,theta_d,mode);
[r61_gp3,z]=multidiel(n61,l61_gp3,wavelength,theta_d,mode);
[r61_gp4,z]=multidiel(n61,l61_gp4,wavelength,theta_d,mode);


% a 1 bilayer w/o gp
n1=[n_1,na,nb,na,n_1];
l1=[repmat([na*ta0,nb*tb0],1,1),na*ta0];
[r1,z]=multidiel(n1,l1,wavelength,theta_d,mode);

data = {wavelength' 100*abs(r61_gp).^2' 100*abs(r61_gp2).^2' 100*abs(r61_gp3).^2' 100*abs(r61_gp4).^2' };
xlswrite('test2.xlsx', data, 'Reflectance data for different r', 'A3');

plot(wavelength*1e9,abs(r61_gp).^2,'-b','linewidth',2);
hold on
plot(wavelength*1e9,abs(r61_gp2).^2,'-g','linewidth',2);
plot(wavelength*1e9,abs(r61_gp3).^2,'-r','linewidth',2);
plot(wavelength*1e9,abs(r61_gp4).^2,'-c','linewidth',2);
%plot(wavelength*1e9,abs(r4).^2,'-_k','linewidth',2);

xlabel('Wavelength (nm)');
ylabel('Reflectance');
title('6 bilayers reflectance plot at TE, normal incidence, 50 nm / 100 nm under geometric progression');
%legend('w/o gp','with gp and H-L scheme','with gp and L-H scheme');
legend('r=1','r=1.075','r=1.125','r=1.2');
grid on

