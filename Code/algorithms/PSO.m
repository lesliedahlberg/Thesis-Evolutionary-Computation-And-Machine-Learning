function [ success, iterations, minimum, value ] = PSO( CostFunction, dimension, lowerBound, upperBound, maxIterations, populationSize, objectiveValue )
    
    
    %% Parameters
    vmax = (abs(upperBound)+abs(lowerBound));
    omega = 0.8;
    c1 = 1.494;
    c2 = c1;

    %% Initialization
    position = lowerBound + (upperBound - lowerBound) * rand(populationSize, dimension);
    velocity = -vmax + (vmax + vmax) * rand(populationSize, dimension);
    best = position;
    bestValue = zeros(1,populationSize);
    globalBest = best(1,:);
    globalBestValue = CostFunction(globalBest);
    lastBestValue = globalBestValue;

    %% Pre-Evaluation
    for i=1:populationSize
        bestValue(i) = CostFunction(best(i,:));
    end

    %% Iteration
    iterations = 0;
    while (globalBestValue > objectiveValue) && (iterations < maxIterations)
        
        %% Evaluation
        for i = 1:populationSize
            cost = CostFunction(position(i,:));
            if cost <= bestValue(i)
                best(i,:) = position(i,:);
                bestValue(i) = cost;
                if cost <= globalBestValue
                    globalBest = best(i,:);
                    globalBestValue = bestValue(i);
                end
            end
        end
        
        %% Update
        for i = 1:populationSize
            f1 = rand(1,dimension);
            f2 = rand(1,dimension);
            velocity(i,:) = omega * velocity(i,:) + c1 * f1 .* (best(i,:) - position(i,:)) + c2 * f2 .* (globalBest - position(i,:));
            position(i,:) = position(i,:) + velocity(i,:);
        end
        
        iterations = iterations + 1;
        if lastBestValue ~= globalBestValue
            disp(globalBestValue);
            lastBestValue = globalBestValue;
        end
        
    end

    %% Success
    if globalBestValue <= objectiveValue
        success = true;
    else
        success = false;
    end

    %% Return
    minimum = globalBest(1,:);
    value = globalBestValue;
end