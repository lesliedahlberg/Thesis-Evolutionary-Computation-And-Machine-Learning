clc
algorithms = 10;
functions = 5;
counts = 5;
dim = 10;

f_names = {'f1' 'f2' 'f3' 'f4' 'f5' 'f6' 'f7' 'f8' 'f9' 'f10'};
a_names = { 'DE' 'PSO' 'EDA_UMG' 'EDA_FG' 'QPSO'};

ALG = {@ALG_DE @ParticleSwarmOptimization @EDA_UnivMargGaus @EDA_FullGaus @QPSO};

individualsPerDim = 25;
generationsPerDim = 25;


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



m = table(data_mean(:,1), data_mean(:,2), data_mean(:,3), data_mean(:,4), data_mean(:,5), 'RowNames', f_names(1:functions), 'VariableNames', a_names(1:algorithms))
%d = table(data_dev(:,1), data_dev(:,2), data_dev(:,3), data_dev(:,4), data_dev(:,5), 'RowNames',  f_names(1:functions), 'VariableNames', a_names(1:algorithms))

writetable(m,strcat('mean_', num2str(dim), '.xlsx'));
writetable(d,strcat('dev_', num2str(dim), '.xlsx'));