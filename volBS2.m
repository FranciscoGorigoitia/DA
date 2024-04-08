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