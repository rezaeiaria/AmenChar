function [F] = util_colNormalize(F)

s = sum(F);
F = F ./ repmat(s, size(F,1), 1);

end