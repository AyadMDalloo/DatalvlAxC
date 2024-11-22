function [X_reduced,y_reduced] = reservoir_sampling(X,y, k)

k=fix(k*size(X,1));
    % Initialize the reservoir
    X_reduced = X(1:k, :);
    y_reduced = y(1:k, :); 
    % Iterate through the rest of the data
    for i = k+1:size(X, 1)
        j = randi(i); % Randomly select an index between 1 and i

        if j <= k 
             X_reduced(j, :) = X(i, :); % Replace an element in the reservoir
             y_reduced(j, :) = y(i, :);
        end
    end
end

