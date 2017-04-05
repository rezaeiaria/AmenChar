function nodes = util_getTopKDegree(candidates, D, K)

D = D(candidates);

pair = zeros(numel(candidates),2);
for i=1:numel(candidates)
    pair(i,1) = candidates(i);
    pair(i,2) = D(i);
end

pair = sortrows(pair, -2);
nodes = pair(1:K,1);

end