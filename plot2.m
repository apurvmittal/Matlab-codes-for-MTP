clc;
data1=load('80umabswoair50nm.txt');
data2=load('200umabswoair50nm.txt');

plot(data1(:,1),data1(:,2),'r','linewidth',2);
hold on
plot(data2(:,1),data2(:,2),'b','linewidth',2);
grid on;
xlabel('Wavelength (nm)','fontsize',16);
ylabel('Absorption','fontsize',16);
title('Absorption spectrum for different thickness of Si wafer','fontsize',18);
legend('80um Si wafer','200u Si wafer');