function [ success, iterations, minimum, value ] = DEDA( CostFunction, dimension, lowerBound, upperBound, maxIterations, populationSize, objectiveValue )
    
    %% Parameters
    selectionThreshold = 0.5;
    F = 0.6;
    pCR=0.9; 

    %% Initialization
    selectionCount = floor(selectionThreshold * populationSize);
    population = lowerBound + (upperBound - lowerBound) * rand(populationSize, dimension);
    value = inf;
    bestIndividualIndex = -1;
    sort_list = zeros(populationSize);
    population2 = zeros(selectionCount, dimension);
    samplingSize = populationSize-selectionCount;
    
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

        %% Mutation
        for i=1:selectionCount
            x = population2(i,:);
            A = randperm(selectionCount);
            A(A==i)=[];
            a=A(1);
            b=A(2);
            c=A(3);
            y = population2(a,:) + F*(population2(b,:) - population2(c,:));
            %y = max(y, lowerBound);
            %y = min(y, upperBound);
            z = zeros(1, dimension);
            j0 = randi([1 numel(x)]);
            for j=1:numel(x)
                if j==j0 || rand <= pCR
                    z(j) = y(j);
                else
                    z(j) = x(j);
                end
            end
            if CostFunction(z) < CostFunction(population2(i,:))
                population2(i,:) = z;
            end
        end

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
        
        if lastBestValue ~= value
            disp(value);
            lastBestValue = value;
        end

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