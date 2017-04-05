function [ res ] = util_AssrtBinary( A, F )
F = full(F);
cats = unique(F);
D = sum(A);
m = sum(A(:))/2;

res = 0;
for i=1:numel(cats)
    curNode = ( F == cats(i));
    curA = A(curNode, curNode);
    sumD = sum(D(curNode));
    
    res = res + sum(curA(:)) - (sumD * sumD) / (2*m);
end

res = res / (2 * m);
end

