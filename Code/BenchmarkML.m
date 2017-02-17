clc
ALG = {@EDA_FullGaus @ALG_DE @ParticleSwarmOptimization };
algorithms = 3;

[xx,t] = simplefit_dataset;

inputSize = size(xx,1);
hiddenSize = inputSize;
outputSize = size(t,1);

layers = [inputSize,hiddenSize,outputSize];
dim = NeuralNetworkSize(layers)

objectiveValue = 0;
individuals = 25;
generations = 250;
lower = -1;
upper = 1;

v = ones(1,algorithms);
for alg=1:algorithms
    
    eval = @(x)simpleFFNN(x, layers, xx, t);
    [success, iterations, minimum, value] = ALG{alg}(eval, dim, lower, upper, generations, individuals, objectiveValue);
    %disp(strcat('ALG:', num2str(alg), '->', num2str(value)));
    v(alg) = value;
    %output = NeuralNetwork(xx(:,1)', minimum, layers)
end

table(v')

%output_t = t(:,1)'