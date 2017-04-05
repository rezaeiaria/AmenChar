function [ res ] = util_KronMat( F )
% Gets a vector of features
% Returns the pairwise Kronecker delta

n = numel(F);

% Make the vector vertical
if (size(F,1) == 1)
    F = F';
end

FverCat = repmat(F , 1, n);
FhorCat = repmat(F', n, 1);

res = FverCat == FhorCat;

end

