%Trying to find out how layers with thickness in GP affect the reflectance- 1/5/14

clear all;
n_1=1;
na=3;
nb=1.5;
r1=1;   %geometric progression ratio
r2=1.1; %geometric progression ratio 
ta0=50e-9;
tb0=100e-9;

N=6; %number of bilayers to be used
%i=1:1:N;
ta=ta0*(r1.^[0:N]);  %generate geometric progression with 'r' as the ratio
tb=tb0*(r1.^[0:N]);
opt_ta=na.*ta;
opt_tb=nb.*tb;
newt=[opt_ta;opt_tb];

ta_5=ta0*(r2.^[0:N]);  %generate geometric progression with 'r' as the ratio
tb_5=tb0*(r2.^[0:N]);
opt_ta_5=na.*ta_5;
opt_tb_5=nb.*tb_5;
newt1=[opt_ta_5;opt_tb_5];

theta_d=0;         %angle of incidence at the slab in degrees
lmd0=200e-9;                    % starting wavelength of light in free space
lmdf=1400e-9;
c = 3e8;                %speed of light in vaccum
wavelength = [lmd0:1e-9:lmdf];
freq = c./wavelength;

mode = 'te';

% a 12 bilayer with 25 nm/50 nm and 50 nm/100 nm combination
n2=[n_1,na,repmat([nb,na],1,N),n_1];
l2=newt(1:2*N+1);
l2_0=[newt1(1:2*N+1)];
l2_1=[newt1(1:2*N),50e-9];
[r2,z]=multidiel(n2,l2,wavelength,theta_d,mode);
[r2_0,z]=multidiel(n2,l2_0,wavelength,theta_d,mode);
[r2_1,z]=multidiel(n2,l2_1,wavelength,theta_d,mode);

n1=[n_1,na,nb,na,n_1]
l1=[na*ta0,nb*tb0,na*ta0*1.1];
n2=[n_1,na,nb,na,nb,na,n_1];
l2=[na*1.1*ta0,nb*1.1*tb0,na*1.21*ta0];
l12=[na*ta0,nb*tb0,na*ta0*1.1,nb*1.1*tb0,na*1.21*ta0];

l5=[na*1.21*ta0,nb*1.21*tb0,na*1.331*ta0];
l6=[na*1.331*ta0,nb*1.331*tb0,na*(1.1^4)*ta0];
l7=[na*1.331*1.1*ta0,nb*1.331*1.1*tb0,na*(1.1^5)*ta0];

[r1,z]=multidiel(n1,l1,wavelength,theta_d,mode);

[r2,z]=multidiel(n1,l2,wavelength,theta_d,mode);
[r12,z]=multidiel(n2,l12,wavelength,theta_d,mode);

[r5,z]=multidiel(n1,l5,wavelength,theta_d,mode);

[r6,z]=multidiel(n1,l6,wavelength,theta_d,mode);
[r7,z]=multidiel(n1,l7,wavelength,theta_d,mode);

n4=[n_1,na,repmat([nb,na],1,4),n_1];
l4_gp=newt1(1:2*4+1);
[r4_gp,z]=multidiel(n4,l4_gp,wavelength,theta_d,mode);

plot(wavelength*1e9,abs(r1).^2,'-k','linewidth',2);
hold on;
plot(wavelength*1e9,abs(r2).^2,'-b','linewidth',2);
plot(wavelength*1e9,abs(r12).^2,'-r','linewidth',2);
plot(wavelength*1e9,abs(r5).^2,'-g','linewidth',2);
plot(wavelength*1e9,abs(r6).^2,'-c','linewidth',2);
plot(wavelength*1e9,abs(r4_gp).^2,'-k','linewidth',2);


xlabel('Wavelength (nm)');
ylabel('Reflectance');
title('Reflectance plot at TE, normal incidence, GP = 1.1');
legend('50 nm / 100 nm 2bilayers w/o gp','50 nm / 100 nm 2bilayers with gp');
grid on
