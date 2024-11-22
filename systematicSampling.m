function [X_sampled, y_sampled]= systematicSampling(X,y, thr)
    % systematicSampling performs systematic sampling on the input dataset.
    %
    % Inputs:
    %   data - Array containing the dataset
    %   sampleSize - Desired number of samples
    %
    % Output:
    %   sampledData - Array containing the systematic sample
   % Determine the population size
  
    population_Size = size(X,1); 
sample_size=fix(population_Size*thr);
      % Calculate the sampling interval
    sampling_interval = floor(population_Size / sample_size);

% Random starting point within the first interval
start_index = randi(sampling_interval);

% Select samples systematically
selected_indices = start_index:sampling_interval:population_Size;
X_sampled = X(selected_indices, :);
y_sampled = y(selected_indices, :);
end

