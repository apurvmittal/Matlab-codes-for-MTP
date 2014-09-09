%Dielectric layers with widths in geometric progression
clc;
n_1=1;
nSi=3.5
na=2.8;
nb=1.53;
%r=1.08;   %geometric progression ratio
r=1.05;  %600 nm - 1400 nm
Nt=15;
ta0=57e-9;  
tb0=106e-9;
ta=ta0*(r.^[0:Nt]);  %generate geometric progression with 'r' as the ratio
tb=tb0*(r.^[0:Nt]);
opt_ta=na.*ta;
opt_tb=nb.*tb;


r1=1.07;
Nt1=17; %number of bilayers to be used
ta3=45e-9;
tb3=82e-9;
ta4=ta3*(r1.^[0:Nt1]);  %generate geometric progression with 'r' as the ratio
tb4=tb3*(r1.^[0:Nt1]);
opt_ta2=na.*ta4;
opt_tb2=nb.*tb4;


r3=1.05;
Nt3=12; %number of bilayers to be used
ta5=62.5e-9;
tb5=115e-9;
ta6=ta5*(r3.^[0:Nt3]);  %generate geometric progression with 'r' as the ratio
tb6=tb5*(r3.^[0:Nt3]);
opt_ta3=na.*ta6;
opt_tb3=nb.*tb6;

r2 = 1.1;
N=8;
ta1=89e-9;
tb1=163e-9;
ta2=ta1*(r2.^[0:N]);  %generate geometric progression with 'r' as the ratio
tb2=tb1*(r2.^[0:N]);

newt1=[opt_tb;opt_ta];
newt2=[opt_tb2;opt_ta2];
newt3=[opt_tb3;opt_ta3];

theta_d=0;         %angle of incidence at the slab in degrees
lmd0=400e-9;                    % starting wavelength of light in free space
lmdf=1700e-9;
c = 3e8;                %speed of light in vaccum
wavelength = [lmd0:5e-9:lmdf];
freq = c./wavelength;

mode = 'te';


% a 6 bilayer with gp
n6 = [n_1,repmat([nb,na],1,N),nb];

% a 6 bilayer with gp and LH combo
n61 = [n_1,repmat([nb,na],1,N),nb];
%n61_Si = [nSi,repmat([nb,na],1,6),nb];
l61_gp=[newt1(1:2*N)];
%l61_gp_ni=1e-9.*[nb*100,na*50,nb*110,na*55,nb*121,na*60,nb*133,na*66,nb*146,na*73,nb*161,na*80];
[r61_gp,z]=multidiel(n61,l61_gp,wavelength,theta_d,mode);
%[r61_gp_Si,z]=multidiel(n61_Si,l61_gp_Si,wavelength,theta_d,mode);


% a 6 bilayer w/o gp
l6=[repmat([nb*tb3,na*ta3],1,N)];
[r6,z]=multidiel(n6,l6,wavelength,theta_d,mode);


% a 6 bilayer w/o gp and LH combo
n62=[n_1,repmat([nb,na],1,N),nb];
l62=[repmat([nb*tb1,na*ta1],1,N)];
[r62,z]=multidiel(n62,l62,wavelength, theta_d,mode);


% a Nt bilayer with gp and LH combo
n81 = [n_1,repmat([nb,na],1,Nt),nb];%,na,nb];
l81_gp=[newt1(1:2*Nt)];%,nb*(164e-9),na*(89e-9)];
[r81_gp,z]=multidiel(n81,l81_gp,wavelength,theta_d,mode);

% a Nt1 bilayer with gp and LH combo
n82 = [n_1,repmat([nb,na],1,Nt1+3),nb];%,na,nb];
l82_gp=[repmat([nb*tb3,na*ta3],1,3),newt2(1:2*Nt1)];%,nb*(164e-9),na*(89e-9)];
[r82_gp,z]=multidiel(n82,l82_gp,wavelength,theta_d,mode);

% a Nt3 bilayer with gp and LH combo
n83 = [n_1,repmat([nb,na],1,Nt3),nb];%,na,nb];
l83_gp=[newt3(1:2*Nt3)];%,nb*(164e-9),na*(89e-9)];
[r83_gp,z]=multidiel(n83,l83_gp,wavelength,theta_d,mode);

% a 8 bilayer with gp and LH combo and Si as incident medium
n81_Si = [nSi,repmat([nb,na],1,N),nb];
l81_gp_Si=[newt1(1:2*N)];
[r81_gp_Si,z]=multidiel(n81_Si,l81_gp_Si,wavelength,theta_d,mode);

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
set(gcf,'color','w');
set(gca,'FontSize',16);
plot(wavelength*1e9,100*abs(r83_gp).^2,'-bo','linewidth',2);
hold on;
plot(wavelength*1e9,100*abs(r81_gp).^2,'-r+','linewidth',2);

%plot(wavelength*1e9,100*abs(r82_gp).^2,'-k','linewidth',2);
plot(wavelength*1e9,100*abs(r62).^2,'-c','linewidth',2);

%grid on;
xlabel('Wavelength (nm)','FontSize',16);
ylabel('Reflectance (%)','Fontsize',16);
%title('','FontSize',16);
%legend('With GP', 'Without GP');
%figure;

