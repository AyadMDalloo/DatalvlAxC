function S_features=Feature_ReducingS(X,y)
%% Normalization and standardization 
% are two essential techniques used in  data preprocessing in machine 
% learning and data science. Both techniques are used to transform data 
% into a common scale to make it easier to process and analyze
[X]=Normalize_Standardize(X,'N');
%%
all_data = [X y]; % Combine features and labels
% Split Data
cv = cvpartition(y,'Holdout',0.3); 
X_train = X(training(cv),:);
y_train = y(training(cv));
X_test = X(test(cv),:);
y_test = y(test(cv));

% Decision Tree for Feature Selection
dt = fitctree(X_train, y_train); 
imp = predictorImportance(dt); % Feature importances

 assignin('base','imp',imp)

[~, sorted_indices] = sort(imp, 'descend');
S_features=[sorted_indices(1)];
assignin('base','sorted_indices',sorted_indices)
%selected_features=sorted_indices(end-1:end); %%% default two features
fprintf('Feature Importance Scores:\n');
% for f = 1:size(X, 2)
%     fprintf('%d. feature %s (%f)\n', f, dt.PredictorNames{sorted_indices(f)}, imp(sorted_indices(f)));
%    
% end
d = linspace(0.01,1, size(imp,2));
for f = 2:size(imp, 2)
 if imp(sorted_indices(f)) > (imp(sorted_indices(f-1))*d(f-1))
     S_features=[ S_features sorted_indices(f)];
 end
end
