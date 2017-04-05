function [ A_part, score, scores ] = SWP_Amen( Xs )
%SWP_Amen Offline Submodular Welfare Problem for amen with classes

% x is 2n x d, n: # of +/- examples, d: number of features
    k_classes = numel(Xs);
    num_features = size(Xs{1},2);

    Fs = {};
    for i=1:k_classes
        F = sfo_fn_amen(Xs{i},i,k_classes);
        Fs{end+1} = F;
    end    
    
    [A_part, scores] = sfo_greedy_welfare(Fs, 1:num_features);
    
    score = amen_class_score(Xs, A_part);
    
%     max_bound = sfo_maxbound_welfare(Fs, 1:num_features, A_part)
end

