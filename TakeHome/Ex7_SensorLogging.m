% This is take home Exercise 7 as part of the Pocket AI and IoT workshop 
% debuted at the Grace Hopper Celebration 2019, 
% and presented at the Society of Women Engineers WE19

% In this exercise, you are going to experiment with other mobile device sensors
% such as MagneticField, AngularVelocity and Orientation and plot data together. 
% Learn more about available sensors and how to process their data: 
% https://www.mathworks.com/help/matlabmobile/sensor-data-collection.html

% Steps to be performed in this exercise:

% 1. Create a connection to your Mobile Device
clear m; m = mobiledev;

% 2. Prepare for Data Acquisition from Multiple sensors
%% TODO 2a. Turn on Magnetic Field Sensor
m.MagneticSensorEnabled = true;

%% TODO 2b. Turn on Angular Velocity Sensor
m.AngularVelocitySensorEnabled = true;

%% TODO 2c. Turn on Orientation Sensor
m.OrientationSensorEnabled = true; 

%% 3. Start Acquiring Data
m.Logging = true;

% 4. Pause for 20 secs
pauseFor(20);

% 5. Stop Acquiring Data
m.Logging = false;

% 6. Retrieve Logged Data
% Magnetic Field data can be collected from X,Y,Z axes
[mf,tmf] = magfieldlog(m);
 
% Angular Velocity data can be collected from X,Y,Z axes
[av,tav] = angvellog(m);
 
% Azimuth, pitch, roll orientation data can be collected   
[o,to] = orientlog(m);

figure; hold on

plot(tmf, mf(:,1), tav, av(:,2), to, o(:,3))
legend('X Magnetic Field ','Y Angular Velocity','Roll');
xlabel('Relative time (s)');
hold off

%% Clean up
% Turn off the sensors and
% clear mobiledev.
m.MagneticSensorEnabled = 0;
m.AngularVelocitySensorEnabled = 0;
m.OrientationSensorEnabled = 0; 

clear m;