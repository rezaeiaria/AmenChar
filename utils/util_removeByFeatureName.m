function [F,F_label] = util_removeByFeatureName(F, F_label, str)

ind = ones(numel(F_label),1);
for i=1:numel(F_label)
    if (numel(findstr(lower(F_label{i}), lower(str))) ~= 0)
        ind(i) = 0;
    end
end

ind = logical(ind);
F = F(:,ind);
F_label = F_label(ind);

end