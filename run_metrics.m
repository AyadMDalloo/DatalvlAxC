    tp =65;
    fp =2;
    fn = 1;
    tn = 46;
    T=1;
    % Compute evaluation metrics
    accuracy = (tp + tn) / (tp + fp + fn + tn)*100
    precision = tp / (tp + fp); precision=[precision(~isnan(precision)),T(isnan(precision))]*100
    recall = tp / (tp + fn);recall=[recall(~isnan(recall)),T(isnan(recall))]*100
    f1_score = 2 * precision * recall / (precision + recall);f1_score=[f1_score(~isnan(f1_score)),T(isnan(f1_score))]