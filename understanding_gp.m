%Dielectric layers with widths in geometric progression
clc;
n_1=1;
na=2.8;
nb=1.53;
r=1.09;  %ratio of gp
ta0=57e-9;
tb0=106e-9;
Nt=10;
ta=ta0*(r.^[0:Nt]);  %generate geometric progression with 'r' as the ratio
tb=tb0*(r.^[0:Nt]);
opt_ta=na.*ta;
opt_tb=nb.*tb;

r2 = 1.1;
ta1=67e-9;
tb1=122e-9;
ta2=ta1*(r2.^[0:6]);  %generate geometric progression with 'r' as the ratio
tb2=tb1*(r2.^[0:6]);
opt_ta_50=na.*ta2;
opt_tb_50=nb.*tb2;

newt=[opt_ta;opt_tb];
newt1=[opt_tb;opt_ta];
newt_50=[opt_tb_50;opt_ta_50];

theta_d=0;         %angle of incidence at the slab in degrees
lmd0=200e-9;                    % starting wavelength of light in free space
lmdf=2000e-9;
c = 3e8;                %speed of light in vaccum
wavelength = [lmd0:1e-9:lmdf];
freq = c./wavelength;

mode = 'te';

% a single bilayer with gp
n1=[n_1,repmat([nb,na],1,1),nb];
l1_gp=newt(1:2);
[r1_gp,z]=multidiel(n1,l1_gp,wavelength,theta_d,mode);
plot(wavelength*1e9,abs(r1_gp).^2,'r','linewidth',2);
hold on;
n10=[n_1,repmat([nb,na],1,2),nb];
l10_gp=[newt(1:2),newt(1:2)];
[r10_gp,z]=multidiel(n10,l10_gp,wavelength,theta_d,mode);
plot(wavelength*1e9,abs(r10_gp).^2,'k','linewidth',2);
hold on;

n2=[n_1,repmat([nb,na],1,2),nb];
l2_gp=newt(1:4);
[r2_gp,z]=multidiel(n2,l2_gp,wavelength,theta_d,mode);
plot(wavelength*1e9,abs(r2_gp).^2,'b','linewidth',2);
hold on;

n3=[n_1,repmat([nb,na],1,3),nb];
l3_gp=newt(1:6);
[r3_gp,z]=multidiel(n3,l3_gp,wavelength,theta_d,mode);
plot(wavelength*1e9,abs(r3_gp).^2,'*b','linewidth',2);
%hold on;

n4=[n_1,repmat([nb,na],1,1),nb];
l4_gp=newt(7:8);
[r4_gp,z]=multidiel(n4,l4_gp,wavelength,theta_d,mode);
%plot(wavelength*1e9,abs(r4_gp).^2,'r','linewidth',2);
%hold on;

n5=[n_1,repmat([nb,na],1,1),nb];
l5_gp=newt(9:10);
[r5_gp,z]=multidiel(n5,l5_gp,wavelength,theta_d,mode);
%plot(wavelength*1e9,abs(r5_gp).^2,'r','linewidth',2);


% a 6 bilayer with gp and LH combo
n61 = [n_1,repmat([nb,na],1,6),nb];
%n61_Si = [nSi,repmat([nb,na],1,6),nb];
l61_gp=[newt1(1:2*6)];
%l61_gp_ni=1e-9.*[nb*100,na*50,nb*110,na*55,nb*121,na*60,nb*133,na*66,nb*146,na*73,nb*161,na*80];
[r61_gp,z]=multidiel(n61,l61_gp,wavelength,theta_d,mode);
%[r61_gp_Si,z]=multidiel(n61_Si,l61_gp_Si,wavelength,theta_d,mode);


% a 6 bilayer w/o gp
l6=[repmat([na*ta0,nb*tb0],1,6),na*ta0];
[r6,z]=multidiel(n6,l6,wavelength,theta_d,mode);


% a 8 bilayer with gp and LH combo
n81 = [n_1,nb,na,nb,na,repmat([nb,na],1,Nt),nb]%,na,nb];
l81_gp=[nb*tb0,na*ta0,nb*tb0,na*ta0,newt1(1:2*Nt)]%,nb*(164e-9),na*(89e-9)];
[r81_gp,z]=multidiel(n81,l81_gp,wavelength,theta_d,mode);


% a 8 bilayer w/o gp and LH combo and Si as incident medium
n8=[nSi,repmat([nb,na],1,N),nb];
l8=[repmat([nb*tb0,na*ta0],1,N)];
[r8lh,z]=multidiel(n8,l8,wavelength,theta_d,mode);

% a 8 bilayer w/o gp
n8=[n_1,na,repmat([nb,na],1,8),n_1];
l8=[repmat([na*ta0,nb*tb0],1,8),na*ta0];
[r8,z]=multidiel(n8,l8,wavelength,theta_d,mode);


%data = {wavelength' 100*abs(r4_gp).^2' 100*abs(r61_gp).^2' 100*abs(r81_gp).^2'};
%xlswrite('35-70nm.xlsx', data, 'Reflectance data for different bilayers', 'A3');
figure;
plot(wavelength*1e9,abs(r81_gp).^2,'-b*','linewidth',2);
hold on;
plot(wavelength*1e9,abs(r62).^2,'-r','linewidth',2);
%grid on;
xlabel('Wavelength (nm)','FontSize',16);
ylabel('Reflectance','Fontsize',16);
title('Reflectance plot at TE, 45deg incidence, 35 nm / 70 nm, 8 bilayers','FontSize',16);
legend('With GP', 'Without GP');
%figure;


