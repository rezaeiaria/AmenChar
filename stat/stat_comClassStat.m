function [memberNum, outsiderNum] = stat_comClassStat(coms, F, F_label, feat)
allNodes = [];
for i=1:numel(coms)
    allNodes = union(allNodes, coms{i});
end

featid = util_findFeature(F_label, feat);
memberNum = sum(F(allNodes,featid) > 0);
outsiderNum = numel(allNodes) - memberNum;

end