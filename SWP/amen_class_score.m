function [ score ] = amen_class_score( Xs, feature_assignment )
%AMEN_CLASS_SCORE Summary of this function goes here
%   Detailed explanation goes here

    assert(numel(Xs) == numel(feature_assignment));

    score = 0;
    for i=1:numel(feature_assignment)
        score = score + sfo_amen_l2_score( Xs{i}, feature_assignment{i} );
    end

end

