function [ res ] = stat_rank_assort( A, F, F_label )

minFeat = min(F(:));
maxFeat = max(F(:));
numUnique = numel(unique(F(:)));

if ((minFeat == 0) && (maxFeat == 1) && (numUnique == 2))
    fprintf('Features are binary.\n');
    type = 'bin';
else
    fprintf('Features are scalar.\n');
    type = 'cat';
end

k_feats = size(F,2);
res = cell(k_feats,3);
count = 0;
tic;
for featidx = 1:k_feats
    fprintf(repmat('\b', 1, count));
    count = fprintf('%d/%d\t%.3f', featidx, k_feats, toc);
    if (strcmp(type,'bin') == 1)
        res{featidx,1} = full(util_AssrtBinary(A, F(:,featidx)));
    else
        res{featidx,1} = full(util_AssrtScalar(A, F(:,featidx)));
    end
    res{featidx,2} = full(sum(F(:,featidx)));
    res{featidx,3} = F_label{featidx};
end
fprintf('\n');

res = sortrows(res, [-1 -2 3]);
end

    