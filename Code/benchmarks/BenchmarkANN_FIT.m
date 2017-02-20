clc
ALG = {@DE @PSO @EDA_FGDA };
algorithms = 3;
algNames = { 'DE' 'PSO' 'EDA_FGDA'};

[xxxx{1},tt{1}] = simplefit_dataset;
[xxxx{2},tt{2}] = abalone_dataset;
[xxxx{3},tt{3}] = bodyfat_dataset;
[xxxx{4},tt{4}] = building_dataset;
[xxxx{5},tt{5}] = chemical_dataset;
[xxxx{6},tt{6}] = cho_dataset;
[xxxx{7},tt{7}] = engine_dataset;
[xxxx{8},tt{8}] = house_dataset;
setNames = {'simple' 'abalone' 'bodyfat' 'building' 'chemical' 'cho' 'engine' 'house'};

datasets = 8;

objectiveValue = 0;
individuals = 25;
generations = 1;
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






