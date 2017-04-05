function ind = util_findNode(A_label, name)

ind = -1;
for i=1:numel(A_label)
    if (strcmp(A_label{i}, name) == 1)
        ind = i;
    end
end

end