% This is the code for Exercise 1, step counting,
% as part of the Pocket AI and IoT workshop, 
% debuted at the Grace Hopper Celebration 2019, 
% and presented at the Society of Women Engineers WE19

% Run this file once you are ready to start counting
% the number of steps you walked.

% Clear all previously collected data and plots
clear m; clearvars -except teamID; close all;

% Add the helper files to your path so that
% you can use them in this file. 
addpath(fullfile(pwd,'helperFiles'));

% Check whether you have licenses for all 
% required products
checkProductLicenses();

% Collect new data for 20 seconds at a 
% frequency of 10Hz
secs = 20;
sampleRate = 10;
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

warning Off % Suppress warning thrown if
            % no peaks detected
[pks, locs] = findpeaks(magNoG,...
                        'MINPEAKHEIGHT',...
                        minPeakHeight);


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

warning On  % Re-enable warnings
%% Clean up
% Turn off the acceleration sensor and
% clear mobiledev.

m.AccelerationSensorEnabled = 0;

clear m;
