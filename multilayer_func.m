% Transmittance and reflectance for 1 bilayer of (SixNy/SixONy) as a function of
% wavelength

n_1=1;     %refractive index of medium 1 (air)
n_s=3;   %refractive index of medium 2 (SixNy)
n_3=1.5;   %refractive index of medium 3 (SixONy)
n_4=1;     %refractive index of medium 4 (air)
theta_d=0;                     %angle of incidence at the slab in degrees
theta=theta_d*pi/180;
lmd0=200e-9;                    % starting wavelength of light in free space
lmdf=1000e-9;
lmd=lmd0;
t_s=50e-9;                         %thickness of SixNy            
t_3=100e-9;                         %thickness of SixONy
%reflection(p1,p2) and transmission(t1,t2) coefficients for interfaces between 1/2 and
%2/3 respectively
[p1,t1,a1]=refl(n_1,n_s,theta);
[p2,t2,a2]=refl(n_s,n_3,a1);
[p3,t3,a3]=refl(n_3,n_s,a2);
[p4,t4,a4]=refl(n_s,n_3,a3);
[p5,t5,a5]=refl(n_3,n_s,a4);
[p6,t6,a6]=refl(n_s,n_3,a5);
[p7,t7,a7]=refl(n_3,n_s,a6);
[p8,t8,a8]=refl(n_s,n_3,a7);
[p9,t9,a9]=refl(n_3,n_s,a8);
[p10,t10,a10]=refl(n_s,n_4,a9);
%[p11,t11,a11]=refl(n_s,n_3,a10);

%Transformation matrix
int12=1/t1*[1, p1; p1, 1]; %E field matrix for interface 1/2
int23=1/t2*[1, p2; p2, 1]; %E field matrix for interface 2/3
int34=1/t3*[1, p3; p3, 1]; %E field matrix for interface 3/4
int45=1/t4*[1, p4; p4, 1]; %E field matrix for interface 4/5
int56=1/t5*[1, p5; p5, 1]; %for inteface 5/6
int67=1/t6*[1, p6; p6, 1]; %for interface 6/7
int78=1/t7*[1, p7; p7, 1]; %for interface 7/8
int89=1/t8*[1, p8; p8, 1]; %8/9
int910=1/t9*[1, p9; p9, 1]; %9/10
int1011=1/t10*[1, p10; p10, 1]; %10/11
intns_air=int1011;

Tpwr=0;
Rpwr=0;

wavelength=[];
freq=[];
reflectance_1=[];
reflectance_2=[];
reflectance_3=[];
reflectance_4=[];
reflectance_5=[];

for lmd=lmd0:1e-9:lmdf
k=2*pi./lmd;
f = 3e8./lmd;
ks=k*n_s*cos(theta); %wave number in medium s
k3=k*n_3*cos(a1); %wave number in medium 3
ph2=[exp(1i*ks*t_s), 0; 0, exp(-1i*ks*t_s)];
ph3=[exp(1i*k3*t_3), 0; 0, exp(-1i*k3*t_3)];
M2 = int12*ph2*int23*ph3*int34*ph2*int45*ph3*int56*ph2*intns_air; % 2 bilayers
M1 = int12*ph2*int23*ph3*int34*ph2*intns_air;                     % 1 bilayer
M3 = M2*int67*ph3*int78*ph2; % 3 bilayers
M4 = M3*int89*ph3*int910*ph2; % 4 bilayers
M5 = int12*ph2*int23*ph3*intns_air;                               % huha bilayer

Tpwr1=abs(1/M1(1,1))^2;
Rpwr1=abs(M1(2,1)/M1(1,1))^2;

Tpwr2=abs(1/M2(1,1))^2;
Rpwr2=abs(M2(2,1)/M2(1,1))^2;

Tpwr3=abs(1/M3(1,1))^2;
Rpwr3=abs(M3(2,1)/M3(1,1))^2;

Tpwr4=abs(1/M4(1,1))^2;
Rpwr4=abs(M4(2,1)/M4(1,1))^2;

Tpwr5=abs(1/M5(1,1))^2;
Rpwr5=abs(M5(2,1)/M5(1,1))^2;

%Overall transmission coefficient
%T=t1*t2*exp(-1i*t*ks)./(1+p1*p2*exp(-2*1i*t*ks));
%Overall reflection coefficient
%R=(p1+p2*exp(-2*1i*t*ks))./(1+p1*p2*exp(-2*1i*t*ks));
%Overall transmittance (Power transmitted / Power incident)
%Tpwr=(abs(T)).^2;
%plot(lmd,Rpwr4,'-r');
%hold on;

wavelength=[wavelength lmd];
freq = [freq f];
reflectance_1=[reflectance_1 Rpwr1];
reflectance_2=[reflectance_2 Rpwr2];
reflectance_3=[reflectance_3 Rpwr3];
reflectance_4=[reflectance_4 Rpwr4];
reflectance_5=[reflectance_5 Rpwr5];

end
figure(1);
xlabel('Frequency (Hz)');
ylabel('Reflectance');
title('Plot of reflectance with frequency');
%plot(freq,reflectance_5,'-g','linewidth',2);
%hold on;
%plot(wavelength,reflectance_2,'-g','linewidth',2);
%plot(wavelength,reflectance_3,'-b','linewidth',2);
%plot(wavelength,reflectance_4,'-k','linewidth',2);

%comparison with Orfanidis code for multilayer optical simulation - a
%single bilayer configuration

n=[n_1,n_s,n_3,n_4];
l=[n_s*t_s,n_3*t_3];
[g,z]=multidiel(n,l,wavelength,theta_d,'te');
%plot(freq,abs(g).^2,'-b','linewidth',2);
xlabel('Frequency (Hz)');
ylabel('Reflectance');
title('60 degree reflectance');
hold on;

%comparison with Orfanidis code for multilayer optical simulation - a
% dielectric mirror bilayer configuration
% a 2 bilayer

n=[n_1,n_s,n_3,n_s,n_3,n_s,n_4];
l=[n_s*t_s,n_3*t_3,n_s*t_s,n_3*t_3,n_s*t_s];
[g,z]=multidiel(n,l,wavelength,theta_d,'te');
plot(freq,abs(g).^2,'-b','linewidth',2);
xlabel('Wavelength (m)');
ylabel('Reflectance');
title('0 degree reflectance');
grid on;
hold on;

% a 3 bilayer

n=[n_1,n_s,n_3,n_s,n_3,n_s,n_3,n_s,n_4];
l=[n_s*t_s,n_3*t_3,n_s*t_s,n_3*t_3,n_s*t_s,n_3*t_3,n_s*t_s];
[g,z]=multidiel(n,l,wavelength,theta_d,'te');
plot(freq,abs(g).^2,'-r','linewidth',2);
xlabel('Wavelength (m)');
ylabel('Reflectance');
title('0 degree reflectance');


%comparison with the COMSOL results

format long g;
data=load('a_0d_dielectric_mirror_2bi.txt');
%plot(data(:,1),data(:,2),'r','linewidth',2);



