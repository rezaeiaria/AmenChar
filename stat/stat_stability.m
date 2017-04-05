function stab = stat_stability(Xs, f, cls, feats, new_label)

n_coms = size(Xs{cls}, 1);
stabTrue = 0;
for i=1:n_coms
    newXs = Xs;
    newXs{cls} = newXs{cls}(setdiff(1:n_coms, i), :);
    % Find partition
    
    [part, ~, ~] = main_partition(newXs, feats, new_label);
    
    % if f \in part{cls} stabTrue += 1
    if any(part{cls} == f)
        stabTrue = stabTrue + 1;
    end
end

fprintf('Tested %s\n', new_label{f});

stab = stabTrue / n_coms;

end