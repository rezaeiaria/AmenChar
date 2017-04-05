function stat_policyPiePercent(util, util_label)

y = util(:,2);
y = y / max(y) * 100;
y_label = util_label;
% 
% rest = sum(y(y < 10));
% 
% disp(y);
% disp(rest);
% 
% y_label = [y_label(y >= 10); 'Other'];
% y = [y(y >= 10); rest];

pie(y);
legend(y_label, 'Location' , 'westoutside', 'Orientation' ,'vertical');

end