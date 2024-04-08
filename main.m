%% I'm calculating the Implied Volatility through Newton Raphson Algorithm. This last one its purpose is to find the implied volatility of option's values.
clc 
% Considering an accuracy of 1 bp and different variables for
% Spot,K,r,q,T,F,Sigma and e. 

[C_P2,Vega_P2,Sigma_P2]=volBS2(679,700,0.04,0.01,1,98.53,0.1,1,0.0001);
disp(C_P2)
disp(Vega_P2)
disp(Sigma_P2)

%replicandolo para la pregunta 3
[C_P3,Vega_P3,Sigma_P3]=volBS2(679,700,0.04,0.01,1,98.53,1,1,0.0001);
disp(C_P3)
disp(Vega_P3)
disp(Sigma_P3)

%replicandolo para la pregunta 4
[C_P4,Vega_P4,Sigma_P4]=volBS2(679,760,0.04,0.01,0.083,98.53,1,1,0.0001);
disp(C_P4)
disp(Vega_P4)
disp(Sigma_P4)
