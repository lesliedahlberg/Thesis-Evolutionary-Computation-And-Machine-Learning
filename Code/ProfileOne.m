%%clc
dimension = 2;
individuals = 100;
maxi = 100*dimension;

margin = 0;
    
opt_functions = {@DifferentialEvolution @ParticleSwarmOptimization @EstimationOfGaussianMixtures, @QuantumSwarmOptimization};
opt_names = {'DE' 'PSO' 'EDA' 'QSO'};
opt_count = 4;

functions = 1;
func = 1;
function_names = {'f1' 'f2' 'f3' 'f4' 'f5' 'f6' 'f7' 'f8' 'f9' 'f10'};

i = zeros(1, opt_count);
time = zeros(1, opt_count);
found = zeros(1, opt_count);
valueA = zeros(1, opt_count);
target = zeros(1, opt_count);

for fitfun = func:func
    
    [correct, upper, lower, objectiveValue, o, A, M, a, alpha, b] = loadFunctionInfo(fitfun, dimension);
    eval = @(x)calculateFitness(fitfun, x, o, A, M, a, alpha, b);
    for opt=1:opt_count
        i(opt) = 0;
        founds = 0;
        tic
        [success, iterations, minimum, value] = opt_functions{opt}(eval, dimension, lower, upper, maxi, individuals, objectiveValue);
        i(opt) = iterations;
        time(opt) = toc;
        found(opt) = success;
        valueA(opt) = value;
        target(opt) = objectiveValue;
        
    end
end



%for t=1:opt_count
  %  disp(opt_names(t));
    table(transpose(i), transpose(time), transpose(found), transpose(valueA), transpose(target), 'VariableNames', { 'IT' 'TIME' 'SUCCESS' 'VALUE' 'TARGET'}, 'RowNames', {'DE' 'PSO' 'EDA' 'QSO'})
%end
%'VariableNames', { 'IT' 'TIME' 'SUCCESS' 'VALUE' 'TARGET'}
