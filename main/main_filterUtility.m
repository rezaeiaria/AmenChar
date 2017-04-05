function [util, util_label] = main_filterUtility(Xs, part, F_label)

m_classes = numel(Xs);

util = cell(m_classes,1);
util_label = cell(m_classes,1);
for cls=1:m_classes
    
    n_select = numel(part{cls});    % Number of selected attributes
    util{cls} = zeros(n_select, 3);
    n_coms = size(Xs{cls},1);       % number of subgraphs in this class
    n_other = size(Xs{3-cls},1);    % number of subgraphs in the other class
    for f=1:n_select
        % We store the attribute ID for later use
        cur_feat = part{cls}(f);
        
        util{cls}(f,1) = cur_feat;        
        % util{class}(attr) = difference in normalized weight in
        % two classes
        util{cls}(f,2) = sum(Xs{cls}(:,cur_feat))/n_coms - ...
            sum(Xs{3-cls}(:, cur_feat))/n_other;
    end
    
    % We sort the attributes by utilities
    util{cls} = sortrows(util{cls}, [-2]);
    
    % We sort attribute labels by the same order
    util_label{cls} = F_label(util{cls}(:,1));
end

% We normalize the utilities to [0,1]
max_util = max(max(util{1}(:,2)), max(util{2}(:,2)));
min_util = min(min(util{1}(:,2)), min(util{2}(:,2)));

for cls = 1:m_classes
    
    for i=1:numel(part{cls})
        util{cls}(i,2) = (util{cls}(i,2) - min_util) / (max_util - min_util);
    end
    
    util{cls} = sortrows(util{cls}, -2);
    util_label{cls} = F_label(util{cls}(:,1));
    util{cls} = util{cls}(:,2);
    
end

end