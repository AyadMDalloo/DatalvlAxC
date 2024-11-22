function [xq]=Qunatize_u_Law(x,numLevels)
% Define the companding function (e.g., ?-law)
mu = 255;
x_companded = sign(x) .* log(1 + mu * abs(x)) / log(1 + mu);

% Perform uniform quantization on the companded signal
stepSize = 2 / numLevels;
xq_companded = round((x_companded + 1) / stepSize) * stepSize - 1;

% Inverse companding
xq = sign(xq_companded) .*(1 / mu) .*((1+ mu).^(abs(xq_companded))-1);
end
