function [accuracy, precision, recall, f1_score,cmk,tElapsed]=KNN_RUN(X_train,y_train,X_test,y_test)
% Using the custom KNN_Classify function (let's try k = 3)
k = 3; 
% cmk=zeros(2,2);
% % Make predictions on the test set
% y_pred = zeros(size(y_test, 1), 1);
tStart = tic;
model = fitcknn(X_train, y_train, 'NumNeighbors', k); 
 assignin('base', 'model', model)
y_pred = predict(model, X_test);
tElapsed = toc(tStart);
% for i = 1:size(X_test, 1)
%     y_pred(i) = fitcknn(X_train,y_train, X_test(i,:), k);
% %     pause
%     
% end
% accuracy=sum(predictions == grp2idx(y_test))/ length(y_test);
% disp(accuracy*100)
% Calculate  confusion matrix for this fold
    % assignin('base', 'y_pred', y_pred); 
    cmk= confusionmat(y_test, y_pred);
%      assignin('base', 'cmt', cmt); 
%     cmk=cmt;
    % Compute evaluation metrics
    [accuracy, precision, recall, f1_score] = binary_classification_metrics(cmk);
end
