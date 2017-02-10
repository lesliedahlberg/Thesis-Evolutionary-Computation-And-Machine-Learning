function [ success, iterations, minimum, value ] = QuantumSwarmOptimization( CostFunction, dimension, lowerBound, upperBound, maxIterations, populationSize, objectiveValue )
    vmax = (abs(upperBound)+abs(lowerBound))/2/100;
    omega = 0.8;
    c1 = 2;
    c2 = 2;
    plateau = 0;
    plateauCutoff = 25;
    mixtureCount = 2;
    
    selectionThreshold = 0.1;
    selectionCount = floor(selectionThreshold * populationSize);
    
    population2 = zeros(selectionCount, dimension);
    
    %Init population
    position = lowerBound + (upperBound - lowerBound) * rand(populationSize, dimension);
    best = position;
    bestValue = zeros(1,populationSize);
    for i=1:populationSize
        bestValue = CostFunction(best);
    end
    globalBest = best(1,:);
    globalBestValue = CostFunction(globalBest);
    velocity = -vmax + (vmax + vmax) * rand(populationSize, dimension);
    cost = inf(1,populationSize);
    
    iterations = 0;
    while (globalBestValue > objectiveValue) && (iterations < maxIterations)
        %track(iterations+1) = globalBestValue;
        %disp(plateau);
        plateau = plateau + 1;
        for i = 1:populationSize
            cost(i) = CostFunction(position(i,:));
            if cost(i) <= bestValue(i)
                best(i,:) = position(i,:);
                bestValue(i) = cost(i);
                if cost(i) <= globalBestValue
                    globalBest = best(i,:);
                    globalBestValue = bestValue(i);
                    plateau = 0;
                    %disp(globalBestValue);
                end
            end
        end
       
        
        %EDA
        if plateau > plateauCutoff
                [~, ids] = sort(cost);
                for j = 1:selectionCount
                    ii = ids(j);
                    population2(j,:) = position(ii,:);
                end
                warning('off','all')
                GM = fitgmdist(population2,mixtureCount,'RegularizationValue', 0.01);
                warning('on','all')
                sample = random(GM, populationSize-selectionCount);
                jj = 1;
                for j = selectionCount+1:populationSize
                    position(ids(j),:) = sample(jj,:);
                    jj = jj + 1;
                end
        end
                
        
        %Update
        for i = 1:populationSize
            f1 = rand(1,dimension);
            f2 = rand(1,dimension);
            
            
            
            velocity(i,:) = omega * velocity(i,:) + c1 * f1 .* (best(i,:) - position(i,:)) + c2 * f2 .* (globalBest - position(i,:));
            
            position(i,:) = position(i,:) + velocity(i,:);
        end
        
        iterations = iterations + 1;
        
    end
    
    if globalBestValue <= objectiveValue
        success = true;
    else
        success = false;
    end
    minimum = globalBest(1,:);
    value = globalBestValue;
    
    %plot(1:iterations, track)
    
end

