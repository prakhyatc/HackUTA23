% This is the second half of the code for Exercise 1,
% as part of the Pocket AI and IoT workshop presented
% at the Grace Hopper Celebration 2019

% Run this file once you are ready to start counting
% the number of steps you walked.

% Clear all previously collected data and plots
clear m; clearvars -except userID; close all;

% Add the helper files to your path so that
% you can use them in this file. 
addpath(fullfile(pwd,'helperFiles'));

% Retrieve logged sensor data
load('newDataWalking.mat');

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

warning Off % Suppress warning thrown if
            % no peaks detected
[pks, locs] = findpeaks(magNoG,...
                        'MINPEAKHEIGHT',...
                        minPeakHeight);
warning On  % Re-enable warnings

% The number of steps taken is simply the 
% number of peaks found.

numSteps = numel(pks);

% The peak locations can be visualized
% with the acceleration magnitude data.

figure; hold on
plot(t, magNoG);
plot(t(locs), pks, 'r',...
    'Marker', 'v', 'LineStyle', 'none');     
title('Counting Steps');
xlabel('Time (s)');
ylabel('|Acceleration|, No Gravity');
legend({'|Acceleration|, No Gravity', 'Steps'})
hold off;

%% Clean up
% Turn off the acceleration sensor and
% clear mobiledev.

m.AccelerationSensorEnabled = 0;

clear m;
