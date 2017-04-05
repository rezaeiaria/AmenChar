function [ave_rank, var_rank, ave_util, var_util] = stat_stabilityAll(Xs, part, feats, new_label, exp_num )

k_feats = numel(new_label);     % Total number of features
m_classes = numel(feats);       % Total number of classes

belong = zeros(k_feats,1);      % To what class a feature belongs
rank = cell(m_classes, 1);      % Rank{cls}(i,f) = rank for feature f on experiment i
util = cell(m_classes, 1);      % Utility for feature f on experiment i

% We initialized the BELONG and TOTES vectors to their values
for cls = 1:m_classes
    belong(part{cls}) = cls;
    util{cls} = zeros(exp_num, k_feats);
    rank{cls} = zeros(exp_num, k_feats);
end

count = 0;
for exp = 1:exp_num
    
    count = fprintf('Stability Experiment %d/%d\n', exp, exp_num);
    
    newXs = util_sample(Xs, 0.9);
    if (numel(newXs{1}) == 0 || numel(newXs{2}) == 0)
        continue;
    end
    [newPart, ~, ~] = main_partition(newXs, feats, new_label);
    [newUtil, ~, ~] = main_filterUtility(newXs, newPart, new_label, feats, .25);
    
    for cls = 1:m_classes
        
        
        P = newUtil{cls}(:,1);
        U = newUtil{cls}(:,2);
        R = 1:numel(P);
        R = 1 - (R / max(R));
                     
        for fIdx = 1:numel(P)
            % The current feature in the new partitioning
            f = P(fIdx);
            if (belong(f) == cls)   % If it originally belonged to this same class
                % We add one to the number of true tests for "f"
                rank{cls}(exp, f) = R(fIdx);
            end
            util{cls}(exp, f) = U(fIdx);
        end
        
    end
    
end

fprintf('\n');

for cls = 1:m_classes
    ave_rank{cls} = mean(rank{cls})';
    var_rank{cls} = var(rank{cls})';
    ave_rank{cls} = ave_rank{cls}(part{cls});
    var_rank{cls} = var_rank{cls}(part{cls});
    
    ave_util{cls} = mean(util{cls})';
    var_util{cls} = var(util{cls})';
    ave_util{cls} = ave_util{cls}(part{cls});
    var_util{cls} = var_util{cls}(part{cls});
end

end