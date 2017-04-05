function [ A, F, A_label, F_label ] = util_filterNode( A, F, A_label, F_label, nodes )
% fprintf('hello?!');
% fprintf('We are going to remove %d nodes\n', nodes == 0);
A = A(nodes,nodes);
A_label = A_label(nodes);
F = F(nodes,:);

fsum = sum(F);
nzFeat = fsum > 0;
fprintf('Removed %d features also!\n', full(sum(~nzFeat)));
F = F(:,nzFeat);
F_label = F_label(nzFeat);

end

