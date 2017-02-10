function [ success, iterations, minimum, value ] = DifferentialEvolution( CostFunction, dimension, lowerBound, upperBound, maxIterations, populationSize, objectiveValue )
    
    success = false;

    F = 1;
    pCR=0.5;        % Crossover Probability

    dimensionSize = [1 dimension];
    
    emptyIndividual.Position = [];
    emptyIndividual.Cost = [];
    bestIndividual.Cost = inf;
    
    population = repmat(emptyIndividual, populationSize, 1);
    for i=1:populationSize
        population(i).Position = unifrnd(lowerBound, upperBound, dimensionSize);
        population(i).Cost = CostFunction(population(i).Position);
        if population(i).Cost < bestIndividual.Cost
            bestIndividual = population(i);
            
        end
    end
    
    bestCost = zeros(maxIterations,1);
    
    for iterations=1:maxIterations
        
        if bestIndividual.Cost <= objectiveValue
            success = true;
            break;
        end
        %disp(bestIndividual.Cost)
        
        for i=1:populationSize
            x = population(i).Position;
            
            A = randperm(populationSize);
            A(A==i)=[];
            a=A(1);
            b=A(2);
            c=A(3);
            
            y = population(a).Position + F*(population(b).Position - population(c).Position);
            
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
            
            newSolution.Position = z;
            newSolution.Cost = CostFunction(newSolution.Position);
            
            if newSolution.Cost < population(i).Cost
                population(i) = newSolution;
                if population(i).Cost < bestIndividual.Cost
                   bestIndividual = population(i);
                end
            end
        end
        
        
        
        bestCost(iterations) = bestIndividual.Cost;
        minimum = bestIndividual.Position;
        value = bestIndividual.Cost;
    end
    
    
    
end

