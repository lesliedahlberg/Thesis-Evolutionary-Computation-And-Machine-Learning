[minSphere, iterSphere, foundSphere]             = DE(@Sphere, [-5.12, 5.12], 0.000001, 100, 1000, 3);
[minRosenbrock, iterRosenbrock, foundRosenbrock] = DE(@Rosenbrock, [-2.048, 2.048], 0.000001, 100, 1000, 2);
[minRastrigin, iterRastrigin, foundRastrigin]    = DE(@Rastrigin, [-5.12, 5.12], 0.000001, 100, 1000,2);
[minGriewank, iterGriewank, foundGriewank]       = DE(@Griewank, [-40, 40], 0.000001, 100, 10000, 10);
[minAckley, iterAckley, foundAckley]             = DE(@Ackley, [-5, 5], 0.000001, 100, 10000, 2);
[minShekel, iterShekel, foundShekel]             = DE(@ShekelsFoxholes, [-65.536, 65.536], 0.998005, 100, 10000, 2);

PlotSurfaceWithMin(@Sphere, [-5.12, 5.12], [0, 80], 100, [minSphere,Sphere(minSphere)]);
PlotSurfaceWithMin(@Rosenbrock, [-2.048, 2.048], [0, 2500], 100, [minRosenbrock,Rosenbrock(minRosenbrock)]);
PlotSurfaceWithMin(@Rastrigin, [-5.12, 5.12], [0, 80], 100, [minRastrigin,Rastrigin(minRastrigin)]);
PlotSurfaceWithMin(@Griewank, [-40, 40], [0, 2.5], 100, [minGriewank,Griewank(minGriewank)]);
PlotSurfaceWithMin(@Ackley, [-5, 5], [0, 20], 100, [minAckley,Ackley(minAckley)]);
PlotSurfaceWithMin(@ShekelsFoxholes, [-65.536, 65.536], [0, 600], 100, [minShekel,ShekelsFoxholes(minShekel)]);
