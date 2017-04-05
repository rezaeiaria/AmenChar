function [F,F_label] = util_filterComFeatures(coms, F, F_label)

k_feats = size(F,2);
m_classes = numel(coms);

used_features = zeros(1, k_feats);

for cls = 1:m_classes
    for i=1:numel(coms{cls})
        F_com = sum(F(coms{cls}{i},:)) >= 1;
        used_features = used_features | F_com;
    end
end

F = F(:,used_features);
F_label = F_label(used_features);

end