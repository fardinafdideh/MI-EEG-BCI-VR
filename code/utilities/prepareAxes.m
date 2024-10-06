function prepareAxes(handles, axNbEEG, tMarker, yLim, channelName, tEnd)

for i = 1 : length(axNbEEG)
    set(handles.(['axes',num2str(axNbEEG(i)),'']), 'visible', 'on')
    hold(handles.(['axes',num2str(axNbEEG(i)),'']), 'on')
    set(handles.(['axes',num2str(axNbEEG(i)),'']),'XLim',[-tEnd, 0],'YLim',yLim, 'xtick', -tEnd:0);
    ylabel(handles.(['axes',num2str(axNbEEG(i)),'']), channelName{i}, 'visible', 'on'); % ,'color',[0 .5 0],'FontSize',13
    for j = 1 : length(tMarker)
        plot(handles.(['axes',num2str(axNbEEG(i)),'']), [tMarker(j); tMarker(j)], yLim, 'k--')
    end
    grid(handles.(['axes',num2str(axNbEEG(i)),'']), 'on')
    box(handles.(['axes',num2str(axNbEEG(i)),'']), 'on')
    if i ~= length(axNbEEG)
        set(handles.(['axes',num2str(axNbEEG(i)),'']), 'xticklabel', [])
    else
        xlabel(handles.(['axes',num2str(axNbEEG(i)),'']), 'time [sec]', 'visible', 'on');
    end
    drawnow
end