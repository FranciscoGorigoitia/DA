# A closer look into Implied Volatility and Newton Raphson Algorithm 
> by Francisco Gorigoitía |
> MSc. Financial Engineering


In Black Scholes model, people may expect markets to quotes vanilla options for a set of standard maturities (_T_) and strike price (_K_) in currency units. Nevertheless, in the reality, the quotation system does not allow for a quick comparison of option prices across T and K. So, for that reason, in a way to make easier the comparison, fixed income markets does not express the price of pure discount bonds in currency terms, but instead it does in terms of rates. 



### Implied volatility
The implied volatility corresponds to estimation from the market respect to a future volatility of the price of an underlying asset as a constant value. It gives the market expectations about the magnitude of future price movements of the underlying asset. Also it can see like a mesure about the investors believes or sensations about the market risk.  

Quoting in implied volatility terms can give some advantages, such as comparability with assets with different strike price (K) and tenor (T), collection information from the market on its expectations, transparency and risk sensitive.  

Black Scholes formula implies a constant volatility, so, its implied volatility offers an easy comparison. Thus, the price is obtained by inserting the quoted volatility into the B-S formula at current market variables and contract properties. 

#### Smile
Implied volatility can be shown for each maturitie T as a function of the strike K through Bloomberg's OVDV screen. Its surface is named _Smile_ wich is in reality an entire surface. Smile provides the implied volatility for each set of strikes and maturities. However, it does not specify whether the Eupean option is a put or call.  
                   

### Newton Raphson Algorithm 

Newton Raphson is a powerful root finder (convergence rate, wich is higher when the function is linear). Generally, the convergence rate is quadratic, but it is not always guaranteed due to stationary points. For a typical range of volatility values in financial markets, the relationship is nearly linear.

At first the inference of the corresponding implied volatility $\sigma$ consist in finding the root of the equation, where the most popular algorithm.

$$ 
V^{\text{BS}}(\sigma^{\text{BS}} | K, T, S_0, r, q) = V_0^{\text{mkt}}
$$

Where for the sake of notational concison, it rewrites the previous equation as:

$$
f(x) = f*
$$ 

Considering f, x and f* as \((V_{\text{BS}}, \sigma^{\text{BS}})\) and \((V_{\text{mkt}})\) respectively. Thus, considering an initial guess X<sub>0</sub>, the Newton Raphson algorithm finds the value X<sub>1</sub> through a linear interpolation to the objective function f*

$$
f^* = f(X_0) + f'(X_0) \cdot (X_1 - X_0)
$$

                           

#### Implications
Unfortunately, Newton Raphson Algorithm is not guaranteed to converge in the general case: Stationary points, overshoots, or poor initial guesses may plague the algorithm. However, convergence is guaranteed when the function f is continuous, strictly monotonic, and convex (or concave).


