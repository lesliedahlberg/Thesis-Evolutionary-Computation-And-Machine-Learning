[DE_minSphere, DE_iterSphere, DE_foundSphere] = DE(@Sphere, [-5.12, 5.12], 0.000001, 100, 1000, 3);
[PSO_minSphere, PSO_iterSphere, PSO_foundSphere] = PSO(@Sphere, [-5.12, 5.12], 0.000001, 100, 1000, 3);

success = DE_foundSphere && PSO_foundSphere

DE_iterSphere
PSO_iterSphere

DE_minSphere
PSO_minSphere