function y=DP(x)
%-------------------Description-----------------------------------------
% This function calculate the K^2 statistic that detect deviation from
% normality due to either skewness or kurtosis based on D'Agostino's K-squared test
% Reference for Eqs. is Wikipedia 
% https://en.wikipedia.org/wiki/D%27Agostino%27s_K-squared_test
% K^2=DP(x)
% where x is a time series or imf obtained from EMD (Emprical Mode Decomposition)
% Vahid Dabbagh, Oct. 2016, Email: dabbaghvahid@gmail.com
n=length(x);
mu=mean(x);
g1=mean((x-mu).^3)/mean((x-mu).^2)^1.5;
g2=mean((x-mu).^4)/mean((x-mu).^2)^2-3;
gamma2=36*(n-7)*(n^2+2*n-5)/(n-2)/(n+5)/(n+7)/(n+9);
W=sqrt(-1+sqrt(2*gamma2+4));
delta=1/sqrt(log(W));
alpha=sqrt(2/(W^2-1));
mu2=6*(n-2)/(n+1)/(n+3);
Z1g1=delta*log(g1/alpha/sqrt(mu2)+sqrt(g1^2/alpha^2/mu2+1));
mu1=-6/(n+1);
mu2=24*n*(n-2)*(n-3)/(n+1)^2/(n+3)/(n+5);
gamma1=6*(n^2-5*n+2)/(n+7)/(n+9)*sqrt(6*(n+3)*(n+5)/n/(n-2)/(n-3));
A=6+8/gamma1*(2/gamma1+sqrt(1+4/gamma1^2));
Z2g2=sqrt(4.5*A)*(1-1/4.5/A-((1-2/A)/(1+(g2-mu1)/sqrt(mu2)*sqrt(2/(A-4))))^(1/3));
y=Z1g1^2+Z2g2^2;
end