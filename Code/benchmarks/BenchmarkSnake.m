clc
rng(0);
ALG = {@DE @PSO @EDA_UMDA @DEDA};
algorithms = 4;
algNames = {'DE' 'PSO' 'EDA_UMDA' 'DEDA'};

setNames = {'snake'};

objectiveValue = -inf;
individuals = 140;
generations = 5000;
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
    disp(alg);
    
    parfor i=1:10
        disp('*');
       eval = @(x)ann_snake_fitness(x, snakeDimension, layers, false);
       [success, iterations, minimum, value] = ALG{alg}(eval, dim, lower, upper, generations, individuals, objectiveValue);
        v(i) = -value;
    end
    
    v(alg) = mean(v);
    s(alg) = std(v);
    %m{alg} = minimum;
end
toc

tv = table(v(1)', v(2)', v(3)', v(4)', 'RowNames', setNames, 'VariableNames', algNames)
ts = table(s(1)', s(2)', s(3)', s(4)', 'RowNames', setNames, 'VariableNames', algNames)

writetable(tv, 'snake_mean.xlsx');
writetable(ts, 'snake_dev.xlsx');
%ann_snake_fitness(m{1}, snakeDimension, layers, true);
