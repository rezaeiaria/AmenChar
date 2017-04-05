function [ave, var, label] = util_congressAveAll(amen)

ave = cell(2,1);
var = cell(2,1);
label = cell(2,1);

load dataset/policy.mat

for cls = 1:2
    ave{cls} = zeros(numel(amen), numel(policy));
    var{cls} = zeros(numel(amen), numel(policy));
    for cngId = 1:numel(amen)
        cur_res = amen{cngId}{cls};
        for i=1:size(cur_res,1)
            feat_name = cur_res{i,1};
            feat_id = util_findFeature(policy, feat_name);
            ave{cls}(cngId, feat_id) = cur_res{i,2};
            var{cls}(cngId, feat_id) = cur_res{i,3};
        end
    end
    
    ave{cls} = mean(ave{cls})';
    var{cls} = mean(var{cls})';
    [ave{cls}, idx] = sort(ave{cls}, 'descend');
    var{cls} = var{cls}(idx);
    label{cls} = policy(idx);
end

end