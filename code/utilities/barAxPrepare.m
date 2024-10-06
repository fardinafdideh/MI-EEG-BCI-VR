function barAxPrepare(axHandles, isYLim)
cla(axHandles);
labels = {'Left','Feet','Right'};
if ~isempty(isYLim)
    plot(axHandles, [0;length(labels)+1] , isYLim*ones(2, 1), 'k--');
    set(axHandles, 'ylim', [0, isYLim+5])
end
hold(axHandles, 'on');
box(axHandles, 'on');
bar(axHandles, 1:length(labels), nan(1,length(labels)))
set(axHandles, 'XTick', 1:length(labels), 'XTickLabel', labels, ...
    'Xlim', [1-0.5, length(labels)+0.5]); % , 'YTick', 0:100
ylabel(axHandles, 'predicted', 'visible', 'on')

