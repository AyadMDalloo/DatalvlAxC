function [ accuracy, precision, recall, f1_score, cmts,tElapsed ,Noitr,NoSVs]=SVM_RUN(X_train,y_train,X_test,y_test, itrN)
if ~exist('itrN', 'var') || isempty(itrN) % % Check if the argument exists or is empty 
        itrN=1e6;
end
 C = 1;
  % kernel = 'rbf';
  kernel ='linear';
L=size(X_train,2);

% Train SVM on training data
tStart = tic;
    svm_model = fitcsvm(X_train, y_train, 'KernelFunction', kernel,  'KernelScale','auto','BoxConstraint', C, 'IterationLimit',itrN);
    
    assignin('base', 'svm_model', svm_model)
    % Predict labels for test data
    % y_predtr = predict(svm_model, X_train);
    y_predts = predict(svm_model, X_test);
tElapsed = toc(tStart); 
Noitr=svm_model.NumIterations; 
NoSVs=length(svm_model.Alpha);
    % Calculate confusion matrix for this fold
%     assignin('base', 'y_pred', y_pred);
     % cmtr= confusionmat(y_train, y_predtr);
     cmts= confusionmat(y_test, y_predts);
%       assignin('base', 'cm', cm); 
    % Compute evaluation metrics
    [accuracy, precision, recall, f1_score] = binary_classification_metrics(cmts);
    % [accuracytr,~, ~, ~] = binary_classification_metrics(cmtr);
end