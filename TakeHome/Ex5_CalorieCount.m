% This is take home Exercise 5 as part of the Pocket AI and IoT workshop,
% debuted at the Grace Hopper Celebration 2019, 
% and presented at the Society of Women Engineers WE19

% In this exercise, you are going to measure calorie consumption for the
% steps you've taken.
% 
% Steps to be performed in this exercise:
% 1. Enter your stats: Height and Weight
% 2. Walk/Run/Stay Idle for 5 minutes!

%% TODO - Replace [] with your height.  If your height is say x feet y inches, then enter height = x + y/12
height = 5+0/12;  

%% TODO - Replace [] with your weight
weight = 100;

%% Clear all previously collected data and plots
clear m; clearvars -except teamID; close all;

% Add the helper files to your path so that
% you can use them in this file. 
addpath(fullfile(pwd,'helperFiles'));

% Collect new data for 300 seconds at a 
% frequency of 60Hz
secs = 300;
sampleRate = 60;
m = CollectData(sampleRate, secs);

% Retrieve the XYZ acceleration data
% and timestamps from the device

[a, t] = accellog(m);

% Now that you have collected the data, 
% you will visualize what you measured
% and then analyze it to count the number of
% steps taken.

% Calculate the magnitude of the 
% <X, Y, Z> acceleration vectors

x = a(:,1);
y = a(:,2);
z = a(:,3);
mag = sqrt(sum(x.^2 + y.^2 + z.^2, 2));

% Subtract the mean from the data to 
% remove constant effects, like gravity.

magNoG = mag - mean(mag);

% Count the number of steps taken
% by finding peaks in the acceleration
% magnitude data.

minPeakHeight = max(1,std(magNoG));

[pks, locs] = findpeaks(magNoG,...
                        'MINPEAKHEIGHT',...
                        minPeakHeight);

% The number of steps taken is simply the 
% number of peaks found.

numSteps = numel(pks);

%% Calculate calories burned
caloriesBurned = calorieCount(weight,height,numSteps);

%% Clean up
% Turn off the acceleration sensor and
% clear mobiledev.

m.AccelerationSensorEnabled = 0;

clear m;