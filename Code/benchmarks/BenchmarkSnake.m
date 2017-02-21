clc
ALG = {@PSO @DE @EDA_FGDA };
algorithms = 3;
algNames = { 'PSO' 'DE'  'EDA_FGDA'};

setNames = {'snake'};

objectiveValue = -inf;
individuals = 50;
generations = 500;
lower = -1;
upper = 1;

v = ones(1,algorithms);

snakeDimension = [10, 10];


inputSize = 9;
hiddenSize = 14;
outputSize = 4;

layers = [inputSize,hiddenSize,outputSize];
dim = NeuralNetworkSize(layers)



for alg=1:algorithms
    A = alg
    eval = @(x)ann_snake_fitness(x, snakeDimension, false);
    [success, iterations, minimum, value] = ALG{alg}(eval, dim, lower, upper, generations, individuals, objectiveValue);
    v(alg) = value;
    m{alg} = minimum;
end


table(v(1)', v(2)', v(3)', 'RowNames', setNames, 'VariableNames', algNames)

%ann_snake_fitness(m{1}, snakeDimension, true);




