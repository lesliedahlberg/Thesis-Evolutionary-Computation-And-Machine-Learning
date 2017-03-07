function [success, iterations, minimum, value] = DE(CostFunction, dimension, lowerBound, upperBound, maxIterations, populationSize, objectiveValue)
    
    %% Parameters
    F = 0.6;
    pCR=0.9;

    %% Setup
    success = false;
    dimensionSize = [1 dimension];
    emptyIndividualPosition = [];
    bestIndividualCost = inf;
    populationPosition = repmat(emptyIndividualPosition, populationSize, 1);
    populationCost = zeros(1,populationSize);
    bestCost = zeros(maxIterations,1);
    
    %% Pre-Evaluation & Initialization
    for i=1:populationSize
        populationPosition(i,:) = unifrnd(lowerBound, upperBound, dimensionSize);
        populationCost(i) = CostFunction(populationPosition(i,:));
        if populationCost(i) < bestIndividualCost
            bestIndividualCost = populationCost(i);
            bestIndividualPosition = populationPosition(i,:);
        end
    end
    
    %% Iteration
    for iterations=1:maxIterations

        %% Success
        if bestIndividualCost <= objectiveValue
            success = true;
            break;
        end

        %% Mutation
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

        %% Return values
        bestCost(iterations) = bestIndividualCost;
        minimum = bestIndividualPosition;
        value = bestIndividualCost;
    end
end

