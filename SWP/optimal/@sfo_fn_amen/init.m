% Implementation by Andreas Krause (krausea@gmail.com)
% 
% Example: See sfo_fn.m and the tutorial script for more information
function [F,val] = init(F,sset)
sset = sfo_unique_fast(sset);
if ~isequal(sset,get(F,'current_set'))
    
    
    %region of X which corresponds to the class
    X = F.X;
    selected_class = F.selected_class;
    total_classes = F.total_classes;
    
    % x is (#class)n x d, n: # of +/- examples, d: number of features
    selected_elements = sset;
    
    %     [n2 d] = size(X); 
%     
%     class_size = n2 / total_classes;
%     
%     class_start = (selected_class-1)*(class_size) + 1
%     class_end = (selected_class)*(class_size)
%     
%     X = X((class_start:class_end),:)
    
    val = sfo_amen_l2_score(X, selected_elements);   
    
    F = set(F,'current_set',sset,'current_val',val);
else
    val = get(F,'current_val');
end