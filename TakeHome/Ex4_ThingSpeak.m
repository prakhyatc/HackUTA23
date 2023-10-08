%This is take home Exercise 4 as part of the Pocket AI and IoT workshop 
% debuted at the Grace Hopper Celebration 2019, 
% and presented at the Society of Women Engineers WE19

% In this exercise, create your own channel in ThingSpeak, write 1 to 10 to
% it and display the data 

% Steps to be performed in this exercise:
% 1. Go to ThingSpeak website and create an account. Link: https://thingspeak.com/  
% 2. Create a channel
% 3. Identify your channel's id from the Channel Settings tab
% 4. Identify your channel's write and read API keys from the API Keys tab
% 5. Write 1 to 10 to your channel
% 6. Read the data written to your channel
% 7. Visualize the data using a 2-D line plot

% Hint: https://www.mathworks.com/help/thingspeak/index.html

%% TODO - Replace the [] with channel ID to read data from step 3:
channelID = 2295662;

%% TODO - Enter Channel Write API Key between the '' below: 
writeAPIKey = 'MRBDPC5X5J0G0XI1';

%% Write 1 to 10 
for iLoop = 1:10
    
    thingSpeakWrite(channelID,'Value',iLoop,'WriteKey',writeAPIKey)
    pause(15);
end

%% TODO - Replace the [] with the Field ID to read data from:
fieldID1 =1;

%% TODO - Enter Channel Read API Key between the '' below: 
readAPIKey = 'Z4AIA0PHG5RZV0UJ';

%% Read Data 
[data, time] = thingSpeakRead(channelID, 'Field', fieldID1, 'NumPoints', 10, 'ReadKey', readAPIKey);

%% Visualize Data 
thingSpeakPlot(time, data);