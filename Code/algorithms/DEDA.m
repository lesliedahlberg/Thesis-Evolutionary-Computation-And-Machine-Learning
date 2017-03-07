function [ success, iterations, minimum, value ] = DEDA( CostFunction, dimension, lowerBound, upperBound, maxIterations, populationSize, objectiveValue )
    selectionThreshold = 0.5;
    selectionCount = floor(selectionThreshold * populationSize);
    population = lowerBound + (upperBound - lowerBound) * rand(populationSize, dimension);
    value = inf;
    bestIndividualIndex = -1;
    sort_list = zeros(populationSize);
    population2 = zeros(selectionCount, dimension);

    % DE_BEGIN

    F = 0.6;
    pCR=0.9; 

    % DE_END
    
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
        s = std(population2);
        size = populationSize-selectionCount;
        
        NG = normrnd(repmat(m,size,1),repmat(s,size,1));
        
        % DE_BEGIN

        for i=1:selectionCount
            x = population2(i,:);
            
            A = randperm(selectionCount);
            A(A==i)=[];
            a=A(1);
            b=A(2);
            c=A(3);
            
            y = population2(a,:) + F*(population2(b,:) - population2(c,:));
            
            y = max(y, lowerBound);
            y = min(y, upperBound);
            
            
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

        % DE_END



        population = [population2; NG];
        
        iterations = iterations + 1;
        
        for i = 1:populationSize
            cost = CostFunction(population(i,:));
            if cost < value
                bestIndividualIndex = i;
                value = cost;
            end
        end
        
    end
    
    
    success = false;
    if value <= objectiveValue
        success = true;
    end
    
    minimum = population(bestIndividualIndex,:);
    
end

