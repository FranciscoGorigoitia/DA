# A brief look into Implied Volatility and Newton Raphson Algorithm 
> by Francisco Gorigoitía |
> MSc. Financial Engineering


In Black Scholes model, people may expect markets to quotes vanilla options for a set of standard maturities (_T_) and strike price (_K_) in currency units. Nevertheless, in the reality, the quotation system does not allow for a quick comparison of option prices across T and K. So, for that reason, in a way to make easier the comparison, fixed income markets does not express the price of pure discount bonds in currency terms, but instead it does in terms of rates. 



### Implied volatility
The implied volatility corresponds to an estimation from the market according to a future volatility of the price of an underlying asset as a constant value. It gives the market expectations about the magnitude of future price movements of the underlying asset. In addition, it can mesure the believes of investors and sensations about the market risk.  

Quoting in implied volatility terms can give some advantages, such as comparability with assets with different strike price (K) and tenor (T) and even a collection of information from the market on its expectations, transparency and risk sensitive.  

Black Scholes formula implies a constant volatility, which means that implied volatility offers an easy comparison. Thus, the price is obtained by inserting the quoted volatility into the B-S formula at current market variables and contract properties. 

#### Smile
Implied volatility can be shown for each maturitie T as a function of the strike K through Bloomberg's OVDV screen. Its surface is named _Smile_ which is in reality an entire surface. Smile provides the implied volatility for each set of strikes and maturities. However, it does not specify whether the Eupean option is a put or call.  
                   

### Newton Raphson Algorithm 

Newton Raphson is a powerful root finder (convergence rate, which is higher when the function is linear). Generally, the convergence rate is quadratic, but it is not always guaranteed due to stationary points. For a typical range of volatility values in financial markets, the relationship is nearly linear.

At first, the inference of the corresponding implied volatility $\sigma$ consist in finding the root of the equation, using Newton Raphson algorithm.

$$ 
V^{\text{BS}}(\sigma^{\text{BS}} | K, T, S_0, r, q) = V_0^{\text{mkt}}
$$

Where it rewrites the previous equation as:

$$
f(x) = f^*
$$ 

Considering _f_, _x_ and _f*_ as $V^{\text{BS}},\sigma^{\text{BS}}\$ and $V_{\text{mkt}}\$ respectively. Thus, considering an initial guess X<sub>0</sub>, the Newton Raphson algorithm finds the value X<sub>1</sub> through a linear interpolation to the objective function f*

$$
f^* = f(X_0) + f'(X_0) \cdot (X_1 - X_0)
$$

As a result, the next step X<sub>1</sub> is given by

$$
X_1 = X_0 + \frac{f^* - f(X_0)}{f^*(X_0)}
$$

So, the Newton Raphson algorithm evolves recursively from X<sub>n</sub> to X<sub>n+1</sub>

$$
X_{n+1} = X_n + \frac{f^* - f(X_n)}{f^*(X_n)}
$$

The algorithm stops when the desired accuracy is obtained on the variable _X_ or the objective value _f_. 
                           
#### Implications
Unfortunately, Newton Raphson Algorithm is not guaranteed to converge in the general case: Stationary points, overshoots, or poor initial guesses may plague the algorithm. However, convergence is guaranteed when the function f is continuous, strictly monotonic, and convex (or concave).


### Taking it to the code 

While traders typically express the worth of European options using implied volatility, various market models (such as local volatility, stochastic volatility, jump-diffusion, etc.) only provide the actual market value of these options. It's crucial to estimate the Black-Scholes implied volatility to assess the reasonableness of these numerical prices and compare them with observed market volatilities.

```matlab
function [C0,Vega] = valueBS(Spot,K,r,q,T,Sigma,e)
% Function with the necesary steps for to obtain European vanilla call value at time 0

d1 = (log(Spot/K)+(r-q)*T)/Sigma*sqrt(T)+Sigma*sqrt(T)/2;
d2 = d1-Sigma*sqrt(T);

C0 = e*Spot*exp(-q*T)*normcdf(e*d1)-e*K*exp(-r*T)*normcdf(e*d2);

% Now for to find Vega, its needed to find n(x), which is the density of the standard Gaussian distribution 
n_d1=exp(-(d1^2)/2)/sqrt(2*pi);
Vega = Spot*exp(-q*T)*n_d1*sqrt(T); 

end 
```
Where function _valueBS_ computs Black-Scholes formula for the price of a European vanilla call option and the corresponding Vega (V'<sub>BS</sub>). This last one corresponds to its derivative V<sub>BS</sub> with respect to its $\sigma$.

In reality the analyst does not care about how many iterations will need for to reach the implied volatility acording to modifications at guess initial $\sigma$, maturity or strike. To compute this, it was created a new function called _volBS2_ that implements the Newton-Raphson algorithm with a while loop that iterates until reach an accuracy of 1 bp. Typically, a small precision value is chosen to ensure that the obtained solution is as close as possible to the exact solution. This criterion is used to terminate the iterations of the algorithm once the desired precision is achieved. 

```matlab
function [C,vega,SigmaN] = volBS2(Spot,K,r,q,T,F,Sigma,e,accuracy)

C0=F;
SigmaN=Sigma;
SigmaN_1=0;
error=abs(SigmaN-SigmaN_1);
N=0;

while error>accuracy
  [C,vega]=valueBS(Spot,K,r,q,T,SigmaN,e);
  SigmaN_1=SigmaN;
  SigmaN=SigmaN+(C0-C)/vega;
  error=abs(SigmaN-SigmaN_1);
  N=N+1;

  if error<accuracy         % stop loop if error is higher than accuracy
      break
  end
end
end

```

### Some considerations about Newton Raphson algorithm
#### Advantages
1. Fast convergence: This algorithm can converge quickly to the desired solution, especially when started near it.
2. Efficiency: In many situations, the Newton-Raphson algorithm requires fewer iterations than other methods to achieve a desired accuracy.
3. Wide applicability: It can be applied to a wide variety of problems, including those arising in the Black-Scholes formula.

#### Inconvenients
1. Sensitivity to choice of initial point: The algorithm may fail to converge or converge to an incorrect solution if an inappropriate initial point is chosen.
2. Requires derivatives: The Newton-Raphson algorithm requires the calculation of derivatives, which can be computationally expensive or difficult in some cases.
3. No convergence guarantee: As previously explained, even though the algorithm tends to converge rapidly in many situations, there is no guarantee that it will converge in the general case: Stationary points, overshoots, or poor initial guesses may plague the algorithm. However, convergence is guaranteed when the function f is continuous, strictly monotonic, and convex (or concave).








