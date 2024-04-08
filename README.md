# A closer look into Implied Volatility and Newton Raphson Algorithm 
> by Francisco Gorigoitía R.


### Implied volatility
The implied volatility corresponds to estimation from the market respect to a future volatility of the price of an underlying asset as a constant value. It gives the market expectations about the magnitude of future price movements of the underlying asset. Also it can see like a mesure about the investors believes or sensations about the market risk.  

Quoting in implied volatility terms can give some advantages, such as comparability with assets with different strike price (K) and tenor (T), collection information from the market on its expectations, transparency and risk sensitive. 

                   

### Newton Raphson Algorithm 
It is a powerful root finder (convergence rate, wich is higher when the function is linear). Generally, the convergence rate is quadratic, but it is not always guaranteed due to stationary points. 

For a typical range of volatility values in financial markets, the relationship is nearly linear. Thus, considering an initial guess X<sub>0</sub>, the Newton Raphson algorithm finds the value X<sub>1</sub> through a linear interpolation to the objective function f* (being the same as V<sub>mkt</sub>) as the solution of: 

$$
f^* = f(X_0) + f'(X_0) \cdot (X_1 - X_0)
$$
                                 

#### Implications
Unfortunately, Newton Raphson Algorithm is not guaranteed to converge in the general case: Stationary points, overshoots, or poor initial guesses may plague the algorithm. However, convergence is guaranteed when the function f is continuous, strictly monotonic, and convex (or concave).


