%Dielectric layers with widths in geometric progression
clc;
n_1=1;
na=3;
nb=1.5;
r=1.1;   %geometric progression ratio
ta0=50e-9;
tb0=100e-9;
N=6; %number of bilayers to be used
%i=1:1:N;
ta=ta0*(r.^[0:N]);  %generate geometric progression with 'r' as the ratio
tb=tb0*(r.^[0:N]);
opt_ta=na.*ta;
opt_tb=nb.*tb;
newt=[opt_ta;opt_tb]


theta_d=45;         %angle of incidence at the slab in degrees
lmd0=200e-9;                    % starting wavelength of light in free space
lmdf=1200e-9;
c = 3e8;                %speed of light in vaccum
wavelength = [lmd0:1e-9:lmdf];
freq = c./wavelength;

mode = 'tm';

% a 2 bilayer with gp
n=[n_1,na,nb,na,nb,na,n_1];
l=[na*ta(1),nb*tb(1),na*ta(2),nb*tb(2),na*ta(3)];
[g,z]=multidiel(n,l,wavelength,theta_d,mode);

% a 3 bilayer with gp
n2=[n_1,na,nb,na,nb,na,nb,na,n_1];
l2=[na*ta(1),nb*tb(1),na*ta(2),nb*tb(2),na*ta(3),nb*tb(3),na*ta(4)];
[g2,z]=multidiel(n2,l2,wavelength,theta_d,mode);

% a 4 bilayer with gp
n3=[n_1,na,nb,na,nb,na,nb,na,nb,na,n_1];
l3=[na*ta(1),nb*tb(1),na*ta(2),nb*tb(2),na*ta(3),nb*tb(3),na*ta(4),nb*tb(4),na*ta(5)];
[g3,z]=multidiel(n3,l3,wavelength,theta_d,mode);

% a 6 bilayer with gp
n6 = [n_1,na,repmat([nb,na],1,N),n_1];
l6_gp=newt(1:2*N+1);
[r6_gp,z]=multidiel(n6,l6_gp,wavelength,theta_d,mode);

% a 6 bilayer w/o gp
l6=[repmat([na*ta(1),nb*tb(1)],1,N),na*ta(1)];
[r6,z]=multidiel(n6,l6,wavelength,theta_d,mode);

% a 8 bilayer w/o gp
n8=[n_1,na,nb,na,nb,na,nb,na,nb,na,nb,na,nb,na,nb,na,nb,na,n_1];
l8=[na*ta(1),nb*tb(1),na*ta(1),nb*tb(1),na*ta(1),nb*tb(1),na*ta(1),nb*tb(1),na*ta(1),nb*tb(1),na*ta(1),nb*tb(1),na*ta(1),nb*tb(1),na*ta(1),nb*tb(1),na*ta(1)];
[g8,z]=multidiel(n8,l8,wavelength,theta_d,mode);

% a 2 bilayer w/o gp
l1=[na*ta(1),nb*tb(1),na*ta(1),nb*tb(1),na*ta(1)];
[g1,z]=multidiel(n,l1,wavelength,theta_d,mode);

% a 4 bilayer w/o gp
n9=[n_1,na,nb,na,nb,na,nb,na,nb,na,n_1];
l9=[na*ta(1),nb*tb(1),na*ta(1),nb*tb(1),na*ta(1),nb*tb(1),na*ta(1),nb*tb(1),na*ta(1)];
[g9,z]=multidiel(n9,l9,wavelength,theta_d,mode);


%plot(wavelength*1e9,abs(g1).^2,'-r','linewidth',2);
%hold on;
%plot(wavelength*1e9,abs(g9).^2,'-b','linewidth',2);
%plot(wavelength*1e9,abs(g).^2,'-b','linewidth',2);
%plot(wavelength*1e9,abs(g2).^2,'-g','linewidth',2);
%plot(wavelength*1e9,abs(g3).^2,'-c','linewidth',2);
plot(wavelength*1e9,abs(r6_gp).^2,'-r','linewidth',2);
hold on;
plot(wavelength*1e9,abs(r6).^2,'-b','linewidth',2);

xlabel('Wavelength (nm)');
ylabel('Reflectance');
title('Reflectance plot at TE, normal incidence, 25nm/50nm');
legend('6 bilayer with gp=1.1','6 bilayer w/o gp')%'4 bilayer with gp=1.25','6 bilayer with gp=1.25');
grid on

