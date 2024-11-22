function [OK]=uniformQuunatization_test(Xi,yi, Sel_Feat)
% check inputs
clc
 if nargin < 2  % Check if both arguments are provided
        error('arguments are required for this function.');
 end
if ~exist('Sel_Feat', 'var') || isempty(Sel_Feat) % % Check if the argument exists or is empty 
        Sel_Feat=size(Xi,2);
        Sel_Feat=1:Sel_Feat;
end
X=Xi(:,Sel_Feat);
Xn=Normalize_Standardize(X,'N');
X=Xn;
numLevels=[256 128 64 32 16 8 4];
L=length(numLevels);
% Set number of folds for k-fold cross-validation
k = 10;
% % Initialize arrays to store accuracy and confusion matrices
accuracyS = zeros(k, 1);
recallS=accuracyS;
precisionS=accuracyS;
f1_scoreS=accuracyS;
cmS = zeros(2, 2, k);
%
accuracyK = zeros(k, 1);
recallK=accuracyK;
precisionK=accuracyK;
f1_scoreK=accuracyK;
cmK = zeros(2, 2, k);
tElapsed1=zeros(1,k);
tElapsed2=zeros(1,k);
cv = cvpartition(length(yi), 'KFold', k);
y=yi;
[mr,nr]=size(X);
for j=1:L 
    Xq=zeros(size(X));
    for p=1:nr
    [Xq(:,p)]=uniformQuantization(X(:,p), numLevels(j));
    end
    
    Error=max(max(abs(X-Xq)));
    X= Xq;
cv = cvpartition(length(y), 'KFold', k);
 for i = 1:k
        
        % Get training and testing data for this fold
        X_train = X(training(cv, i), :);
        y_train = y(training(cv, i));
        X_test = X(test(cv, i), :);
        y_test = y(test(cv, i));
       [accuracyS(i), precisionS(i), recallS(i), f1_scoreS(i),cm1,tElapsed1(i)]=SVM_RUN(X_train,y_train, X_test,y_test);
        cmS(:,:,i)=cm1;
       [accuracyK(i), precisionK(i), recallK(i), f1_scoreK(i),cm2,tElapsed2(i)]=KNN_RUN(X_train,y_train,Xn,yi);
         assignin('base', 'cm2', cm2); 
        cmK(:,:,i)=cm2;
 end 
 % Average confusion matrices over all folds
    mean_cmS = mean(cmS, 3);
    % Compute average evaluation metrics across all folds
    avg_accuracy = mean(accuracyS)*100;
    avg_precision = mean(precisionS)*100;
    avg_recall = mean(recallS)*100;
    avg_f1_score = mean(f1_scoreS)*100;
    avg_tElapsed1=mean(tElapsed1);
    % Display results
    disp(['Error: ' num2str(Error)])
    disp(['numLevels: ' num2str(numLevels(j))])
    disp(['size of reduced X: ' num2str(mr) 'x' num2str(nr)])
    disp('---------------------------------------------')
    disp(['Delay SVM: ' num2str(avg_tElapsed1)])
    disp(['Mean accuracy: ' num2str(avg_accuracy)])
    disp(['Mean precision: ' num2str(avg_precision)])
    disp(['Mean recall: ' num2str(avg_recall)])
    disp(['Mean f1_score: ' num2str(avg_f1_score)])
    disp('Mean confusion matrix:')
    disp(mean_cmS)


  assignin('base', 'cmK', cmK); 
 mean_cmK = mean(cmK, 3);
    % Compute average evaluation metrics across all folds
    avg_accuracy = mean(accuracyK)*100;
    avg_precision = mean(precisionK)*100;
    avg_recall = mean(recallK)*100;
    avg_f1_score = mean(f1_scoreK)*100;
     avg_tElapsed2=mean(tElapsed2);
    % Display results
    disp(['Delay KNN: ' num2str(avg_tElapsed2)])
    disp(['Mean accuracy: ' num2str(avg_accuracy)])
    disp(['Mean precision: ' num2str(avg_precision)])
    disp(['Mean recall: ' num2str(avg_recall)])
    disp(['Mean f1_score: ' num2str(avg_f1_score)])
    disp('Mean confusion matrix:')
    disp(mean_cmK)
   
end
OK=1;
end