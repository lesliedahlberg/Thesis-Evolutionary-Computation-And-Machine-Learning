function [ success, iterations, minimum, value ] = EstimationOfGaussianMixtures( CostFunction, dimension, lowerBound, upperBound, maxIterations, populationSize, objectiveValue )
    mixtureCount = 1;
    selectionThreshold = 0.5;
    selectionCount = floor(selectionThreshold * populationSize);
    population = lowerBound + (upperBound - lowerBound) * rand(populationSize, dimension);
    value = inf;
    bestIndividualIndex = -1;
    sort_list = zeros(populationSize);
    population2 = zeros(selectionCount, dimension);
        
    
    
    iterations = 0;
    while value > objectiveValue && iterations <= maxIterations
        for i = 1:populationSize
            sort_list(i) = CostFunction(population(i,:));    
        end
        [~, ids] = sort(sort_list);
        for i = 1:selectionCount
            ii = ids(i);
            population2(i,:) = population(ii,:);
        end
        
        warning('off','all')
        GM = fitgmdist(population2,mixtureCount, 'CovType', 'diagonal', 'Regularize', 1.4013e-40);
        warning('on','all')
        NG = random(GM, populationSize-selectionCount);
        population = [population2; NG];
        
        iterations = iterations + 1;
        
        for i = 1:populationSize
            cost = CostFunction(population(i,:));
            if cost < value
                bestIndividualIndex = i;
                value = cost;
            end
        end
        
        graph_x(iterations) = iterations;
        graph_y(iterations) = value;
        
    end
    
    %plot(graph_x, graph_y);
    
    success = false;
    if value <= objectiveValue
        success = true;
    end
    
    minimum = population(bestIndividualIndex,:);
    
end

