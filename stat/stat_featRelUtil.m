function res = stat_featRelUtil(Xs, cls, part, f)
% Xs = AMEN weights for all different classes
% cls = current class index
% part = the partition for this class
% f = current feature

res = inf;
curUtil = stat_featAbsUtil(Xs{cls}, part{cls}, f);

for i=1:numel(Xs)
    if (i == cls)
        continue;
    end
    otherUtil = stat_featAbsUtil(Xs{i}, part{i}, f);
    res = min(res, curUtil - otherUtil);
end

end