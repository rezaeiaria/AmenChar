function [ res ] = util_AssrtScalar( A, F )

% Assortativity = ( sum(F.* (A * F)) - sum(D.*F)^2/2m ) / 
%                 ( sum(D.*F.*F) - sum(D.*F)^2/2m )
D = sum(A,2);
M2 = sum(D);
AF = A * F;
AF = sum(F.* AF);
quadSum = sum(D.*F)^2/M2;
DFF = sum(D.*F.*F);

res = (AF - quadSum) / (DFF - quadSum);

end

