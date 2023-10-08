% This is the second half of Exercise 3
% as part of the Pocket AI and IoT workshop, 
% debuted at the Grace Hopper Celebration 2019, 
% and presented at the Society of Women Engineers WE19

% Clear all previously collected data and plots
clear m; clearvars -except teamID; close all; clc;

% Add the helper files to your path so that
% you can use them in this file. 
addpath(fullfile(pwd,'helperFiles'));
%addpath(fullfile(pwd,'TakeHome'));
% Check whether you have licenses for all 
% required products
checkProductLicenses();

%% Enter a team ID
teamID = input('Enter your team ID (1 to 5) and press Return','s');
if isempty(teamID)
    teamID = num2str(randi(5));
    disp(['Your team ID is ' teamID])
end

% Prompt the user for weight and height
weight = input('Enter your weight in pounds: ');
height = input('Enter your height in feet: ');

heightInInches = height * 12;

% Calculate BMI (Body Mass Index)
heightInMeters = heightInInches * 0.0254; % Convert height from inches to meters
weightInKg = weight * 0.453592; % Convert weight from pounds to kilograms
bmi = weightInKg / (heightInMeters^2);
% Display BMI
disp(['Your BMI (Body Mass Index): ' num2str(bmi)]);


% Prompt the user for their gender
gender = input('Enter your gender (M/F): ', 's');

% Calculate BMR (Basal Metabolic Rate)
% Use the Harris-Benedict equation (Revised Harris-Benedict Equation):
age = 30; % Default age
if strcmpi(gender, 'M')
    % For men:
    bmr = 88.362 + (13.397 * weightInKg) + (4.799 * heightInInches * 2.54) - (5.677 * age);
    if bmr < 1600
        disp('Regular Strength Training is recommended for males with BMR less than 1600.');
    elseif bmr > 1900
        disp('Burn more calories to sustain yourself throughout the day');
    elseif bmr >= 1600 && bmr <= 1900
        disp('You have standard BMR.');
    end
elseif strcmpi(gender, 'F')
    % For women:
    bmr = 447.593 + (9.247 * weightInKg) + (3.098 * heightInInches * 2.54) - (4.330 * age);
    if bmr < 1200
        disp('Regular Strength Training is recommended for males with BMR less than 1600.');
    elseif bmr > 2000
        disp('Burn more calories to sustain yourself throughout the day');
    elseif bmr >= 1200 && bmr <= 200
        disp('You have standard BMR.');
    end
else
    disp('Invalid gender input. Please enter "M" for male or "F" for female.');
    return; % Exit the program if the gender is not valid
end

% Display BMR
disp(['Your BMR (Basal Metabolic Rate): ' num2str(bmr)]);

Ex1_CountSteps
caloriesPerStep = 0.05;

% Calculate the total calories burned
totalCaloriesBurned = numSteps * caloriesPerStep;

% Display the total calories burned
disp(['Total Steps: ' num2str(numSteps)]);
disp(['Total Calories Burned: ' num2str(totalCaloriesBurned)]);

% Collect data and predict activity
%Ex1_CountSteps

% Send the number of steps to ThingSpeak
stepChallengeChannelID = 858241;
stepChallengeWriteAPIKey = '7Y2A9505MA6AT7OP';

dataWritten = false;
while ~dataWritten
    try
        thingSpeakWrite(stepChallengeChannelID,...
                        {teamID, numSteps},...
                        'WriteKey',stepChallengeWriteAPIKey);
        dataWritten = true;
    catch
        pauseFor(randi(10))
    end
end

% Read the total number of steps taken by everyone
% in the last 60 minutes
numMins = 60;
ThisData = thingSpeakRead(stepChallengeChannelID,...
    'Numminutes',numMins,...
    'OutputFormat','table');

% Plot the results of the step challenge
% aggregated for everyone in the room
if ~isempty(ThisData)
    [G, id] = findgroups(ThisData.UserData);
    totalSteps = splitapply(@sum, ThisData.Steps, G);
    
    bar(totalSteps);
    set(gca,'xticklabel',id);
    xtickangle(45)    
    title(sprintf('Twenty Second Step Count Challenge Winners\npast %d minutes', numMins));
    ylabel('# of Steps')

else
    figure
    text(0.5, 0.5, ...
         ['No data collected in the past ' num2str(numMins) ' minutes'],...
         'HorizontalAlignment', 'center')
end
