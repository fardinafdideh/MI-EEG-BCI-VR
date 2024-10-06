subplot(6,6,8:11)
plot(t,newData(1,:));
set(gca,'XLim',[-10 0],'YLim',[-5*10^-5 5*10^-5], 'xtick', -10:0);
title('Channel C - current epoch','color',[0 .5 0],'FontSize',13);
subplot(6,6,20:23)%axis(handles.axes7)
plot(t,newData(2,:));
set(gca,'XLim',[-10 0],'YLim',[-5*10^-5 5*10^-5], 'xtick', -10:0);
title('Channel D - current epoch','color',[0 .5 0],'FontSize',13);
subplot(5,6,26:29)
plot(t,newData(3,:));
set(gca,'XLim',[-10 0],'YLim',[-5*10^-5 5*10^-5], 'xtick', -10:0);    
title('Channel E - current epoch','color',[0 .5 0],'FontSize',13);