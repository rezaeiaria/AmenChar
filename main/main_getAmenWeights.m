function [Xs, F_label] = main_getAmenWeights(A, F, F_label, feats, coms)

m_classes = numel(feats);

[F, F_label] = util_removeFeatures(F, F_label, feats);
Xs = {};
comScores = {};
for cls=1:numel(feats)
    % Finding AMEN weights for each of the features
    [~, comScores{cls}, Xs{cls}] = amen_circle_rank(A, F, coms{cls}, 'norm', 'L2');
    Xs{cls}(Xs{cls}<0) = 0;
    Xs{cls}(isnan(Xs{cls})) = 0;
    comScores{cls}(isnan(comScores{cls})) = 0;
end

[Xs, ~] = main_filterNegativeScore(Xs, comScores);

[Xs, col] = main_filterZeroRowCol(Xs);
F_label = F_label(col);

end