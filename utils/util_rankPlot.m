function util_rankPlot(d, err, lbl, class_name)

f = figure();

bar(d);
hold on;
errorbar(d, err, '.r');

view(90, 90);
set(gca, 'XTickLabel', lbl);
title(class_name);

f.Units = 'inches';
f.Position = [5 5 4 4];


end