function [C0,Vega] = valueBS(Spot,K,r,q,T,Sigma,e)
% Function with the necesary steps for to obtain European vanilla call value at time 0

d1 = (log(Spot/K)+(r-q)*T)/Sigma*sqrt(T)+Sigma*sqrt(T)/2;
d2 = d1-Sigma*sqrt(T);

C0 = e*Spot*exp(-q*T)*normcdf(e*d1)-e*K*exp(-r*T)*normcdf(e*d2);

% Now for to find Vega, its needed to find n(x), which is the density of the standard Gaussian distribution 
n_d1=exp(-(d1^2)/2)/sqrt(2*pi);
Vega = Spot*exp(-q*T)*n_d1*sqrt(T);

end