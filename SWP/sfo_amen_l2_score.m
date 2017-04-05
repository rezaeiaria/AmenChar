function [ score ] = sfo_amen_l2_score( X, item_subset )
%L2_SCORE L2 score of given item subset

    % select subset of items
    X = X(:,item_subset);

    % L2 normalize
    X = sqrt(sum(X.^2, 2));
    % sqrt(sum(abs(M).^2,1));

    % sum
    score = sum(X)/size(X,1);
end