% Transmittance and reflectance for a slab of dielectric as a function of
% wavelength

n_1=1;     %refractive index of medium 1 (air)
n_s=1.8;  %refractive index of medium 2 (dielectric slab)
n_3=1;     %refractive index of medium 3 (air)

lmd0=500e-9;                    %wavelength of light in free space
lmdf=800e-9;
lmd=lmd0;
t=1e-6;                         %thickness of slab              
%k=2*pi/lmd;                    %free space wave constant
%ks=k*n_s;                       %wave constant in dielectric slab
theta_d=0;                     %angle of incidence at the slab in degrees
theta=theta_d*pi/180;           %angle of incidence at the slab in radians
beta=asin(n_1*sin(theta)/n_s);  %angle of refraction for 1/2 interface
gamma=asin(n_s*sin(beta)/n_3);  %angle of refraction for 2/3 interface

%reflection(p1,p2) and transmission(t1,t2) coefficients for interfaces between 1/2 and
%2/3 respectively

p1=(n_1*cos(theta)-n_s*cos(beta))/(n_1*cos(theta)+n_s*cos(beta));
p2=(n_s*cos(beta)-n_3*cos(gamma))/(n_s*cos(beta)+n_3*cos(gamma));
%t1=1+p1;
%t2=p2+1;
t1=2*n_1*cos(theta)/(n_1*cos(theta)+n_s*cos(beta));
t2=2*n_s*cos(beta)/(n_s*cos(beta)+n_3*cos(gamma));

%Transformation matrix
int12=[1, p1; p1, 1]; %E field matrix for interface 1/2
int23=[1, p2; p2, 1]; %E field matrix for interface 2/3

xlabel('Wavelength in meters');
ylabel('Transmittance');
title('Plot of transmittance with wavelength');

lmd=lmd0:1e-9:lmdf;
%lmb=lmd0;
k=2*pi./lmd;
ks=k*n_s*cos(theta);
ph=[exp(1i*ks*t), 0; 0, exp(-1i*ks*t)];
%M = int12*ph*int23.*1/(t1*t2);
%Tpwr=abs(1/M(1,1))^2;
%Rpwr=abs(M(2,1)/M(1,1))^2;

%Overall transmission coefficient
T=t1*t2*exp(-1i*t*ks)./(1+p1*p2*exp(-2*1i*t*ks));
%Overall reflection coefficient
R=(p1+p2*exp(-2*1i*t*ks))./(1+p1*p2*exp(-2*1i*t*ks));
%Overall transmittance (Power transmitted / Power incident)
Tpwr=(abs(T)).^2;
Rpwr=(abs(R)).^2;
f = 1./lmd;
%plot(lmd,Rpwr,'r+--','LineWidth',2);
plot(f,Rpwr,'-b','linewidth',2);
hold on;
%end
n=[n_1,n_s,n_3];
l=[n_s*t];
lmda = linspace(lmd0,lmdf,301)/800e-9;
[g,z]=multidiel(n,l,lmd,theta_d,'te');
plot(f,abs(g).^2,'r','linewidth',2);


