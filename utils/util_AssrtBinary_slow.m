function [ res ] = util_AssrtBinary_slow( A, F )
% A = adjacency matrix
% F = feature vector (vertical)

if (size(F,1) == 1)
    F = F';
end

D = sum(A,2);   % Degree vector (vertical vector)
m = sum(D) / 2; % The number of edges in the graph
n = size(A,1);  % The number of vertices in the graph
delta = util_KronMat(F);

res = 0;
for i=1:n
    for j=1:n
       res = res + ( A(i,j) - (D(i)*D(j)/(2*m)) ) * delta(i,j);
    end
end

res = 1/(2*m) * res;

end

