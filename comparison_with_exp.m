clear all;
file = 'reflectance.xlsx';
sheet = '1';
wavelength = xlsread(file, sheet, 'A4:A174');
refl_50_100 = xlsread(file, sheet, 'B4:B174');
refl_25_50 = xlsread(file, sheet, 'C4:C174');
%plot(wavelength, refl_50_100, '-b', 'linewidth','2');