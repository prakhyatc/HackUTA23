function [X,Y, dataMin, dataRange] = getTrainingData()

% Load the training data

load('trainingData.mat');

% Step 2: Normalize training data

data = [featureWalk; featureRun;
        featureIdle];
dataMin = min(data);
dataMax = max(data);
dataRange = dataMax - dataMin;

data = (data - dataMin) ./ dataRange;

% Assign each activity to an index
indexIdle =  0;
indexWalk =  2;
indexRun  =  3;

% Make vectors of each activity index.
% The number of elements is the number
% of observations of the activity in the
% training data
Idle = indexIdle * zeros(length(featureIdle),1);
Walk = indexWalk * ones(length(featureWalk),1);
Run  = indexRun  * ones(length(featureRun),1);

% Step 3: Train the machine learning model

X = data;
Y = [Walk;Run;Idle];

end
