% Estimating the complex refractive index of a material using transmittance
% and reflectance measurements of a thin film single layer on a thick glass substrate
% using Sellmeier dispersion model

clc;
n_1=1;
na=3.5;
k=2.4e-2;
ta0=80e-6;
N=1;

theta_d=0;         %angle of incidence at the slab in degrees
lmd0=300e-9;                    % starting wavelength of light in free space
lmdf=2000e-9;
c = 3e8;                %speed of light in vaccum
wavelength = [lmd0:10e-9:lmdf];
freq = c./wavelength;
mode = 'te';

iter = (lmdf - lmd0)/10e-9 + 1; 
n1 = [n_1,na,n_1];
[r2,z2]=multidiel(n1,na*ta0,wavelength,theta_d,mode);
r2abs = abs(r2).^2;
tr2 = 1 - r2abs;

for h=1:iter+1
%n1 = [n_1,n_selmr(h),nb];
nk=na-1i*k;
n2(h,:)=[n_1,nk,n_1];
end

[r22,z22]=multidiel2(n2,ta0,freq./c,theta_d,mode);
r2abs2 = abs(r22).^2;
tr22 = 1 - r2abs2;

% Plot
plot(wavelength*1e9,r2abs2,'k','linewidth',2);
hold on
%plot(wavelength*1e9,n_selmr,'r','linewidth',2);
%plot(data(:,1),ref+tr, 'k','linewidth',2);
xlabel('Wavelength (nm)','FontSize',15);
ylabel('reflectance','FontSize',15);
title('Reflectance curve','FontSize',16);
%legend('Imaginary part of refractive index','Real part of refractive index');
grid on




% code to write into the excel sheet
%data = {wavelength' 100*abs(r61_gp).^2' 100*abs(r61_gp2).^2' 100*abs(r61_gp3).^2' 100*abs(r61_gp4).^2' };
%xlswrite('test.xlsx', data, 'Reflectance data for different r', 'A3');

