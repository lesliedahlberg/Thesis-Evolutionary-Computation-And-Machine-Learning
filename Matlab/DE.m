function [MIN,iter,found] = DE(Eval, IPR, vtr, n, maxi, d)
%DE Differential evolution minimization function
%   Eval is the objective function
%   IPR is the initial parameter range
%   vtr is value to reach
%   n is the number of individuals
%   i the max iteration count
%   d is the dimension of the problem

    X = ones(n, d);

    for i = 1:d
        F(i) = 1;
    end
    cr = 0.5;

    function R = random(a, b, N)
        R = a + (b - a) * rand(N, 1);
    end

    function R = uniqueRandom3(n, i)
        flag = true;
        R = [0,0,0];
        while flag || R(1) == R(2) || R(2) == R(3) || R(1) == R(3) || i == R(1) || i == R(2) || i == R(3)
            flag = false;
            R(1) = randi(n);
            R(2) = randi(n);
            R(3) = randi(n);
        end
    end

    for i = 1:n
        X(i,:) = random(IPR(1), IPR(2), d);
    end
    
    
    best = 1;
    iter = 0;
    
    while Eval(X(best,:)) > vtr && iter < maxi
       for i = 1:n
           I = uniqueRandom3(n, i);
           V = X(I(1),:) + F.*(X(I(2),:) - X(I(3),:));
           U = X(i,:);
           jrand = randi(d); 
           for j = 1:d
               if jrand == j || rand() <= cr
                   U(j) = V(j);
               end
           end
           if Eval(U) < Eval(X(i,:))
               X(i,:) = U;
           end
       end
       vbest = Eval(X(1,:));
       best = 1;
       for i = 1:n
           if Eval(X(i,:)) < vbest
               best = i;
           end
       end
       iter = iter + 1;
    end
    if Eval(X(best,:)) <= vtr
        found = true;
    else
        found = false
    end
    MIN = X(best,:);
    
end

