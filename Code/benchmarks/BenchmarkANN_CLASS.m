clc
ALG = {@DE @PSO @EDA_FGDA };
algorithms = 3;
algNames = { 'DE' 'PSO' 'EDA_FGDA'};

[xxxx{1},tt{1}] = simpleclass_dataset;
[xxxx{2},tt{2}] = cancer_dataset;
[xxxx{3},tt{3}] = crab_dataset;
[xxxx{4},tt{4}] = glass_dataset;
[xxxx{5},tt{5}] = iris_dataset;
[xxxx{6},tt{6}] = thyroid_dataset;
[xxxx{7},tt{7}] = wine_dataset;
setNames = {'simple' 'cancer' 'crab' 'glass' 'iris' 'thyroid' 'wine' };

datasets = 7;

objectiveValue = 0;
individuals = 50;
generations = 50;
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






