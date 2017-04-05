function [F, F_label] = util_removeFeatureById(F, F_label, idx)

F = F(:,~idx);
F_label = F_label(~idx);

end