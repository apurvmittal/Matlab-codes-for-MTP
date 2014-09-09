% Estimating the complex refractive index of a material using transmittance
% and reflectance measurements of a thin film single layer on a thick glass substrate
% using Sellmeier dispersion model

clc;
n_1=1;
na=3.29;
nb=1.53;
ta0=80e-6;
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

% Sample 2
A2 = 4.35;  
lmdr2 = 330e-9;

% Sample 4
A4 = 5.65;
lmdr4 = 310e-9;

% Sample 5
A5 = 6.5;
lmdr5 = 380e-9;

% Sample 6
A6 = 8.2;
lmdr6 = 300e-9;
A62 = 0.00123;
lmdr62 = 0e-9;
A63 = 0;
lmdr63 = 0e-6;

data = load('tr6_ref6.txt');
ref = data(:,2)/100;
tr = data(:,3)/100;
abso = 1.047 - ref - tr;         
abs_coeff = 2.303*abso./ta0;
abs_coeff_m = abs_coeff';
k = abs_coeff_m.*(wavelength)./(4*pi);

abs_coeff2 = -log(tr./((1-ref).^2))/ta0;
abs_coeff_m2 = abs_coeff2';
k2 = abs_coeff_m2.*wavelength./(4*pi);

% Sellmeier equations
n = 1 + A6./(1-(lmdr6./wavelength).^2) + A62./(1-(lmdr62./wavelength).^2) + A63./(1-(lmdr63./wavelength).^2);
n_selmr = sqrt(n);

% refractive index in high absorption region
n_highabs = (1 + ref + sqrt(ref))./ (1 - ref);
nh=n_highabs';
m=28;
n = [nh(1:m),n_selmr(m:iter)];

for j=1:iter
    if ((wavelength(j) < 600e-9) && (n_highabs(j) == n_selmr(j)))
        m=j;
    end
end

% ensuring that we take only +ve values for k
for j=1:iter+1
if k2(j) < 0
    k2(j) = 0;
end
end




r = [];
% a single layer
for h=1:iter+1
%n1 = [n_1,n_selmr(h),nb];
nk(h)=n(h)-1i*k2(h);
n1 = [n_1,nk(h),nb];
opt_ta=n(h).*ta0;
l1=[opt_ta];
[r1,z]=multidiel(n1,l1,wavelength(h),theta_d,mode);
r = [r,r1];
n2(h,:)=[n_1,nk(h),nb];
end

ref_simulated = abs(r).^2;
tr_simulated = 1 - ref_simulated;  % Provided there is negligible absorption


[r2,z2]=multidiel2(n2,ta0,freq./c,theta_d,mode);
r2abs = abs(r2).^2;
tr2 = 1 - r2abs;

dev = r2abs - ref';
avg_dev = sum(dev)/iter;


% Plot
plot(wavelength*1e9,k2,'k','linewidth',2);
hold on
plot(wavelength*1e9,n_selmr,'r','linewidth',2);
%plot(data(:,1),ref+tr, 'k','linewidth',2);
xlabel('Wavelength (nm)','FontSize',15);
ylabel('Refractive index','FontSize',15);
title('Real refractive index of SixNy','FontSize',16);
legend('Imaginary part of refractive index','Real part of refractive index');
grid on
figure;

%plot(wavelength*1e9,n,'b','linewidth',2);
%figure;

plot(wavelength.*1e9,tr+ref,'-r','linewidth',2);
%plot(data(:,1),tr, 'k','linewidth',2);
hold on
plot(data(:,1),ref, 'b','linewidth',2);
plot(wavelength*1e9,r2abs,'k','linewidth',2);
xlabel('Wavelength (nm)','FontSize',15);
ylabel('Reflectance','FontSize',15);
title('Experimental and simulated reflectance of single SixNy layer on glass substrate','FontSize',16);
legend('Reflectance + Transmittance','Experimental reflectance','Simulated reflectance');
grid on


% code to write into the excel sheet
%data = {wavelength' 100*abs(r61_gp).^2' 100*abs(r61_gp2).^2' 100*abs(r61_gp3).^2' 100*abs(r61_gp4).^2' };
%xlswrite('test.xlsx', data, 'Reflectance data for different r', 'A3');

