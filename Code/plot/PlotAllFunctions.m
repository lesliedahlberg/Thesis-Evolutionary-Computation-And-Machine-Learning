
OPR(1,:) = [-10000, 50000];
OPR(2,:) = [-20, 80000];
OPR(3,:) = [0, 4] * 10.^10;
OPR(4,:) = [0, 25000];
OPR(5,:) = [-10000, 40000];
OPR(6,:) = [0, 4000];
OPR(7,:) = [0 40];
OPR(8,:) = [-135+140, -115+140];
OPR(9,:) = [-350+330, -200+330];
OPR(10,:) = [-40+3300, 100+330];

%for fitfun = 1:10
fitfun = 10;

    [correct, upper, lower, objectiveValue, o, A, M, a, alpha, b] = loadFunctionInfo(fitfun, dimension);
    eval = @(x)calculateFitness(fitfun, x, o, A, M, a, alpha, b);
    PlotSurfaceD(eval, [lower, upper], [lower, upper], OPR(fitfun,:), 500);

%end