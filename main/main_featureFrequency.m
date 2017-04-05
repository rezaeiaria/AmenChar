function [res] = main_featureFrequency(F, F_label, feats)

fid = [];
nodes = {};
for cls = 1:numel(feats)
    fid(cls) = util_findFeature(F_label, feats{cls});
    nodes{cls} = full(F(:,fid(cls)) > 0);
%     fprintf('Nodes for %d = %d\n', cls, sum(nodes{cls} > 0));
end
[F,F_label] = util_removeFeatures(F,F_label, feats);

clsSum = cell(numel(feats),1);
for cls = 1:numel(feats)
    clsSum{cls} = sum(F(nodes{cls},:));
end

for cls = 1:numel(feats)
    clsSum{cls} = clsSum{cls} - sum(F(nodes{3-cls},:));
    n_cls = sum(nodes{cls});
    clsSum{cls} = clsSum{cls} ./ repmat(n_cls, size(clsSum{cls}));
end

res = cell(numel(feats),1);
for cls = 1:numel(feats)
    
    positive_features = clsSum{cls} > 0;
    clsLbl = F_label(positive_features);
    clsSum{cls} = clsSum{cls}(positive_features);
    clsSum{cls} = full(clsSum{cls});
    
    res{cls} = cell(numel(clsLbl),2);
    for i=1:numel(clsLbl)
        res{cls}{i,1} = clsLbl{i};
        res{cls}{i,2} = clsSum{cls}(i);
    end
    
    res{cls} = sortrows(res{cls}, -2);
end

end