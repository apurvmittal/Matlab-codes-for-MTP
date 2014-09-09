format long g;
data=load('res.txt');
figure;
plot(data(:,1),data(:,2),'r','linewidth',2);
hold on;
plot(data(:,1),data(:,3),'b','linewidth',2);
grid on;


