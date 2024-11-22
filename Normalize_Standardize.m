function [X_NoS]=Normalize_Standardize(X,NoS)
%% Normalization and standardization 
% X= input
% NoS= 'N' or 'S' or 'O' Select Type : N=Normalization,S= Standardization,
% O=Our technique for Normalization

%% Normalization
% Goal: Scales features to a standard range, often between 0 and 1.
% Suitable for: Algorithms that don't assume a Gaussian distribution, or when you want your features to have a comparable scale.
% Common methods: Min-Max Scaling.
% Min-Max Scaling
 X_normalized = (X - min(X, [], 1)) ./ (max(X, [], 1) - min(X, [], 1));
 
%%  Standardization
% Goal: Transforms features to have zero mean and unit variance.
% Suitable for: Algorithms that benefit from features following a standard normal distribution (e.g., linear regression, logistic regression, many neural networks).
% Common methods: Z-score normalization.
% Z-score Normalization
    X_standardized = (X - mean(X, 1)) ./ std(X, 1);
    
%% Our technique for Normalization
 X_OurNormlize=X./max(X);
 
 if NoS=='N'
    X_NoS= X_normalized;
 elseif NoS=='S'
    X_NoS=X_standardized;
 elseif NoS=='O'
    X_NoS=X_OurNormlize;
 else
    
     X_NoS=X;
 end

end

     