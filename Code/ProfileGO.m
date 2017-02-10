clc
dimension = 2;
individuals = 100;
maxi = 100*dimension;

margin = 0;

opt_functions = {@ParticleSwarmOptimization, @QuantumSwarm};
opt_names = {'PSO' 'QS'};
opt_count = 2;

functions = 1;
function_names = {'f1' 'f2' 'f3' 'f4' 'f5' 'f6' 'f7' 'f8' 'f9' 'f10'};

i = zeros(functions, opt_count);
time = zeros(functions, opt_count);
found = zeros(functions, opt_count);
valueA = zeros(functions, opt_count);
target = zeros(functions, opt_count);

for fitfun = 1:functions
    
    [correct, upper, lower, objectiveValue, o, A, M, a, alpha, b] = loadFunctionInfo(fitfun, dimension);
    eval = @(x)calculateFitness(fitfun, x, o, A, M, a, alpha, b);
    for opt=1:opt_count
        i(fitfun,opt) = 0;
        founds = 0;
        tic
        [success, iterations, minimum, value] = opt_functions{opt}(eval, dimension, lower, upper, maxi, individuals, objectiveValue);
        i(fitfun,opt) = iterations;
        time(fitfun,opt) = toc;
        found(fitfun,opt) = success;
        valueA(fitfun,opt) = value;
        target(fitfun,opt) = objectiveValue;
        
    end
end

for t=1:opt_count
    disp(opt_names(t));
    table(i(:,t), time(:,t), found(:,t), valueA(:,t), target(:,t), 'VariableNames', { 'IT' 'TIME' 'SUCCESS' 'VALUE' 'TARGET'}, 'RowNames', function_names(1:functions))
end

