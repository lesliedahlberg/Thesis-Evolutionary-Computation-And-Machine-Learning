function [ success, iterations, minimum, value ] = EDA_UMDA( CostFunction, dimension, lowerBound, upperBound, maxIterations, populationSize, objectiveValue )
    
    %% Parameters
    selectionThreshold = 0.5;

    %% Initialization
    selectionCount = floor(selectionThreshold * populationSize);
    samplingSize = populationSize-selectionCount;
    population = lowerBound + (upperBound - lowerBound) * rand(populationSize, dimension);
    
   
    
    value = inf;
    bestIndividualIndex = -1;
    sort_list = zeros(populationSize);
    population2 = zeros(selectionCount, dimension);
    
    lastBestValue = value;

    %% Iteration
    iterations = 0;
    while value > objectiveValue && iterations <= maxIterations

        %% Sorting & Evaluation
        for i = 1:populationSize
            sort_list(i) = CostFunction(population(i,:));    
        end
        [~, ids] = sort(sort_list);

        %% Selection
        for i = 1:selectionCount
            ii = ids(i);
            population2(i,:) = population(ii,:);
        end

        %% Model building
        m = mean(population2);
        s = std(population2);
        
        %% Sampling
        NG = normrnd(repmat(m,samplingSize,1),repmat(s,samplingSize,1));

        %% New generation
        population = [population2; NG];
        
        %% Evaluation
        for i = 1:populationSize
            cost = CostFunction(population(i,:));
            if cost < value
                bestIndividualIndex = i;
                value = cost;
            end
        end
        
%         if lastBestValue ~= value
%             disp(value);
%             lastBestValue = value;
%         end

        iterations = iterations + 1;
    end

    %% Success
    success = false;
    if value <= objectiveValue
        success = true;
    end

    %% Return
    minimum = population(bestIndividualIndex,:);
end