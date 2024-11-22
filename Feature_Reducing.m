function selected_features=Feature_Reducing(X,y, NoItr,thr)
% NoItr: number of iterations
% thr  : threshold of Selection
S=zeros(1,size(X,2));
for i=1:NoItr
    S_features=Feature_ReducingS(X,y)
    % length of selcted features
    L=length(S_features);
    %% count the number of the most repeated fetaure numbers in each iteration
    for j=1:L
        S(S_features(j))=S(S_features(j))+1;
    end
end
%% Select the most repeated feature numbers 
selected_features=find(S>thr);
end 