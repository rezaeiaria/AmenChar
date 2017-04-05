function res = stat_featAbsUtil(X, feats, f)

res = sfo_amen_l2_score(X, union(feats,f)) - sfo_amen_l2_score(X, setdiff(feats,f));

end