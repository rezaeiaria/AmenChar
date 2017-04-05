function [ res ] = util_AssrtScalar_slow( A, F )

D = sum(A,2);
n = size(A,1);
m = sum(D) / 2;

% numerator in the assortativity formula
num = 0;
for i=1:n
    for j=1:n
        num = num + ( A(i,j) - D(i)*D(j)/(2*m) ) * F(i) * F(j);
    end
end

% denumerator in the assortativity formula
den = 0;
for i=1:n
    for j=1:n
        den = den + ( D(i)*(i==j) - D(i)*D(j)/(2*m) ) * F(i) * F(j);
    end
end

res = num / den;

end

