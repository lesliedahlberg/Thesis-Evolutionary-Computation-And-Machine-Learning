
functions_count = 6;
dimension = 3;
max_iter = 1000;
individuals = 100;
functions = {@Sphere, @Rosenbrock, @Rastrigin, @Griewank, @Ackley, @ShekelsFoxholes};
function_names = {'Sphere' 'Rosenbrock' 'Rastrigin' 'Griewank' 'Ackley' 'ShekelsFoxholes'};
vtrs = [0.000001, 0.000001, 0.000001, 0.000001, 0.000001, 0.998005];
iprs = [-5.12, 5.12; -2.048, 2.048;-5.12, 5.12; -40, 40; -5, 5; -65.536, 65.536];

opt_functions = {@DE, @PSO, @EDA};
opt_names = {'DE' 'PSO' 'EDA'};
opt_count = 3;

for k=1:opt_count
    for i=1:functions_count
        tic
        [min, iter, found] = opt_functions{k}(functions{i}, iprs(i,:), vtrs(i), individuals, max_iter, dimension);
        time_(i,k) = toc;
        iter_(i,k) = iter;
        found_(i,k) = found;
        
    end
end

iter_(:,1)


table(iter_(:,1), iter_(:,2), iter_(:,3),  'VariableNames',opt_names, 'RowNames',function_names)
table(time_(:,1), time_(:,2), time_(:,3),  'VariableNames',opt_names, 'RowNames',function_names)
