function feat = util_superFeature(F, idx)
% Creates a super-feature from a list of features
% The new feature is the OR of all features inside
% the list.
% featid = [];
% for i=1:numel(featList)
%     featid(i) = util_findFeature(F_label, featList{i});
% end

F = F(:,idx);
feat = sum(F,2);
feat(feat>0) = 1;

end