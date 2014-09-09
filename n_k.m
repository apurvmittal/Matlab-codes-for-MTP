% Obtaining n, k values for the material from transmittance, reflectance and
%thickness of the material

%The reflectance and transmittance of the thin film-substrate combination
%is measured

%Apurv Mittal, 31/05

d = 100nm; % thickness of the material

nf = (1 + R + sqrt(R))/(1 - R); % applied where absorption is high and interference can be neglected

alpha = -log(T/(1-R)^2)/d; % extinction coeff

k = alpha * lambda / 4*pi*d;

%Envelope method of finding n and k

product = (n-1)*(n-ns)*((Tmax/Tmin + 1)^1/2)/((n+1)*(n+ns)*((Tmax/Tmin - 1)^1/2));

alpha_env = -log(product)/d;

k_env = alpha_env * lambda / 4*pi*d;