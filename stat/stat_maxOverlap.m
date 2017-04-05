function [res, u, v] = stat_maxOverlap(coms)

fprintf('There are %d communities in total\n', numel(coms));

res = -1;
for i=1:numel(coms)
    for j=1:numel(coms)
        if ( i == j )
            continue;
        end
        inter = numel(intersect(coms{i},coms{j}));
%         fprintf('i = %d\tj=%d\n', i, j);
%         fprintf('First size = %d\tSecond size = %d\tIntersection =%d\n', ...
%             numel(coms{i}), numel(coms{j}), inter);
%         
%         fprintf('Intersection = %.3f\n', inter);
        overlap_first_second = inter / numel(coms{i});
        overlap_second_first = inter / numel(coms{j});
        
        overlap = min(overlap_first_second, overlap_second_first);
        if (overlap > res)
            res = overlap;
            u = i;
            v = j;
        end
%         
%         overlap = -1;
%         if (overlap_first_second > overlap_second_first)
%             overlap = overlap_first_second;
%         else
%             overlap = overlap_second_first;
%         end
%         
%         fprintf('Overlap between %d and %d is %.3f\n', i, j, overlap);
%         fprintf('\n');
%         
%         if (overlap > res)
%             res = overlap;
%         end
    end
end

end