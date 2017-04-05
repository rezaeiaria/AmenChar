function stat_assort_info( rank, k )

fprintf('Features:\n');
for i=1:k
    fprintf('%s\n', rank{i,3});
end
fprintf('\n');

fprintf('Assortativity:\n');
for i=1:k
    fprintf('%.4f\n', rank{i,1});
end
fprintf('\n');

fprintf('Number:\n');
for i=1:k
    fprintf('%d\n', rank{i,2});
end
fprintf('\n');
end

