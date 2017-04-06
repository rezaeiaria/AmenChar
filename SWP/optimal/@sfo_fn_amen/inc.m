% Implementation by Andreas Krause (krausea@gmail.com)
% 
% Example: See sfo_fn.m and the tutorial script for more information
function scoreNew = inc(F,A,el)
    A = sfo_unique_fast(A);
    F = init(F,A);

    n = length(F.V);
    oldScore = get(F,'current_val');

    if sum(A == el) > 0
        scoreNew = oldScore;
        return
    end

    %region of X which corresponds to the class
    X = F.X;
    selected_class = F.selected_class;
    total_classes = F.total_classes;
    
    selected_elements = [A el];
    
    % x is (#class)n x d, n: # of +/- examples, d: number of features
%     [n2 d] = size(X); 
%     
%     class_size = n2 / total_classes;
%     
%     class_start = (selected_class-1)*(class_size) + 1
%     class_end = (selected_class)*(class_size)
%     
%     X = X((class_start:class_end),:)
    
    scoreNew = sfo_amen_l2_score(X, selected_elements);
