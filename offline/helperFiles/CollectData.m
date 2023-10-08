% This is code for Exercises 1 and 2 as part of the Pocket AI
% and IoT workshop, which debuted at the Grace Hopper Celebration 2019, 
% and presented at the Society of Women Engineers WE19

function m = CollectData(sampleRate, secs)

% Use the mobiledev command to create an 
% object that links your mobile device.

m = mobiledev;

% Set the sample rate
m.SampleRate = sampleRate;

% Enable acceleration sensor on the device.

m.AccelerationSensorEnabled = 1;

% Display the mobiledev connection
%input(sprintf('Type 1 and press Return to start logging, then move for %d seconds.', secs));
disp('Start your activity in 5 secs')
for n=5:-1:1 disp(n), pause(1), end
disp('Start your activity(walk,run,idle) for 20 secs')
% Start acquiring data

m.Logging = true;

% Now that you have enabled logging, you are
% acquiring sensor data. Please walk around the room
% for the amount of time shown. You'll count the number of steps
% that you took in the next part of this exercise.
pauseFor(secs);

% Stop acquiring accelerometer data

m.Logging = false;

disp('Data collection complete.');
