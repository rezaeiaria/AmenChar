function util_saveGephi( A, A_label, P, outpath )

[r,c,v] = find(A);
edges = [r,c,v];

ID = (1:size(A,1))';
Label = A_label;
Party = P;
nodeTable = table(ID, Label, Party);

Source = edges(:,1);
Target = edges(:,2);
Weight = edges(:,3);
Type = repmat('Undirected', size(edges,1), 1);

edgeTable = table(Source, Target, Weight, Type);

writetable(nodeTable, [outpath '_node.csv']);
writetable(edgeTable, [outpath '_edge.csv']);

end

