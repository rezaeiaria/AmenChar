function [ score ] = simplified_form_feature_score( Xs, feature, denominatorValues)
    X = Xs(:, feature);
    squareX = X.^2;
    score = sum(squareX./denominatorValues);
end