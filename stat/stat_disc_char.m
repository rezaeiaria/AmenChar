% function stat_disc_char(amen_res, amen_stat, lasso_res, lasso_stat)

for cls=1:numel(amen_res)
    achar = cell2mat(amen_stat{cls}(:,2));
    acomchar = cell2mat(amen_stat{cls}(:,3));
    adisc = cell2mat(amen_stat{cls}(:,4));
    aweight = cell2mat(amen_res{cls}(:,2));
    
    fprintf('There are %d zero features that are omitted from %d\n', ...
        sum(aweight <= 0), numel(aweight));
    
    achar = achar(aweight > 0);
    adisc = adisc(aweight > 0);
    acomchar = acomchar(aweight > 0);
    aweight = aweight(aweight > 0);
    
    disp(min(aweight));
    
    lchar = cell2mat(lasso_stat{cls}(:,2));
    ldisc = cell2mat(lasso_stat{cls}(:,4));
    lweight = cell2mat(lasso_res{cls}(:,2));
    
    disp(min(lweight));
    
    amen_char_score = full(dot(achar, aweight) / sum(aweight));
    amen_disc_score = full(dot(adisc, aweight) / sum(aweight));
    amen_com_score = full(dot(acomchar, aweight) / sum(aweight));
    lasso_char_score = full(dot(lchar, lweight) / sum(lweight));
    lasso_disc_score = full(dot(ldisc, lweight) / sum(lweight));
    
    amen_char(end+1) = amen_char_score;
    amen_disc(end+1) = amen_disc_score;
    lasso_char(end+1) = lasso_char_score;
    lasso_disc(end+1) = lasso_disc_score;
    
    fprintf('Class %d:\n', cls);
    fprintf('\tAMEN\tLASSO\n');
    fprintf('CHAR:\t%.3f\t%.3f\n', amen_char_score, lasso_char_score);
    fprintf('DISC:\t%.3f\t%.3f\n', amen_disc_score, lasso_disc_score);
    fprintf('\n\n');
    
%     break;
end

% end