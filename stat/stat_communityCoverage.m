function rel_cov = stat_communityCoverage(coms, f, alpha)

rel_cov = 0;
for i=1:numel(coms)
    fraction = sum(f(coms{i})) / numel(coms{i});
    if (fraction > alpha)
        rel_cov = rel_cov + 1;
    end
end

rel_cov = rel_cov / numel(coms);

end