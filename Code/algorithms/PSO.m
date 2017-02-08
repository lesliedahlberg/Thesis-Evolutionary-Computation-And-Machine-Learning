function [MIN,iter,found] = PSO(Eval, IPR, vtr, n, maxi, d)
%PSO Particle swarm minimization function
%   Eval is the objective function
%   IPR is the initial parameter range
%   vtr is value to reach
%   n is the number of individuals
%   i the max iteration count
%   d is the dimension of the problem

    vmax = (abs(IPR(2))+abs(IPR(1)))/2/100;
    omega = 0.8;
    c1 = 2;
    c2 = 2;
    
    function R = random(a, b, N)
        R = a + (b - a) * rand(N, 1);
    end
    
    position = zeros(n, d);
    velocity = zeros(n, d);
    best = zeros(n, d);
    globalBest = zeros(n, d);
    
    for i = 1:n
        position(i,:) = random(IPR(1),IPR(2),d);
        best(i,:) = position(i,:);
        globalBest(i,:) = best(i,:);
    end
    
    for i = 1:n
        velocity(i,:) = random(-vmax,vmax,d);
    end
    
    iter = 0;
    while Eval(globalBest(1,:)) > vtr && iter < maxi
        gBest = globalBest(1,:);
        for i = 1:n
            f_x = Eval(position(i,:));
            if f_x <= Eval(best(i,:))
                best(i,:) = position(i,:);
            end
            if f_x <= Eval(gBest)
                gBest = position(i,:);
            end
        end
        for i = 1:n
            globalBest(i,:) = gBest;
        end
        
        for i = 1:n
            for j = 1:d
                f1 = rand();
                f2 = rand();
                velocity(i,j) = omega * velocity(i,j) + c1 * f1 * (best(i,j) - position(i,j)) + c2 * f2 * (globalBest(i,j) - position(i,j));
                position(i,j) = position(i,j) + velocity(i,j);
            end
        end
        iter = iter + 1;
    end
    
    if Eval(globalBest(1,:)) <= vtr
        found = true;
    else
        found = false
    end
    MIN = globalBest(1,:);
    
    
    
    
end

