% This is the first half of Exercise 3
% as part of the Pocket AI and IoT workshop, 
% debuted at the Grace Hopper Celebration 2019, 
% and presented at the Society of Women Engineers WE19

% Clear all previously collected data and plots
clear m; clearvars -except teamID; close all; clc;

% Add the helper files to your path so that
% you can use them in this file. 
addpath(fullfile(pwd,'helperFiles'));

% Check whether you have licenses for all 
% required products
checkProductLicenses();

%% Enter a team ID
%teamID = input('Enter your team ID (1 to 5) and press Return','s');
teamID = randi(5);
if isempty(teamID)
    teamID = num2str(randi(5));
    disp(['Your team ID is ' teamID])
end

% Collect data and predict activity
Ex2_ClassifyActivity
%% Aggregate time taken for various activities
% to open IoT platform - ThingSpeak

fitnessChallengeChannelID = 858227;
fitnessChallengeWriteAPIKey = 'CP4U657DEMSGJ4QS';

% tWalkSum is the total duration that was
% spent in walking. This is written to field 1
% of the channel. 
% Similarly, tRunSum and tIdleSum are the 
% total duration of the time spent in 
% running and idling, respectively.
% tRunSum is written to field 2 and
% tIdleSum is written to field 3 of the channel

dataWritten = false;
while ~dataWritten
    try
        thingSpeakWrite(fitnessChallengeChannelID,...
                        {tWalkSum, tRunSum, tIdleSum, teamID},...
                        'WriteKey',fitnessChallengeWriteAPIKey);
        dataWritten = true;
    catch 
        pauseFor(randi(10))
    end
end

% Read the total data that everyone has written
% to the channel in the last 60 minutes
numMins = 60;
ThisData = thingSpeakRead(fitnessChallengeChannelID,...
    'Numminutes',numMins,...
    'OutputFormat','table');

% Plot a bar chart of activities for the most
% active in the room
if ~isempty(ThisData)    
    y = [ThisData.WalkData ThisData.RunData];
    figure
    b = bar(sum(y,1),'FaceColor','flat');
    b.CData(1,:) = [1 0 0];
    b.CData(2,:) = [0 0 1];
    set(gca,'xticklabel',{'walk', 'run'});
    title(['Fitness Challenge - Overall Results in the past ' num2str(numMins) ' minutes']);
    xlabel('Activity')
    ylabel('Total Time (seconds)');
else
    figure
    text(0.5, 0.5, ...
         ['No data collected in the past ' num2str(numMins) ' minutes'],...
         'HorizontalAlignment', 'center')
end
