function [ success, iterations, minimum, value ] = EDA_FullGaus( CostFunction, dimension, lowerBound, upperBound, maxIterations, populationSize, objectiveValue )
    selectionThreshold = 0.5;
    scaleFactor = 2;
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
        
        m = mean(population2);
        c = cov(population2) * scaleFactor;
        size = populationSize-selectionCount;
        
        NG = mvnrnd(m, c, size);
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
        
        %disp(strcat(num2str(iterations),'=',num2str(value)));
        %track(iterations) = value;
        
    end
    
    %plot(graph_x, graph_y);
    
    success = false;
    if value <= objectiveValue
        success = true;
    end
    
    minimum = population(bestIndividualIndex,:);
    
end

