function [ ind ] = util_findFeature( F_label, f_name )

ind = -1;
for i=1:numel(F_label)
    if (strcmpi(F_label{i}, f_name) == 1)
        ind = i;
    end
end
end

