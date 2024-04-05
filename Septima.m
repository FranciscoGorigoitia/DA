clear
%TAREA 7

%% Question 1
Spot=679;
r=0.04;
q=0.01;
T=0.833;
K=580;
Sigma=0.1;
e=1;
[C0,Vega]=valueBS(Spot,K,r,q,T,Sigma,e);
disp(C0)
disp(Vega)

%% Question 2
clc
Spot=679;
r=0.04;
q=0.01;
T=1;
K=700;
F=98.53;
Sigma0=0.1;
e=1;
%Inciso A
[C_0,Vega_0]=valueBS(Spot,K,r,q,T,Sigma0,e); 

%Inciso B, C
Sigma_1=Sigma0+((F-C_0)/Vega_0);
[C_1,Vega_1]=valueBS(Spot,K,r,q,T,Sigma_1,e);
disp(C_1)
disp(Vega_1)

%Inciso D - Repitiendo lo mismo hasta obtener valor 1bp
Sigma_2=Sigma_1+((F-C_1)/Vega_1);
[C_2,Vega_2]=valueBS(Spot,K,r,q,T,Sigma_2,e);
disp(C_2)
disp(Vega_2)

Sigma_3=Sigma_2+((F-C_2)/Vega_2);
[C_3,Vega_3]=valueBS(Spot,K,r,q,T,Sigma_3,e);
disp(C_3)
disp(Vega_3)

Sigma_4=Sigma_3+((F-C_3)/Vega_3);
[C_4,Vega_4]=valueBS(Spot,K,r,q,T,Sigma_4,e);
disp(C_4)
disp(Vega_4)

%% Question 3
clc
Spot=679;
r=0.04;
q=0.01;
T=1;
K=700;
F=98.53;
Sigma0=1;
e=1;

%Realizando exatamente lo mismo que en el inciso anterior pero para este
%caso un Sigma=1
[C0,Vega0]=valueBS(Spot,K,r,q,T,Sigma0,e); 
Sigma1=Sigma0+((F-C0)/Vega0);
[C1,Vega1]=valueBS(Spot,K,r,q,T,Sigma1,e);
disp(C1)
disp(Vega1)

Sigma2=Sigma1+((F-C1)/Vega1);
[C2,Vega2]=valueBS(Spot,K,r,q,T,Sigma2,e);
disp(C2)
disp(Vega2)

Sigma3=Sigma2+((F-C2)/Vega2);
[C3,Vega3]=valueBS(Spot,K,r,q,T,Sigma3,e);
disp(C3)
disp(Vega3)

Sigma4=Sigma3+((F-C3)/Vega3);
[C4,Vega4]=valueBS(Spot,K,r,q,T,Sigma4,e);
disp(C4)
disp(Vega4)

% A la cuarta iteración alcanza un valor constante

%% Question 4
%Haciendo la pregunta 3 nuevamente pero con nuevos datos:
clc
Spot=679;
r=0.04;
q=0.01;
T=0.083;
K=760;
F=9.64;
Sigma0=1;
e=1;

N = 5; % Número de repeticiones

[c, vega, sigma] = deal(zeros(N+1, 1)); % Preasignar matrices para almacenar resultados
sigma(1) = Sigma0; % Valor inicial de sigma

for i = 1:N
    [c(i), vega(i)] = valueBS(Spot, K, r, q, T, sigma(i), e);
    sigma(i+1) = sigma(i) + ((F - c(i)) / vega(i));
    
    disp(['Iteración ', num2str(i), ':']);
    disp(['c = ', num2str(c(i))]);
    disp(['vega = ', num2str(vega(i))]);
end

[c(N+1), vega(N+1)] = valueBS(Spot, K, r, q, T, sigma(N+1), e);
disp(['Iteración ', num2str(N+1), ':']);
disp(['c = ', num2str(c(N+1))]);
disp(['vega = ', num2str(vega(N+1))]);


%% Question 5
clc
% utilizando los valores para compararlo con la pregunta 2
[Sigma_p2,C_p2,Vega_p2]=volBS1(679,700,0.04,0.01,1,98.53,0.1,1,3);
disp(C_p2)
disp(Vega_p2)
disp(Sigma_p2)

%comparando con la pregunta 3
[Sigma_p3,C_p3,Vega_p3]=volBS1(679,700,0.04,0.01,1,98.53,1,1,4);
disp(C_p3)
disp(Vega_p3)
disp(Sigma_p3)

%comparando con la pregunta 4
[Sigma_p4,C_p4,Vega_p4]=volBS1(679,760,0.04,0.01,0.083,9.64,1,1,5);
disp(C_p4)
disp(Vega_p4)
disp(Sigma_p4)

%% Question 6
clc 
%Se procede a computar la fórmula creada para ver si arroja los mismos resultados que antes, se considerara un accuracy de
%0.0001

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
[C_P4,Vega_P4,Sigma_P4]=volBS2(679,760,0.04,0.01,0.083,9.64,1,1,0.0001);
disp(C_P4)
disp(Vega_P4)
disp(Sigma_P4)



%% Question 7
tenor=xlsread('Data Extraction of implied volatility with Newton-Raphson.xlsx','A6:A17');
K=xlsread('Data Extraction of implied volatility with Newton-Raphson.xlsx','B6:F17');
C=xlsread('Data Extraction of implied volatility with Newton-Raphson.xlsx','B20:F31');
%En donde las matrices se procederán a completar
volatilidad=zeros;

for i=1:12
    for j=1:5
        Tenor=tenor(i,1);
        MkValue=C(i,j);
        Strike=K(i,j);
        r=0.04;
        q=0.01;
        Spot=679;
        Sigma=0.1;
        Accuracy=0.0001;
        e=1;
        [~,~,volatility]=volBS2(Spot,Strike,r,q,Tenor,MkValue,Sigma,e,Accuracy);
        %solo me interesa el cálculo de SigmaN o volatilidad, no los otros.
        volatilidad(i,j)=volatility;
    end
end

surf(K,tenor,volatilidad)
xlabel('K')
ylabel('Tenor')
zlabel('Volatilidad')
title('Volatilidad de Black-Scholes para todo K y Tenors')

