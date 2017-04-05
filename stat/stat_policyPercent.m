function prcnt = stat_policyPercent(utils, util_labels, feats, party)

years = 1994:2:2008;
lbl = {};
for year=1994:2:2008
    lbl{end+1} = [num2str(year-1) '-' num2str(year+1)];
end

prcnt = zeros(numel(utils), numel(feats));

for polId =1:numel(feats)
    for cng=1:numel(utils)
        idx = util_findFeature(util_labels{cng}{party}, feats{polId});
        fprintf('Feature %s is %d on congress %d.\n', feats{polId}, ...
            idx, cong);
        y = utils{cng}{party}(:,2);
        y = y / max(y) * 100;

        if (idx == -1)
            prcnt(cng, polId) = 0;
        else
            prcnt(cng, polId) = max(0,y(idx));
        end
    end
end

end