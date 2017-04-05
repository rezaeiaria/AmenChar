function [ values ] = simplified_form_denominator_values(X)
%L2_SCORE L2 score of given item subset
   
    num_items = size(X,1);
    values = zeros(num_items,1);
    for item = 1:num_items
        Xi = X(item, :);
        values(item) = norm(Xi);
    end
    % return the Di values for each item in the class
end