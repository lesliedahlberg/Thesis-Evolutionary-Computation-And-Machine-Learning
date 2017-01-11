%PlotSurface(@Sphere, [-5.12, 5.12], [0, 80], 100);
%PlotSurface(@Rosenbrock, [-2.048, 2.048], [0, 2500], 100);
%PlotSurface(@Rastrigin, [-5.12, 5.12], [0, 80], 100);
%PlotSurface(@Griewank, [-40, 40], [0, 2.5], 100);
%PlotSurface(@Ackley, [-5, 5], [0, 20], 100);
%PlotSurface(@ShekelsFoxholes, [-65.536, 65.536], [0, 600], 100);

%DE(Eval, IPR, vtr, n, maxi, d)
%[min, iter, found] = DE(@Sphere, [-5.12, 5.12], 0.000001, 100, 1000, 3)
%[min, iter, found] = DE(@Rosenbrock, [-2.048, 2.048], 0.000001, 100, 1000, 2)
%[min, iter, found] = DE(@Rastrigin, [-5.12, 5.12], 0.000001, 100, 1000, 2)
%[min, iter, found] = DE(@Griewank, [-40, 40], 0.000001, 100, 10000, 10)
%[min, iter, found] = DE(@Ackley, [-5, 5], 0.000001, 100, 10000, 2)
[min, iter, found] = DE(@ShekelsFoxholes, [-65.536, 65.536], 0.998005, 100, 10000, 2)


