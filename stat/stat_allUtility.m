function [res, sortedIdx] = stat_allUtility(Xs, part)

for cls=1:numel(part)
    for fidx=1:numel(part{cls})
        % We first find feature ID
        feat = part{cls}(fidx); 
        
        % Column 1 is feature ID
        res{cls}(fidx,1) = feat;
        % Column 2 is relative utility
        res{cls}(fidx,2) = stat_featRelUtil(Xs, cls, part, feat);
        % Column 3 is absolute utility
        res{cls}(fidx,3) = stat_featAbsUtil(Xs{cls}, part{cls}, feat);
        
    end
    
    res{cls} = sortrows(res{cls}, [-2 -3 1]);
    sortedIdx{cls} = res{cls}(:,1);
end

end