clc
fitfun = 8;
dimension = 2;
individuals = 100;
maxi = 1000*dimension;

[correct, upper, lower, objectiveValue, o, A, M, a, alpha, b] = loadFunctionInfo(fitfun, dimension);
eval = @(x)calculateFitness(fitfun, x, o, A, M, a, alpha, b);


disp('DE');
[success, iterations, minimum, value] = DifferentialEvolution(eval, dimension, lower, upper, maxi, individuals, objectiveValue);
%disp(success);
disp(iterations);
%disp(minimum);
disp(value);