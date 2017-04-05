function newF = util_selectFeatures(F, F_label, feats)

% fid = zeros(numel(feats),1);
newF = zeros(size(F,1), numel(feats));
for i=1:numel(feats)
    fid = util_findFeature(F_label, feats{i});
    if (fid ~= -1)
        newF(:,i) = F(:,fid);
    end
end

end