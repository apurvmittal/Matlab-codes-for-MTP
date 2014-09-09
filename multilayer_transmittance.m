% Transmittance and reflectance for 1 bilayer of (SixNy/SixONy) as a function of
% wavelength

n_1=1;     %refractive index of medium 1 (air)
n_s=1.46;   %refractive index of medium 2 (SixNy)
n_3=1;   %refractive index of medium 3 (SixONy)
n_4=1;     %refractive index of medium 4 (air)

lmd0=500e-9;                    % starting wavelength of light in free space
lmdf=800e-9;
lmd=lmd0;
t=1e-6;                         %thickness of slab              
%k=2*pi/lmd;                    %free space wave constant
%ks=k*n_s;                      %wave constant in dielectric slab
theta_d=50;                     %angle of incidence at the slab in degrees
theta=theta_d*pi/180;           %angle of incidence at the slab in radians
beta=asin(n_1*sin(theta)/n_s);  %angle of refraction for 1/2 interface
gamma=asin(n_s*sin(beta)/n_3);  %angle of refraction for 2/3 interface
alpha=asin(n_3*sin(gamma)/n_4); %angle of refraction for 3/4 interface

%reflection(p1,p2) and transmission(t1,t2) coefficients for interfaces between 1/2 and
%2/3 respectively

p1=(n_1*cos(theta)-n_s*cos(beta))/(n_1*cos(theta)+n_s*cos(beta));
p2=(n_s*cos(beta)-n_3*cos(gamma))/(n_s*cos(beta)+n_3*cos(gamma));
%p3=(n_3*cos(gamma)-n_4*cos(alpha))/(n_3*cos(gamma)+n_4*cos(alpha));

t1=2*n_1*cos(theta)/(n_1*cos(theta)+n_s*cos(beta));
t2=2*n_s*cos(beta)/(n_s*cos(beta)+n_3*cos(gamma));
%t3=2*n_3*cos(gamma)/(n_3*cos(gamma)+n_4*cos(alpha));
%Transformation matrix
int12=1/t1*[1, p1; p1, 1]; %E field matrix for interface 1/2
int23=1/t2*[1, p2; p2, 1]; %E field matrix for interface 2/3
%int24=1/t3*[1, p3; p3, 1];
xlabel('Wavelength in meters');
ylabel('Reflectance');
title('Plot of reflectance with wavelength');
wavelength=[];
reflectance_1=[];
for lmd=lmd0:1e-9:lmdf
k=2*pi./lmd;
ks=k*n_s; %wave number in medium s
k3=k*n_3; %wave number in medium 3
ph2=[exp(-1i*ks*t), 0; 0, exp(1i*ks*t)];
%ph3=[exp(-1i*k3*t), 0; 0, exp(1i*k3*t)];
%M = int12*ph2*int23*ph3*int24;
M = int12*ph2*int23;
Tpwr=abs(1/M(1,1))^2;
Rpwr=abs(M(2,1)/M(1,1))^2;

%Overall transmission coefficient
%T=t1*t2*exp(-1i*t*ks)./(1+p1*p2*exp(-2*1i*t*ks));
%Overall reflection coefficient
%R=(p1+p2*exp(-2*1i*t*ks))./(1+p1*p2*exp(-2*1i*t*ks));
%Overall transmittance (Power transmitted / Power incident)
%Tpwr=(abs(T)).^2;
%plot(lmd,Tpwr,'r+--','LineWidth',2);
%hold on;
wavelength=[wavelength lmd];
reflectance_1=[reflectance_1 Rpwr];

end

figure(1);
plot(wavelength,reflectance_1,'-r','linewidth',2)
