function [prcntl, ave_prcntl] = stat_policyNormRank(amen_res, feats, party)

% years = 1994:2:2008;
% lbl = {};
% for year=1994:2:2008
%     lbl{end+1} = [num2str(year-1) '-' num2str(year+1)];
% end

prcntl = zeros(numel(amen_res), numel(feats));

for polId =1:numel(feats)
    for cng=1:numel(amen_res)
        labels = amen_res{cng}{party}(:,1);
        idx = util_findFeature(labels, feats{polId});

        if (idx == -1)
            prcntl(cng, polId) = 0;
        else
            y = amen_res{cng}{party}{idx,2};
            prcntl(cng, polId) = y;
        end
    end
end

ave_prcntl = mean(prcntl);

end