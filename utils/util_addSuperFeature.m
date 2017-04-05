function [F, F_label] = util_addSuperFeature(F, F_label, key, name)

feats = util_findByFeatureName(F_label, key);
new_f = util_superFeature(F, F_label, feats);
[F, F_label] = util_addFeature(F, F_label, new_f, name);

end