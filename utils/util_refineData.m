function [ A, F, A_label, F_label]  = util_refineData( A, F, A_label, F_label, ...
    graph_name )
%     P, P_label, NP, NP_label, ...
%     U, U_label, NU, NU_label, ...
%     I, I_label, NI, NI_label, ...
%     J, J_label, NJ, NJ_label]
   
%     P, P_label, NP, NP_label, ...
%     U, U_label, NU, NU_label, ...
%     I, I_label, NI, NI_label, ...
%     J, J_label, NJ, NJ_label, ...

% Remove singletons
cnt = 1;
fprintf('Before\n');
disp(size(A));
disp(size(F));
while (1)
    fprintf('Removing singletons iteration #%d\n',cnt);
    D = sum(A);
    goodNodes = D > 1;
    
    if (sum(goodNodes) == full(size(A,1)))
        break;
    end
    
    [A, F, A_label, F_label] = util_filterNode(A, F, A_label, F_label,...
        goodNodes);
    
    if (strcmp(graph_name, 'gplus') == 1)
        [P, P_label] = util_filterFeatureByNodes(P, P_label, goodNodes);
        [NP, NP_label] = util_filterFeatureByNodes(NP, NP_label, goodNodes);
        [I, I_label] = util_filterFeatureByNodes(I, I_label, goodNodes);
        [NI, NI_label] = util_filterFeatureByNodes(NI, NI_label, goodNodes);
        [J, J_label] = util_filterFeatureByNodes(J, J_label, goodNodes);
        [NJ, NJ_label] = util_filterFeatureByNodes(NJ, NJ_label, goodNodes);
        [U, U_label] = util_filterFeatureByNodes(U, U_label, goodNodes);
        [NU, NU_label] = util_filterFeatureByNodes(NU, NU_label, goodNodes);
    end
    cnt = cnt + 1;
end

% Remove nodes without any attribute
sumf = sum(F,2);
goodNodes = sumf > 0;
A = A(goodNodes, goodNodes);
A_label = A_label(goodNodes);
F = F(goodNodes,:);

fprintf('After\n');
disp(size(A));
disp(size(F));

end