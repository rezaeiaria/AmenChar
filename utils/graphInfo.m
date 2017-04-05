function graphInfo(A, F)

fprintf('#Nodes = %d\n', size(A,1));
fprintf('#Edges = %d\n', (nnz(A))/2);
fprintf('#Features = %d\n', size(F,2));
fprintf('Average Degree = %.3f\n', nnz(A)/size(A,1));
% fprintf('#Democrats = %d\n', sum(P == 1));
% fprintf('#Republicans = %d\n', sum(P == 0));

end