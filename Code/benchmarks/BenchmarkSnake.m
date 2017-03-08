clc
ALG = {@DE @PSO @EDA_UMDA @DEDA};
algorithms = 4;
algNames = {'DE' 'PSO' 'EDA_UMDA' 'DEDA'};

setNames = {'snake'};

objectiveValue = -inf;
individuals = 50;
generations = 10000;
lower = -1;
upper = 1;

v = ones(1,algorithms);

snakeDimension = [10, 10];


inputSize = 12;
hiddenSize = 8;
outputSize = 4;

layers = [inputSize,hiddenSize,outputSize];
dim = NeuralNetworkSize(layers)


tic
for alg=1:algorithms
    A = alg
    eval = @(x)ann_snake_fitness(x, snakeDimension, layers, false);
    [success, iterations, minimum, value] = ALG{alg}(eval, dim, lower, upper, generations, individuals, objectiveValue);
    v(alg) = value;
    m{alg} = minimum;
end
toc

table(v(1)', v(2)', v(3)', v(3)', 'RowNames', setNames, 'VariableNames', algNames)

%ann_snake_fitness(m{1}, snakeDimension, true);
