function stat_congressPlot(y, feats, party)

years = 1994:2:2008;
years = years';
lbl = {};
for year=1994:2:2008
    lbl{end+1} = [num2str(year)];
end


if (party == 1)
    plot(years, y, 'LineWidth', 1.5);
else
    plot(years, y, '-r', 'LineWidth', 1.5);
end

if (size(y,2) == 1)
    title(feats);
else
    legend(feats, 'Location' ,'SouthOutside');
end
hold on;
% if (party == 1)
%     plot([2002,2002], [0, max(max(y))], '-r');
% else
%     plot([2002,2002], [0, max(max(y))], '-b');
% end
% axis tight;

set(gca,'XTickLabel',lbl, 'XTickLabelRotation', 45);
% set(gca, 'YLim', [0,1]);

end