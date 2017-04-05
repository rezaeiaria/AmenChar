function [C, F, F_label] = util_class(F, F_label, feats)
% If feats are not super features, class_names = feats

C = zeros(size(F,1), numel(feats));
m_classes = numel(feats);

to_remove = false(numel(F_label),1);
for cls = 1:m_classes
    if (ischar(feats{cls}))
        feat_idx = util_findFeature(F_label, feats{cls});
        to_remove(feat_idx) = true;
        C(:,cls) = F(:,feat_idx);
    else
        rel_idx = false(numel(F_label),1);
        for f_idx = 1:numel(feats{cls})
            cur_f = feats{cls}{f_idx};
            [~,cur_idx] = util_findByFeatureName(F_label, cur_f);
            rel_idx = rel_idx | cur_idx;
        end
        C(:,cls) = util_superFeature(F, rel_idx);
        to_remove = to_remove | rel_idx;
    end
end

[F,F_label] = util_removeFeatureById(F, F_label, to_remove);

end