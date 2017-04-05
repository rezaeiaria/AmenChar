function [ partition,  total_score] = SWP_linear( Xs )
%SWP_GREEDY Summary of this function goes here
%   Detailed explanation goes here
    k_classes = numel(Xs);
   
    num_features = size(Xs{1},2);
 
    partition = cell(1,k_classes);

    for feature = 1:num_features
        featureScores = zeros(k_classes,1);            
        for class = 1: k_classes
            num_items = size(Xs{class},1);
            denominatorValues = simplified_form_denominator_values(Xs{class});
            featureScores(class) = simplified_form_feature_score(Xs{class}, feature, denominatorValues) / num_items;
        end    
        
       [best_score, best_ind] = max(featureScores);
        
        partition{best_ind} = [partition{best_ind} feature];    
    end
    total_score = amen_class_score(Xs, partition);
end

