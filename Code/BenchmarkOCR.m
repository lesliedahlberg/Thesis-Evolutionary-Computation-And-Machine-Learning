clc
ALG = {@ALG_DE @ParticleSwarmOptimization @EDA_FullGaus };
algorithms = 4;

%[xx,t] = crab_dataset;
[imgs, labels] = readMNIST('train-images', 'train-labels', 100, 0);
%input = reshape(train_input(:,:,i), [1 400]);
for i=1:100
    input(i,:) = reshape(imgs(:,:,i), [1 400]);
end


%output = zeros(1, 10);
%digit = train_output(i);
%output(digit+1) = 1;

for i=1:100
    output(1,:) = zeros(1, 10);
    digit = labels(i);
    output(1,digit+1) = 1;
end

        
xx = input;
t = output;

inputSize = size(xx,2);
hiddenSize = inputSize/10;
outputSize = size(t,2);

layers = [inputSize,hiddenSize,outputSize];
dim = NeuralNetworkSize(layers)

objectiveValue = 0;
individuals = 25;
generations = 10;
lower = -1;
upper = 1;

v = ones(1,algorithms);
for alg=1:algorithms
    A = alg
    eval = @(x)ocrFFNN(x, layers, xx, t);
    [success, iterations, minimum, value] = ALG{alg}(eval, dim, lower, upper, generations, individuals, objectiveValue);
    %disp(strcat('ALG:', num2str(alg), '->', num2str(value)));
    v(alg) = value;
    %output = NeuralNetwork(xx(:,1)', minimum, layers)
end

table(v')

%output_t = t(:,1)'