function nodes = util_findMembers(F, F_label, feats)

m_classes = numel(feats);

nodes = {};
fid = zeros(m_classes, 1);
for cls = 1:m_classes
    fid(cls) = util_findFeature(F_label, feats{cls});
end

for cls = 1:m_classes
    nodes{cls} = find(F(:, fid(cls)) & ~F(:, fid(3 - cls)));
end

end