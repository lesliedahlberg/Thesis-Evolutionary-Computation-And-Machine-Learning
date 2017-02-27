clc
algorithms = 3;
functions = 10;
counts = 1;
dim = 2;

f_names = {'f1' 'f2' 'f3' 'f4' 'f5' 'f6' 'f7' 'f8' 'f9' 'f10'};
a_names = { 'DE' 'PSO' 'EDA_FGDA' 'EDA_UMDA'  'QPSO'};

ALG = {@DE @PSO @EDA_FGDA @EDA_UMDA @QPSO};

individualsPerDim = 10;
generationsPerDim = 10;

data_mean = ones(functions,algorithms);
data_dev = ones(functions,algorithms);

for alg=1:algorithms
    disp(strcat('ALG: ',num2str(alg)));
    parfor func=1:functions
        disp(strcat('F: ',num2str(func)));
        [correct, upper, lower, objectiveValue, o, A, M, a, alpha, b] = loadFunctionInfo(func, dim);
        eval = @(x)calculateFitness(func, x, o, A, M, a, alpha, b);
        mins = zeros(1, counts);
        for count=1:counts
            disp('.');
            [success, iterations, minimum, value] = ALG{alg}(eval, dim, lower, upper, generationsPerDim, individualsPerDim, objectiveValue);
            mins(count) = value;
        end
        average = mean(mins);
        deviation = std(mins);
        data_mean(func,alg) = average;
        data_dev(func,alg) = deviation;
        
    end
end

m = table(data_mean(:,1), data_mean(:,2), data_mean(:,3), 'RowNames', f_names(1:functions), 'VariableNames', a_names(1:algorithms))
d = table(data_dev(:,1), data_dev(:,2), data_dev(:,3), 'RowNames',  f_names(1:functions), 'VariableNames', a_names(1:algorithms))

writetable(m,strcat('CEC_mean_dim', num2str(dim), '.xlsx'));
writetable(d,strcat('CEC_dev_dim', num2str(dim), '.xlsx'));