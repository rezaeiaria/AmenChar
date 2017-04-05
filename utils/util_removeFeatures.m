function [F, F_label] = util_removeFeatures(F, F_label, feats)

featid = [];
for i=1:numel(feats)
    cur = util_findFeature(F_label, feats{i});
    if (cur ~= -1)
        featid(end+1) = cur;
    end
end

k_feats = numel(F_label);
remaining = setdiff(1:k_feats, featid);
F = F(:,remaining);
F_label = F_label(remaining);
end