function [p,t,beta] = refl(n1,n2,alpha) %gives me reflection and transmission coeff and angle of refraction when light is incident f
%from a medium of refractive index n1 at an angle alpha to a medium with
%refractive index n2, s-polarization
beta=asin(n1*sin(alpha)/n2);
p=(n1*cos(alpha)-n2*cos(beta))/(n1*cos(alpha)+n2*cos(beta));
t=2*n1*cos(alpha)/(n1*cos(alpha)+n2*cos(beta));
end