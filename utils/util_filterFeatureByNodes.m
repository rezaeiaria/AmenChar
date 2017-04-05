function [F, F_label] = util_filterFeatureByNodes(F, F_label, nodes)

F = F(nodes, :);
nz = sum(F, 1) > 0;
F = F(:, nz);
F_label = F_label(nz);
fprintf('Removed %d features.\n', full(sum(~nz)));

end