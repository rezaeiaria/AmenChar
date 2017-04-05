function [oldA] = util_sparsify(A, prcnt)

E = sort(unique(A(:)));
E = E(E>0);

[~,initGc] = giant_component(A);
if (numel(initGc) ~= size(A,1))
    fprintf('The graph is not connected.\n');
    return
end

newA = [];
oldA = A;

for i=1:numel(E)
    curW = E(i);
    newA = A;
    newA(newA <= curW) = 0;
    newA(newA >  curW) = 1;
    [~, newGc] = giant_component(newA);
    
    if ((numel(newGc) / size(A,1)) < prcnt)
        fprintf('Used %d to do it\n', E(i-1));
        break;
    end
    
    oldA = newA;
end

end