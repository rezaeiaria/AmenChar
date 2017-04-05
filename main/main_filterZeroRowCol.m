function [Xs, col] = main_filterZeroRowCol(Xs)

k_feats = size(Xs{1},2);
m_targets = numel(Xs);

zeroFeat = zeros(1,k_feats);
for cls=1:m_targets
    sumX = sum(Xs{cls});
    if (cls == 1)
        zeroFeat = sumX == 0;
    else
        zeroFeat = zeroFeat & (sumX == 0);
    end
end
col = ~zeroFeat;

% Removing zero features
for cls=1:m_targets
    Xs{cls} = Xs{cls}(:,col);
end
end