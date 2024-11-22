function [reduced_X,reduced_y]=Stratified_Sampling(X,y,Sel_Feat,Pre_Reduce)
selected_features=Sel_Feat;
% Get unique class labels and their counts
[unique_labels, ~, label_indices] = unique(y);
class_counts = histcounts(label_indices);

% Determine number of samples to select from each class
desired_reduction_rate = Pre_Reduce; % Example: reduce by 50%
num_samples_per_class = round(class_counts * desired_reduction_rate);
 assignin('base', 'num_samples_per_class', num_samples_per_class); 
% Initialize reduced dataset storage
reduced_X = zeros(sum(num_samples_per_class), length(selected_features));
reduced_y = zeros(sum(num_samples_per_class), 1);

% Sampling loop (keeping track of index for reduced data)
reduced_data_idx = 1;
for label = unique_labels'
    class_data_indices = find(y == label); 
    
    % Randomly select indices within this class
    selected_indices = randsample(class_data_indices, num_samples_per_class(label));

    % Add to reduced dataset
    reduced_X(reduced_data_idx : reduced_data_idx + num_samples_per_class(label) - 1, :) = ...
        X(selected_indices, selected_features);
    reduced_y(reduced_data_idx : reduced_data_idx + num_samples_per_class(label) - 1) = ...
        y(selected_indices);

    reduced_data_idx = reduced_data_idx + num_samples_per_class(label);
end

% Proceed with modeling using 'reduced_X' and 'reduced_y'
