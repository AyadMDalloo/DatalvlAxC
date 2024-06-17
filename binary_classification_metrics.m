function [accuracy, precision, recall, f1_score] = binary_classification_metrics(y_true, y_pred,cm)
% Define function to compute binary classification metrics
    % Compute confusion matrix
   
    
    % Extract true positive, false positive, false negative, and true negative counts
    tp = cm(1, 1);
    fp = cm(2, 1);
    fn = cm(1, 2);
    tn = cm(2, 2);
    T=1;
    % Compute evaluation metrics
    accuracy = (tp + tn) / (tp + fp + fn + tn);
    precision = tp / (tp + fp); precision=[precision(~isnan(precision)),T(isnan(precision))];
    recall = tp / (tp + fn);recall=[recall(~isnan(recall)),T(isnan(recall))];
    f1_score = 2 * precision * recall / (precision + recall);f1_score=[f1_score(~isnan(f1_score)),T(isnan(f1_score))];
end
