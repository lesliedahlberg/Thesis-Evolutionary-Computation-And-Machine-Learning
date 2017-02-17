function [ success, iterations, minimum, value ] = ALG_NE( CostFunction, dimension, lowerBound, upperBound, maxIterations, populationSize, objectiveValue )
    
    success = false;

    F = 1;
    pCR=0.5;        % Crossover Probability

    dimensionSize = [1 dimension];
    
    emptyIndividualPosition = [];
    bestIndividualCost = inf;
    
    populationPosition = repmat(emptyIndividualPosition, populationSize, 1);
    populationCost = zeros(1,populationSize);
    for i=1:populationSize
        populationPosition(i,:) = unifrnd(lowerBound, upperBound, dimensionSize);
        populationCost(i) = CostFunction(populationPosition(i,:));
        if populationCost(i) < bestIndividualCost
            bestIndividualCost = populationCost(i);
            bestIndividualPosition = populationPosition(i,:);
        end
    end
    
    bestCost = zeros(maxIterations,1);
    
    for iterations=1:maxIterations
        
        if bestIndividualCost <= objectiveValue
            success = true;
            break;
        end
        
        for i=1:populationSize
            x = populationPosition(i,:);
            
            A = randperm(populationSize);
            A(A==i)=[];
            a=A(1);
            b=A(2);
            c=A(3);
            
            y = populationPosition(a,:) + F*(populationPosition(b,:) - populationPosition(c,:));
            
            y = max(y, lowerBound);
            y = min(y, upperBound);
            
            z = zeros(size(x));
            j0 = randi([1 numel(x)]);
            for j=1:numel(x)
                if j==j0 || rand <= pCR
                    z(j) = y(j);
                else
                    z(j) = x(j);
                end
            end
            
            
            
            newSolutionPosition = z;
            newSolutionCost = CostFunction(newSolutionPosition);
            
            if newSolutionCost < populationCost(i)
                populationPosition(i,:) = newSolutionPosition;
                populationCost(i) = newSolutionCost;
                if populationCost(i) < bestIndividualCost
                   bestIndividualCost = populationCost(i);
                   bestIndividualPosition = populationPosition(i,:);
                end
            end
        end
        
        bestCost(iterations) = bestIndividualCost;
        minimum = bestIndividualPosition;
        value = bestIndividualCost;
        
        %disp(value);
        track(iterations) = value;
    end
    
    plot(1:maxIterations, track)
    
end

