function plotPredictedActivity(tWalk, tRun, tIdle, tTransition, windowLength)

% This function plots predicted activity over time

figure;
hold on

% Display a dot for the periods of time when you 
% did each activity (run, walk, idle)
hWalk = scatter(tWalk+windowLength,...
                0*tWalk+5,'filled');
            
hRun  = scatter(tRun+windowLength,...
                0*tRun+10, 'filled');
            
hIdle = scatter(tIdle+windowLength,...
                0*tIdle, 'filled');

% Set properties of the display of the figure, 
% including the legend entries, labels, and axis limits
ylim([-5 15]);
set(gca,'TickLength',[0 0])
set(gca, 'YTick', [0 5 10])
yticklabels({'Idle', 'Walk', 'Run'})
title('Detected Activity Over Time',...
      'FontSize', 16);
xlabel('Time Step', 'FontSize', 16);
xAX = get(gca,'XAxis');
set(xAX,'FontSize', 14)
% Add legend to the graph
legend([hWalk, hRun, hIdle], ...
    'Walking','Running','Idle', 'FontSize', 14); 
hold off
set(gcf,'color','w');
