function [F, F_label] = util_addFeature(F, F_label, cur, label)

F = [F cur];
F_label = [F_label; label];

end