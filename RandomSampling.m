function [reduced_X , reduced_y]=RandomSampling(X,y,Sel_Feat,Pre_Reduce)

% Simple Random Sampling (Reduce dataset size by Pre_Reduce%)
numReducedSamples = round(size(X, 1) * Pre_Reduce); 

randomIndices = randperm(size(X, 1), numReducedSamples);

% assignin('base', 'randomIndices', randomIndices); 
reduced_X = X(randomIndices', Sel_Feat); % Keep only selected features
reduced_y = y(randomIndices');
