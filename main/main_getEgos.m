function [coms, seeds] = main_getEgos(A, F, F_label, feats)

coms = cell(numel(feats),1);
seeds = util_findMembers(F, F_label, feats);

seeds

for cls = 1:numel(feats)
    for i=1:numel(seeds{cls})
        coms{cls}{end+1} = find(A(seeds{cls}(i),:));
    end
end

end