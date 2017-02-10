function [ success, iterations, minimum, value ] = EstimationOfDistribution( CostFunction, dimension, lowerBound, upperBound, maxIterations, populationSize, objectiveValue )
    
    selectionThreshold = 0.5;
    selectionCount = floor(selectionThreshold * populationSize);
    P = ones(populationSize, dimension);
    function R = random_vector(a, b, N)
        R = a + (b - a) * rand(N, 1);
    end
    for i = 1:populationSize
        P(i,:) = random_vector(lowerBound, upperBound, dimension);
    end
    
    iterations = 0;
    
    best_i = 1;
    best_v = CostFunction(P(best_i,:));
    for i = 1:populationSize
        v = CostFunction(P(i,:));
        if v < best_v
            best_i = i;
            best_v = v;
        end
    end
    
    while best_v > objectiveValue && iterations <= maxIterations
       
        
        sort_list = zeros(populationSize);
        for i = 1:populationSize
            sort_list(i) = CostFunction(P(i,:));
            [~, ids] = sort(sort_list);
        end
        PP = zeros(selectionCount, dimension);
        for i = 1:selectionCount
            ii = ids(i);
            PP(i,:) = P(ii,:);
        end
        cc = zeros(selectionCount, dimension);
        
        for i = 1:dimension
           
            cc(:,i) = PP(1:selectionCount,i);
            pd(i) = fitdist(cc(:,i), 'Normal');
        end
        for i = (selectionCount+1):populationSize
            for j = 1:dimension
               PP(i,j) = random(pd(j));
            end
        end
        P = PP;
    
        iterations = iterations + 1;
        
        best_i = 1;
        best_v = CostFunction(P(best_i,:));
        for i = 1:populationSize
            v = CostFunction(P(i,:));
            if v < best_v
                best_i = i;
                best_v = v;
            end
        end
        
    end
    
    success = false;
    if best_v <= objectiveValue
        success = true;
    end
    
    minimum = P(best_i,:);
    value = CostFunction(minimum);
end

