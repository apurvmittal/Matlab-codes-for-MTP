%Dielectric layers with widths in geometric progression
clear all;
n_1=3.5;
na=3.24;
nb=1.53;
r=1.1;   %geometric progression ratio
ta0=50e-9;
tb0=100e-9;
%ta0=92.33e-9;
%tb0=114.25e-9;
N=6; %number of bilayers to be used
%i=1:1:N;
ta=ta0*(r.^[0:N]);  %generate geometric progression with 'r' as the ratio
tb=tb0*(r.^[0:N]);
opt_ta=na.*ta;
opt_tb=nb.*tb;
newt=[opt_ta;opt_tb];
newt1=[opt_tb;opt_ta];

theta_d=8;         %angle of incidence at the slab in degrees
lmd0=300e-9;                    % starting wavelength of light in free space
lmdf=2000e-9;
c = 3e8;                %speed of light in vaccum
wavelength = [lmd0:1e-9:lmdf];
freq = c./wavelength;

mode = 'te';

% a 2 bilayer with gp
n2=[n_1,na,repmat([nb,na],1,2),n_1];
l2_gp=newt(1:2*2+1);
[r2_gp,z]=multidiel(n2,l2_gp,wavelength,theta_d,mode);

% a 3 bilayer with gp
n3=[n_1,na,repmat([nb,na],1,3),n_1];
l3_gp=newt(1:2*3+1);
[r3_gp,z]=multidiel(n3,l3_gp,wavelength,theta_d,mode);

% a 4 bilayer with gp
n4=[n_1,na,repmat([nb,na],1,4),n_1];
l4_gp=newt(1:2*4+1);
[r4_gp,z]=multidiel(n4,l4_gp,wavelength,theta_d,mode);

% a 6 bilayer with gp
n6 = [n_1,repmat([na,nb],1,N),na, n_1];
l6_gp=[newt(1:2*N+1)];
[r6_gp,z]=multidiel(n6,l6_gp,wavelength,theta_d,mode);

% a 6 bilayer with gp and LH combo
n61 = [n_1,repmat([nb,na],1,N),nb];
n61_air = [1,repmat([nb,na],1,N),nb];
l61_gp=[newt1(1:2*N)];
%l61_gp_ni=1e-9.*[nb*100,na*50,nb*110,na*55,nb*121,na*60,nb*133,na*66,nb*146,na*73,nb*161,na*80];
[r61_gp,z]=multidiel(n61,l61_gp,wavelength,theta_d,mode);
[r61_gp_air,z]=multidiel(n61_air,l61_gp,wavelength,theta_d,mode);


% a 6 bilayer w/o gp
l6=[repmat([na*ta0,nb*tb0],1,N),na*ta0];
[r6,z]=multidiel(n6,l6,wavelength,theta_d,mode);


% a 6 bilayer w/o gp and LH combo
n62=[n_1,repmat([nb,na],1,N),nb];
l62=[repmat([nb*tb0,na*ta0],1,N)];
[r62,z]=multidiel(n62,l62,wavelength, theta_d,mode);


% a 8 bilayer w/o gp
n8=[n_1,na,repmat([nb,na],1,8),n_1];
l8=[repmat([na*ta0,nb*tb0],1,8),na*ta0];
[r8,z]=multidiel(n8,l8,wavelength,theta_d,mode);

% a 2 bilayer w/o gp
l2=[repmat([na*ta0,nb*tb0],1,2),na*ta0];
[r2,z]=multidiel(n2,l2,wavelength,theta_d,mode);

% a 1 bilayer w/o gp
n1=[n_1,na,nb,na,n_1];
l1=[repmat([na*ta0,nb*tb0],1,1),na*ta0];
[r1,z]=multidiel(n1,l1,wavelength,theta_d,mode);

% a 4 bilayer w/o gp
l4=[repmat([na*ta0,nb*tb0],1,4),na*ta0];
[r4,z]=multidiel(n4,l4,wavelength,theta_d,mode);


%plot(wavelength*1e9,abs(r62).^2,'-b','linewidth',2);
%plot(wavelength*1e9,abs(r61_gp_air).^2,'-g','linewidth',2);
%hold on;
plot(wavelength*1e9,abs(r61_gp).^2,'-r','linewidth',2);
%plot(wavelength*1e9,abs(r4_gp).^2,'-c','linewidth',2);
%plot(wavelength*1e9,abs(r4).^2,'-_k','linewidth',2);

xlabel('Wavelength (nm)');
ylabel('Reflectance');
title('6 bilayers reflectance plot at TE, normal incidence, 50 nm / 100 nm under geometric progression');
%legend('w/o gp','with gp and H-L scheme','with gp and L-H scheme');
legend('With air as the incident medium','With Si as the incident medium');
grid on

