lmbd0 = [1:1:15];
nhl = [1.1:0.2:2];

rho = (nhl-1)./(nhl+1);
plot(nhl,rho);
figure;
c = [1./acos(rho) - 1./acos(-rho)]./2;
color = ['r','b','k','c','g'];
for i=1:1:5
bw4 = pi*c(i).*lmbd0;
set(gcf,'color','w');
set(gca,'FontSize',16);
plot(lmbd0*100,bw4*100,color(i),'linewidth',2);
xlabel('Central wavelength (nm)','FontSize',16);
ylabel('Maximum bandwidth (nm)','Fontsize',16);
hold on;
end
