function [ A, F, A_label, F_label ] = util_refineAmazon( A, F, A_label, F_label)
[ A, F, A_label, F_label ] = util_refineData( A, F, A_label, F_label);
% We first remove any ( C ) from the features
badList = [];
for i='A':'Z'
    feat = sprintf('( %c )', i);
    ind = util_findFeature(F_label, feat);
    if (ind ~= -1)
        badList = [badList ind];
    end
end
k_feat = size(F,2);
F = F(:,setdiff(1:k_feat, badList));
F_label = F_label(setdiff(1:k_feat, badList));
fprintf('%d bad features were removed\n', numel(badList));

% Then we remove anything with amazon.com in it
badList = [];
badFeat = {'amazon', 'categor', 'actor', 'director', 'today', 'book', 'subject', 'deal',...
    'title', 'outlet', 'by ', 'writer', 'store', 'general', 'genre', 'format','authors', 'books',...
    'musics', 'special features', 'special interests',...
    'studio specials', 'character'};
k_feat = size(F,2);
for i=1:k_feat
    for j=1:numel(badFeat)
        curbadFfeat = badFeat{j};
        if (strfind(lower(F_label{i}), curbadFfeat) > 0)
            badList = [badList i];
            break;
        end
    end
end

k_feat = size(F,2);
F = F(:,setdiff(1:k_feat, badList));
F_label = F_label(setdiff(1:k_feat, badList));
fprintf('%d bad features were removed\n', numel(badList));
end