function [Xs, row] = main_filterNegativeScore(Xs, score)

row = {};
for cls = 1:numel(Xs)
    row{cls} = score{cls} > 0;
    Xs{cls} = Xs{cls}(row{cls},:);
end

end