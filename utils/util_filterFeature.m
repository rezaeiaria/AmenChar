function [ A, F, A_label, F_label ] = util_filterFeature( A, F, A_label, F_label, feats )

F = F(:,feats);
F_label = F_label(feats);

end

