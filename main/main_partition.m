function [part] = main_partition(Xs)

m_targets = numel(Xs);

part = [];
for cls=1:m_targets
    sumx = sum(Xs{cls});
    if (max(sumx) == 0)
        return;
    end
end

[part, ~] = SWP_Amen(Xs);
% you can change this to any of the below
% [part, ~] = SWP_linear(Xs);
% [part, ~] = SWP_topK(Xs, K);

end