clc
clear

%% Import Data
[class,age,sex,survival] = importfile('assignment 4 titanic.dat',9, 2209);
validationTestCount = 700;
data = [class,age,sex,survival];
trainingData = data(1:end-validationTestCount,:);
validationData = data(end-validationTestCount+1:end,:);

%% Configure ANN
inputSize = 3;
hiddenSize = 6;
outputSize = 1;
layers = [inputSize,hiddenSize,outputSize];

%% Run Backpropagation
learningRate = 0.05;
threshold = 0.0199;

inputs = trainingData(:,1:3);
outputs = trainingData(:,4);

[weights] = Backpropagation(inputs, outputs, layers, learningRate, threshold);

%% Validation

v_inputs = validationData(:,1:3);
v_outputs = validationData(:,4);

shouldSurviveCount = 0;
survivedCount = 0;
survivedCorrectCount = 0;
correctCount = 0;
diedCorrectCount = 0;

for i=1:validationTestCount
    [output, ~] = NeuralNetwork(v_inputs(i,:), weights, layers);
    shouldSurvive = v_outputs(i,:) == 1;
    survived = output{1} >= 0.5;
    
    if shouldSurvive == true
        shouldSurviveCount = shouldSurviveCount + 1;
    end
    if survived == true
        survivedCount = survivedCount + 1;
    end
    if shouldSurvive == survived
        correctCount = correctCount + 1;
    end
    if shouldSurvive == true && survived == true
        survivedCorrectCount = survivedCorrectCount + 1;
    end
     if shouldSurvive == false && survived == false
        diedCorrectCount = diedCorrectCount + 1;
    end
end

%% Results
survivedCorrectCount
diedCorrectCount
survivedProcent = survivedCorrectCount/shouldSurviveCount
diedProcent = diedCorrectCount/(validationTestCount-shouldSurviveCount)
