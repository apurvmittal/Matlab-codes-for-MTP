data=load('80u_abs.txt');
data2=load('200u_abs.txt');
data3=load('Si.txt');

% Plot
plot(data(:,1),data(:,2),'r','linewidth',2);
hold on;
plot(data2(:,1),data2(:,2),'b','linewidth',2);
figure;
plot(data3(:,1),data3(:,3),'k','linewidth',2);

