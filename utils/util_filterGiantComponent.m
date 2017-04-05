function [ A, F, A_label, F_label ] = util_filterGiantComponent( A, F, A_label, F_label, graph_name )


fprintf('Saving .edge file for it ...');
io_save_graph_cpp(A, ['cpp\graph\' graph_name '.edge']);
fprintf('[DONE]\n');

fprintf('Finding the biggest component ...');
system(['cpp\gc.exe cpp\graph\' graph_name '.edge cpp\gc\' graph_name '.gc 1>NUL 2>NUL']);
fprintf('[DONE]\n');

fprintf('BEFORE: nodes: %d\tfeatures: %d\n', size(A,1), size(F,2));
gcnodes = dlmread(['cpp\gc\' graph_name '.gc']);

% Filtering nodes
A = A(gcnodes,gcnodes);
A_label = A_label(gcnodes);
F = F(gcnodes,:);

% Filtering empty features out
sumf = sum(F);
goodFeats = (sumf > 0);
F = F(:,goodFeats);
F_label = F_label(goodFeats);
fprintf('AFTER: nodes: %d\tfeatures: %d\n', size(A,1), size(F,2));


end

