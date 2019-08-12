[sg,si] = sort(sum(truth(igo,:)'),'descend')
rowind = repmat([1:626]',1,626);
rrows = reshape(rowind,626*626,1);
rmet = reshape(GENIE3,626*626,1);
[smets,sind] = sort(rmet,'descend');
temp = rrows(sind);
for i = 1:12
d{i} = find(ismember(temp,igo(i)));
end
yyaxis right
for i = 1:12
h1= raincloud_plot('X', d{si(i)}, 'box_on', 1, 'color', cb(i,:), 'alpha', 0.5,...
'box_dodge', 1, 'box_dodge_amount', .15+.2*(i-1), 'dot_dodge_amount', .15+.2*(i-1),...
'box_col_match', 0);
end
axis([0 626*626 -.05 0])
xticks([1 626^2])
xticklabels({'1' '391876  '})
yticks(-0.003-.004*[length(igo)-1:-1:0])
%yticklabels(flipud(tf(igo(si))))
xlabel('Outgoing Edge Rank');
%ylabel('Regulator');
axis square;