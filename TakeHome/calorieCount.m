function caloriesBurned = calorieCount(weight, height, steps)

% To input:
%  weight = 200;
%  height = 5+2/12;
%  steps = 1000;
% Used information from here: https://www.verywellfit.com/pedometer-steps-to-calories-converter-3882595

% Our values are in comparison with a person whose weight is 100lb
weightFactor = weight/100;

if (height >= 6)
    calorie1000 = 28;
elseif height < 6  && height >= 5.5
    calorie1000 = 25;
elseif height < 5.5
    calorie1000 = 23;
end

calorierPerSteps = calorie1000/1000;

% Equation: 

caloriesBurned = steps * weightFactor * calorierPerSteps;

