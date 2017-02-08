function [MIN,iter,found] = EDA_2(Eval, IPR, vtr, n, maxi, d)
%EDA Estimation of distribution minimization function
%   Eval is the objective function
%   IPR is the initial parameter range
%   vtr is value to reach
%   n is the number of individuals
%   i the max iteration count
%   d is the dimension of the problem

    t = 0.5;
    select_count = t * n;
    P = ones(n, d);
    function R = random_vector(a, b, N)
        R = a + (b - a) * rand(N, 1);
    end
    for i = 1:n
        P(i,:) = random_vector(IPR(1), IPR(2), d);
    end
    
    iter = 0;
    
    best_i = 1;
    best_v = Eval(P(best_i,:));
    for i = 1:n
        v = Eval(P(i,:));
        if v < best_v
            best_i = i;
            best_v = v;
        end
    end
    
    while best_v > vtr && iter <= maxi
        
        

        for i = 1:n
            sort_list(i) = Eval(P(i,:));
            [sorted_evals, ids] = sort(sort_list);
        end
        for i = 1:select_count
            ii = ids(i);
            PP(i,:) = P(ii,:);
        end
        for i = 1:d
            cc(:,i) = PP(1:select_count,i);
            pd(i) = fitdist(cc(:,i), 'Normal');
        end
        for i = (select_count+1):n
            for j = 1:d
               PP(i,j) = random(pd(j));
            end
        end
        P = PP;
    
        iter = iter + 1;
        
        best_i = 1;
        best_v = Eval(P(best_i,:));
        for i = 1:n
            v = Eval(P(i,:));
            if v < best_v
                best_i = i;
                best_v = v;
            end
        end
        
    end
    
    found = false;
    if best_v <= vtr
        found = true;
    end
    
    MIN = P(best_i,:);
    
end

