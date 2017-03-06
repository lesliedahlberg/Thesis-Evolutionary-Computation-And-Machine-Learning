clc

f_names = {'f1'  'f3'  'f5'  'f7'  'f9' };
a_names = { 'DE' 'PSO' 'EDA_UMDA' 'MY'};
functions = [1 3 5 7 9];
repeat = 1;
dimensions = [10];
algorithms = {@DE @PSO @EDA_UMDA @MY};
generations = [50];
populations = [50];

functionsSize = size(functions,2);
dimensionsSize = size(dimensions,2);
algorithmsSize = size(algorithms,2);

for d=1:dimensionsSize
    disp(strcat('d=',num2str(d)));
    data_mean = ones(functionsSize,algorithmsSize);
    data_dev = ones(functionsSize,algorithmsSize);
    for a=1:algorithmsSize
        fprintf(strcat('\ta=',num2str(a),'\n'));
        for f=1:functionsSize
            fprintf(strcat('\t\tf=',num2str(f)));
            [correct, upper, lower, objectiveValue, o, A, M, aa, alpha, b] = loadFunctionInfo(functions(f), dimensions(d));
            eval = @(x)calculateFitness(functions(f), x, o, A, M, aa, alpha, b);
            mins = zeros(1, repeat);
            for r=1:repeat
                fprintf('*');
                [success, iterations, minimum, value] = algorithms{a}(eval, dimensions(d), lower, upper, generations(d), populations(d), objectiveValue);
                mins(r) = value;
            end
            data_mean(f,a) = mean(mins);
            data_dev(f,a) = std(mins);
        end
    end
    tm = table(data_mean(:,1), data_mean(:,2), data_mean(:,3), data_mean(:,4), 'RowNames', f_names(1:functionsSize), 'VariableNames', a_names(1:algorithmsSize))
    td = table(data_dev(:,1), data_dev(:,2), data_dev(:,3), data_dev(:,4), 'RowNames',  f_names(1:functionsSize), 'VariableNames', a_names(1:algorithmsSize))


    %writetable(tm,strcat('math_mean_dim', num2str(dimensions(d)), '.xlsx'));
    %writetable(td,strcat('math_dev_dim', num2str(dimensions(d)), '.xlsx'));
end
