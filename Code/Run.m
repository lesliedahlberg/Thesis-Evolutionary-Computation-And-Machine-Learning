clc

dimension = 2;
individuals = 25;
maxi = 10000*dimension;

opt_functions = {@DE, @PSO, @EDA};
opt_names = {'DE' 'PSO' 'EDA'};
opt_count = 3;

functions = 10;
function_names = {'f1' 'f2' 'f3' 'f4' 'f5' 'f6' 'f7' 'f8' 'f9' 'f10'};

reps = 2;

i = zeros(functions, opt_count);

for fitfun = 1:functions
    disp(strcat('Function:', function_names(fitfun), ' start'));
    [correct, upper, lower, objectiveValue, o, A, M, a, alpha, b] = loadFunctionInfo(fitfun, dimension);
    eval = @(x)calculateFitness(fitfun, x, o, A, M, a, alpha, b);
    
    for opt=1:opt_count
        disp(strcat('Method:', opt_names(opt),' start'));
        i(fitfun,opt) = 0;
        founds = 0;
        for run = 1:reps
            [min,iter,found] = opt_functions{opt}(eval, [lower, upper], objectiveValue, individuals, maxi, dimension);
            i(fitfun,opt) = i(fitfun,opt) + iter;
            founds = founds + found;
            disp('*');
        end
        if founds == reps
            i(fitfun,opt) = i(fitfun,opt) / reps;
        else
            i(fitfun,opt) = -1;
        end
        
        disp(strcat('Method:', opt_names(opt),' end'));
    end
   disp(strcat('Function:', function_names(fitfun), ' end'));
end
table(i(:,1), i(:,2), i(:,3), 'VariableNames', opt_names(1:opt_count), 'RowNames', function_names(1:functions))

