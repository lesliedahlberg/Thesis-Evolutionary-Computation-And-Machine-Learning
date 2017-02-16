clc
algorithms = 4;
functions = 10;
counts = 50;
dim = 2;

ALG = {@DifferentialEvolution @ParticleSwarmOptimization @EDA_UnivMargGaus @EDA_FullGaus @EDA_GN};

individualsPerDim = 50;
generationsPerDim = 1000;


data_mean = ones(functions,algorithms);
data_dev = ones(functions,algorithms);


for alg=1:algorithms
    disp(strcat('ALG: ',num2str(alg)));
    for func=1:functions
        disp(strcat('F: ',num2str(func)));
        [correct, upper, lower, objectiveValue, o, A, M, a, alpha, b] = loadFunctionInfo(func, dim);
        eval = @(x)calculateFitness(func, x, o, A, M, a, alpha, b);
        mins = zeros(1, counts);
        for count=1:counts
            disp('.');
            [success, iterations, minimum, value] = ALG{alg}(eval, dim, lower, upper, generationsPerDim*dim, individualsPerDim*dim, objectiveValue);
            mins(count) = value;
        end
        average = mean(mins);
        deviation = std(mins);
        data_mean(func,alg) = average;
        data_dev(func,alg) = deviation;
        
    end
end

m = table(data_mean(:,1), data_mean(:,2), data_mean(:,3), data_mean(:,4), 'RowNames', {'f1' 'f2' 'f3' 'f4' 'f5' 'f6' 'f7' 'f8' 'f9' 'f10'}, 'VariableNames', { 'DE' 'PSO' 'EDA_UMG' 'EDA_FG'})
d = table(data_dev(:,1), data_dev(:,2), data_dev(:,3), data_dev(:,4), 'RowNames', {'f1' 'f2' 'f3' 'f4' 'f5' 'f6' 'f7' 'f8' 'f9' 'f10'}, 'VariableNames', { 'DE' 'PSO' 'EDA_UMG' 'EDA_FG'})

writetable(m,strcat('mean_', num2str(dim), '.xlsx'));
writetable(d,strcat('dev_', num2str(dim), '.xlsx'));