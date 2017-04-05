function [coms, hubs, seeds] = main_getComs(A, F, F_label, feats, graphname)

featid = zeros(numel(feats),1);

fprintf('Finding feature IDs\n');
for i=1:numel(feats)
    featid(i) = util_findFeature(F_label, feats(i));
end
fprintf('Found features\n');

members = cell(numel(feats), 1);
for cls=1:numel(feats)
    members{cls} = find(F(:,featid(cls)));
end

seeds = cell(numel(feats),1);
for cls=1:numel(feats)
    seeds{cls} = members{cls};
    for other=1:numel(feats)
        if (cls == other)
            continue;
        end
        seeds{cls} = setdiff(seeds{cls}, members{other});
    end
end


totSeen = zeros(numel(feats),1);
coms = cell(numel(feats),1);
hubs = cell(numel(feats), 1);
fprintf('Retrieving communities\n');

if (exist(['cpp/graph/' graphname '.edge'], 'file') ~= 2)
    io_save_graph_cpp(A, ['cpp/graph/' graphname '.edge']);
end
for cls = 1:numel(feats)
    % Saving SEEDS and FILE Structure for the local clustering code
    
    io_save_seeds(seeds{cls}, ['cpp/graph/' graphname '.seed']);

    cd cpp/
    % Running the local clustering code
    system(['LocalClustering.exe graph/' graphname '.edge graph/' ...
        graphname '.seed clusters/' graphname]);
    cd clusters/

    % Retrieving the results of local clustering code
    nonExisting = 0;
    emptyFile = 0;
    for i=1:numel(seeds{cls})
        filename = [graphname '_' num2str(seeds{cls}(i)) '.cluster'];
        if (exist(filename, 'file'))
            s = dir(filename);
            if (s.bytes == 0)   % If the community file is empty
                emptyFile = emptyFile + 1;
                continue;
            end
            com = dlmread(filename)';

            % Updating total number of coms for class (curCls)
            totSeen(cls) = totSeen(cls) + 1;

            % Adding current com to the set of coms for class (curCls)
            coms{cls}{totSeen(cls),1} = com;
            
            % Adding successful seed index for class (curCls)
            hubs{cls}(totSeen(cls),1) = seeds{cls}(i);
        else
            nonExisting = nonExisting + 1;
        end
    end

    system('rm *');
    cd ../../
end

end