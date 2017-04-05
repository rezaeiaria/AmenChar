function [ jac] = util_split_amazon( A_init, F_init, A_label_init, F_label_init, G, names )
% allA, allF, allF_label, allA_label, 
% G = groups
g_groups = max(G)+1;
allA = cell(g_groups,1);
allF = cell(g_groups,1);
allF_label = cell(g_groups,1);
allA_label = cell(g_groups,1);

memberIdx = cell(g_groups,1);
activeFeats = cell(g_groups,1);

for i=0:(g_groups-1)
    memberIdx{i+1} = find(G == i);
    activeFeats{i+1} = find(sum(F_init(memberIdx{i+1},:)) > 0);
end

jac = zeros(g_groups, g_groups);
for i=1:g_groups
    for j=1:g_groups
%         fprintf('intersect: %s v %s = %d\n', names{i}, names{j}, numel(intersect(activeFeats{i},activeFeats{j})));
%         fprintf('union: %s v %s = %d\n', names{i}, names{j}, numel(union(activeFeats{i},activeFeats{j})));
        jac(i,j) = numel(intersect(activeFeats{i},activeFeats{j})) / ...
            numel(union(activeFeats{i},activeFeats{j}));
    end
end

disp(jac);

for i=1:g_groups
    if ( i ~= 4 )
        continue;
    end
    curNode = memberIdx{i};
    curFeat = activeFeats{i};
%     fprintf('max index = %d\tsize = %d\n', max(curNode), size(A_init,1));
%     fprintf('\tsize index = %d\n', numel(curNode));
    allA{i} = A_init(curNode,curNode);
    allA_label{i} = A_label_init(curNode);
    allF{i} = F_init(curNode,curFeat);
    allF_label{i} = F_label_init(curFeat);
    
    [allA{i}, allF{i}, allA_label{i}, allF_label{i}] = ...
        util_refineData(allA{i}, allF{i}, allA_label{i}, allF_label{i});
    A = allA{i};
    F = allF{i};
    A_label = allA_label{i};
    F_label = allF_label{i};
    save(sprintf('amazon-%s.mat',names{i}), 'A', 'F', 'A_label', 'F_label');
    fprintf('%ss:\tNodes: %d\tEdges: %.0f\tFeatures: %d\n', names{i}, size(allA{i},1), full(sum(allA{i}(:))/2), size(allF{i},2));
end

% curNode = union(memberIdx{3}, memberIdx{4});
% curFeat = union(activeFeats{3}, activeFeats{4});
% 
% A = A_init(curNode, curNode);
% A_label = A_label_init(curNode);
% F = F_init(curNode, curFeat);
% F_label = F_label_init(curFeat);
% fprintf('%ss:\tNodes: %d\tEdges: %.0f\tFeatures: %d\n', names{i}, size(A,1), full(sum(A(:))/2), size(F,2));
% save('amazon-video-dvd.mat', 'A', 'F', 'A_label', 'F_label');

end
