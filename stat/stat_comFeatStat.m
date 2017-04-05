function stats = stat_comFeatStat(good_coms, nodes, F, F_label, label, alpha)

m_classes = numel(nodes);
if (numel(good_coms) ~= 0)
    k_coms = [numel(good_coms{1}); numel(good_coms{2})];
else
    k_coms = [0 0];
end
n_nodes = [numel(nodes{1}); numel(nodes{2})];

% Members = union of all nodes existing in communitites
members = {[]; []};
for cls = 1:m_classes
    for i=1:k_coms(cls)
        members{cls} = union(members{cls}, good_coms{cls}{i});
    end
    fprintf('There are %d nodes.\nThere are %d community members.\n\n', ...
        numel(nodes{cls}), numel(members{cls}));
end
n_members = [numel(members{1}); numel(members{2})];


stats = cell(2,1);
for cls=1:m_classes
    other = 3 - cls;
    pure_nodes = setdiff(nodes{cls}, nodes{other});
    pure_other = setdiff(nodes{other}, nodes{cls});
    all_nodes = union(nodes{cls}, nodes{other});
    for i=1:numel(label{cls})
        idx = util_findFeature(F_label, label{cls}{i});
        
        if ( idx == -1)
            fprintf('Lbl{%d}(%d) = %s not found\n', cls, i, label{cls}{i});
            return;
        end

        % Relative node coverage
        rel_node_cov = sum(F(nodes{cls},idx))/n_nodes(cls) - ...
            sum(F(nodes{other},idx))/n_nodes(other);
        
        % Relative community coverage
        if (k_coms(cls) > 0)
            rel_com_cov =  sum(F(members{cls},idx))/n_members(cls) - ...
            sum(F(members{other},idx))/n_members(other);
        else
            rel_com_cov = 0;
        end
        
        % Relative node discrimination
        rel_node_dis = sum(F(pure_nodes,idx))/sum(F(:,idx)) - ...
            sum(F(pure_other,idx))/sum(F(:, idx));
        if (isnan(rel_node_dis))
            rel_node_dis = 0;
        end
        
        stats{cls}{i,1} = label{cls}{i};
        stats{cls}{i,2} = rel_node_cov;
        stats{cls}{i,3} = rel_com_cov;
        stats{cls}{i,4} = rel_node_dis;
        
    end
end

end