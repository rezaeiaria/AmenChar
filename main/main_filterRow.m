function [Xs, row] = main_filterRow(Xs)

row = {};
for cls = 1:numel(Xs)
    sx = sum(Xs{cls}, 2);
    row{cls} = sx ~= 0;
    Xs{cls} = Xs{cls}(row{cls},:);
end

end