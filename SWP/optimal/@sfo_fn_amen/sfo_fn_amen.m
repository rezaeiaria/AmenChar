% The example from the tutorial slides at www.submodularity.org
% Implemented by Andreas Krause (krausea@gmail.com)
% F([]) = 0, F([1])= -1, F([2]) = 2, F([1,2]) = 0
%
% function R = sfo_fn_example(A)
% A: Input set to evaluate, [],[1],[2],[1,2]
% Example: F = sfo_fn_example; F([1,2])

function F = sfo_fn_amen(X, selected_class, total_classes)
% F = sfo_fn_wrapper(@l2_score);
[n2 d] = size(X); 

F.V = 1:d;
F.X = X;
F.selected_class = selected_class;
F.total_classes = total_classes;

F = class(F,'sfo_fn_amen',sfo_fn);
F = set(F,'current_set',-1);