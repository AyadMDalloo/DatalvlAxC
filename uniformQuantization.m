function [xq]=uniformQuantization(x,numLevels) 
% Compute the step size
stepSize = 2 / numLevels;
[m, n]=size(x);
% Compute the start and end values of X
strlvl=min(x);
endlvl=max(x);
% Perform quantization
qLevels = strlvl + stepSize/2 : stepSize : endlvl - stepSize/2;  % Quantization levels
cqLevels= strlvl: stepSize : endlvl ;
% xq = round((x + 1) / stepSize) * stepSize - 1;  % Quantized signal
% OR
index=quantiz(x,qLevels);
xq=cqLevels(index+1);

