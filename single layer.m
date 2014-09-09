%Dielectric layers with widths in geometric progression
%Single layer reflectance
clear all;
n_1=1;
na=3.24;
nb=1.53;
ta0=118e-9;
tb0=100e-9;
N=1;

theta_d=8;         %angle of incidence at the slab in degrees
lmd0=300e-9;                    % starting wavelength of light in free space
lmdf=2000e-9;
c = 3e8;                %speed of light in vaccum
wavelength = [lmd0:10e-9:lmdf];
freq = c./wavelength;
mode = 'te';

iter = (lmdf-lmd0)*1e9/10 + 1;
% Sellmeier dispersion model
A = 5.809;
lmdr = 350e-9;
n_selmr = 1 + A./(1-(lmdr./wavelength).^2);



% a single layer
for i=1:iter
n1 = [n_1,n_selmr(i),nb];
opt_ta=n_selmr(i).*ta0;
l1=[opt_ta];
[r1,z]=multidiel(n1,l1,wavelength,theta_d,mode);
end

%data = {wavelength' 100*abs(r61_gp).^2' 100*abs(r61_gp2).^2' 100*abs(r61_gp3).^2' 100*abs(r61_gp4).^2' };
%xlswrite('test.xlsx', data, 'Reflectance data for different r', 'A3');

data = load('tr2_ref2.txt');
plot(wavelength*1e9,(1-abs(r1).^2),'-b','linewidth',2);
hold on
plot(data(:,1),data(:,3),'b','linewidth',2);

xlabel('Wavelength (nm)');
ylabel('Reflectance');
title('6 bilayers reflectance plot at TE, normal incidence, 50 nm / 100 nm under geometric progression');
%legend('w/o gp','with gp and H-L scheme','with gp and L-H scheme');
%legend('With air as the incident medium','With Si as the incident medium');
grid on

