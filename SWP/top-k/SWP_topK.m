function [feats, totalScore] = SWP_topK( Xs, K )

    n_class = numel(Xs);
    k_feats = size(Xs{1},2);
    
    feats = cell(n_class,1);
    
    % value(i,j) = the value of feature j for class i
    value = zeros(n_class,k_feats);
    for cls=1:n_class
        value(cls,:) = sum(abs(Xs{cls}),1);
    end
    
    % candids are the top k retrieved features.
    % They will be distributed among two classes
    candids = cell(n_class,1);
    no_more = zeros(n_class,1);
    
    while (~allDone(feats, no_more, K))
        % 1. Find candidates
        usedFeats = [];
        for cls=1:n_class
            usedFeats = [usedFeats feats{cls}];
        end
        remFeats = k_feats - numel(usedFeats);
        for cls=1:n_class
%             fprintf('For class %d\n', cls);
            [candids{cls}] = SWP_topK_Lazy_Greedy(Xs{cls}...
                ,min(K - numel(feats{cls}),remFeats), feats{cls}, usedFeats);
            if (numel(candids{cls}) == 0)
                no_more(cls) = 1;
            end
        end
        
        
        f_index = 1:k_feats;
        fval = zeros(n_class, k_feats);
        
        for cls=1:n_class
            for i=1:numel(candids{cls})
                fval(cls, candids{cls}(i)) = value(cls, candids{cls}(i)) + eps;
            end
        end
        
        nzfeat = (sum(fval) > 0);
        f_index = f_index(nzfeat);
        fval = fval(:,nzfeat);
        
        selected = cell(n_class,1);
        for i=1:numel(f_index)
            [val,targetCls] = max(fval(:,i));
            if (val ~= 0)
                selected{targetCls}(end+1) = f_index(i);
            end
        end
        
        
        % 3. Fill in selected features with new values
        for cls=1:n_class
            feats{cls} = addTrim(feats{cls}, selected{cls}, K);
        end
    end
    
    totalScore = amen_class_score(Xs, feats);
end

function res = isDone(feats, no_more, K)

res = (numel(feats) == K) | no_more;

end

function res = allDone(feats, no_more, K)

n_class = size(feats,1);

for i=1:n_class
    cur_done = isDone(feats{i}, no_more(i), K);
    if (cur_done == 0)
        res = 0;
        return;
    end
end
    
res = 1;

end

function addedA = addTrim(a, b, totSize)
    
    addedA = [a b];
    addedA = addedA(1:min(numel(addedA),totSize));
end