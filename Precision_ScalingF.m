function X_PreScaling = Precision_ScalingF(Xi, num_bits,num_ints)
[X]=Normalize_Standardize(Xi,'N');
[m,n]=size(X);
X_PreScaling=zeros(m,n);
for i=1:n
    for j=1:m
[~,~,~,~,~,baf_2Comp]=frac2bin(X(j,i), num_bits,num_ints);
 X_PreScaling(j,i)=bin2frac(baf_2Comp, num_bits,num_ints);
    end 
end

end