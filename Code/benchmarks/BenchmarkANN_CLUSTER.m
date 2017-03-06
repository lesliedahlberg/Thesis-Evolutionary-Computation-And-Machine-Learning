clc
ALG = {@DE @PSO @EDA_UMDA };
algorithms = 3;
algNames = { 'DE' 'PSO' 'EDA_UMDA'};

[xxxx{1},tt{1}] = simplecluster_dataset;
setNames = {'simple'};

datasets = 1;

objectiveValue = 0;
individuals = 25;
generations = 100;
lower = -1;
upper = 1;

v = ones(datasets,algorithms);

for ds=1:datasets
    xx = xxxx{ds};
    t = tt{ds};

    inputSize = size(xx,1);
    hiddenSize = inputSize;
    outputSize = size(t,1);

    layers = [inputSize,hiddenSize,outputSize];
    dim = NeuralNetworkSize(layers)



    for alg=1:algorithms
        A = alg
        eval = @(x)ann_dataset_sse(x, layers, xx, t);
        [success, iterations, minimum, value] = ALG{alg}(eval, dim, lower, upper, generations, individuals, objectiveValue);
        v(ds,alg) = value;
    end
end

table(v(:,1), v(:,2), v(:,3), 'RowNames', setNames, 'VariableNames', algNames)
