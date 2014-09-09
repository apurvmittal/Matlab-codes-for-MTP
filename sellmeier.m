% Reflectance with Sellmeier dispersion model incorporated

clear all;
n_1=1;
na=3.24;
nb=1.53;
r=1.15;   %geometric progression ratio
ta0=35e-9;
tb0=70e-9;

N=8; %number of bilayers to be used
ta=ta0*(r.^[0:N]);  %generate geometric progression with 'r' as the ratio
tb=tb0*(r.^[0:N]);
opt_ta=na.*ta;
opt_tb=nb.*tb;
newt=[opt_tb;opt_ta];

%ta_2=ta0*(r.^[0:N]);  %generate geometric progression with 'r' as the ratio
%tb_2=tb0*(r.^[0:N]);

theta_d=8;         %angle of incidence at the slab in degrees
lmd0=600e-9;                    % starting wavelength of light in free space
lmdf=2000e-9;
c = 3e8;                %speed of light in vaccum
wavelength = [lmd0:1e-9:lmdf];
freq = c./wavelength;

mode = 'te';
iter = (lmdf - lmd0)*1e9/10 + 1;

% Sellmeier parameters
A5 = 6; A52 = -1;
lmdr5 = 400e-9;
lmdr52 = 200e-9;
% Sellmeier equations
n = 1 + A5./(1-(lmdr5./wavelength).^2) + A52./(1-(lmdr52./wavelength).^2)
n_selmr = sqrt(n);


% a 6 bilayer 
n6=[n_1,repmat([nb,na],1,N),nb];
l6=[newt(1:2*N)];
[r6,z]=multidiel(n6,l6,wavelength,theta_d,mode);

% a 6 bilayer with variation in n
for i=1:iter
n6_n=[n_1,repmat([nb,n_selmr(i)],1,N),nb];
opt_ta_2=n_selmr(i).*ta;
opt_tb_2=nb.*tb;
newt2=[opt_tb_2;opt_ta_2];
l6_n=[newt2(1:2*N)];
[r6_n,z]=multidiel(n6,l6_n,wavelength,theta_d,mode);
end


%the experimental results
%data=load('res.txt');
%figure;
%plot(data(:,1),data(:,2),'r','linewidth',2);
%hold on;
%plot(data(:,1),data(:,3),'k','linewidth',2);
%hold on;
%plot(wavelength*1e9,100*abs(r6_25).^2,'-b','linewidth',2);
%hold on;
%plot(wavelength*1e9,100*abs(r6_33).^2,'-c','linewidth',2);
%hold on;
plot(wavelength*1e9,100*abs(r6).^2,'-r','linewidth',2);
hold on;
plot(wavelength*1e9,100*abs(r6_n).^2,'-b','linewidth',2);

%plot(wavelength*1e9,100*abs(r6_50_k).^2,'-c','linewidth',2);


xlabel('Wavelength (nm)','FontSize',16);
ylabel('% Reflectance','FontSize',16);
title('Reflectance plot at TE');
legend('Uniform model','Sellmeier Model');
grid on
