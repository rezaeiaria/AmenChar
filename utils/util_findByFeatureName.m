function [res, idx] = util_findByFeatureName(F_label, str)

res = {};
idx = false(numel(F_label),1);
for i=1:numel(F_label)
    if (numel(strfind(lower(F_label{i}), lower(str))) ~= 0)
        res = [res; F_label{i}];
        idx(i) = numel(strfind(lower(F_label{i}), lower(str))) ~= 0;
    end
end

end