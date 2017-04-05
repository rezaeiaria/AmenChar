function [res, idx] = util_findByExactFeatureName(F_label, str)

res = {};
idx = false(numel(F_label),1);
for i=1:numel(F_label)
    if (strcmpi(F_label{i}, str) ~= 0)
        res = [res; F_label{i}];
        idx(i) = numel(strfind(lower(F_label{i}), lower(str))) ~= 0;
    end
end

end