function [ success, iterations, minimum, value ] = NormalEvolution( CostFunction, dimension, lowerBound, upperBound, maxIterations, populationSize, objectiveValue )
    

    %EDA
    selectionThreshold = 0.5;
    scaleFactor = 2;
    selectionCount = floor(selectionThreshold * populationSize);
    sort_list = zeros(populationSize);
    population2 = zeros(selectionCount, dimension);
    %_EDA

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
        
        % EDA ====================
        for i = 1:populationSize
            sort_list(i) = CostFunction(population(i).Position);    
        end
        [~, ids] = sort(sort_list);
        for i = 1:selectionCount
            ii = ids(i);
            population2(i,:) = population(ii).Position;
        end
        
        sel_m = mean(population2);
        sel_c = cov(population2) * scaleFactor;
        %size = populationSize-selectionCount;
        
        %NG = mvnrnd(m, c, size);
        
        %population = [population2; NG];
        % _EDA =======================
        
        for i=1:populationSize
            x = population(i).Position;
            
            A = randperm(populationSize);
            A(A==i)=[];
            a=A(1);
            b=A(2);
            c=A(3);
            
            %y = population(a).Position + F*(population(b).Position - population(c).Position);
            %y = mvnrnd(sel_m, sel_c, 1) + F*(population(b).Position - population(c).Position);
            %y = mvnrnd(sel_m, sel_c, 1) + F*(mvnrnd(sel_m, sel_c, 1) - mvnrnd(sel_m, sel_c, 1));
            %y = mvnrnd(sel_m, sel_c, 1);
            %y_dif = population(a).Position + F*(population(b).Position - population(c).Position);
            %a = rand();
            %b = 1-a;
            %y = y*a + y_dif*b;
            
            y = mvnrnd(sel_m, sel_c, 1);
            if rand() > 0.5
                y = (y + population(a).Position + F*(population(b).Position - population(c).Position))/2;
            end
            
            
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

