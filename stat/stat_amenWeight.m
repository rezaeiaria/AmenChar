function res = stat_amenWeight(X, F_label)

sumx = sum(X);
for i=1:numel(sumx)
    res{i,1} = F_label{i};
    res{i,2} = sumx(i);
end

res = sortrows(res, -2);

end