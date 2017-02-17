function [ success, iterations, minimum, value ] = QPSO( CostFunction, dimension, lowerBound, upperBound, maxIterations, populationSize, objectiveValue )
    vmax = (abs(upperBound)+abs(lowerBound))/2;
    omega = 0.8;
    c1 = 1;
    c2 = 1;
    
   
    
    %Init population
    position = lowerBound + (upperBound - lowerBound) * rand(populationSize, dimension);
    best = position;
    bestValue = zeros(1,populationSize);
    for i=1:populationSize
        bestValue(i) = CostFunction(best(i,:));
    end
    globalBest = best(1,:);
    globalBestValue = CostFunction(globalBest);
    velocity = -vmax + (vmax + vmax) * rand(populationSize, dimension);
    
    
    iterations = 0;
    while (globalBestValue > objectiveValue) && (iterations < maxIterations)
        
        %EDA
        selectionCount = populationSize/4;
        [~, ids] = sort(bestValue);
        for i = 1:selectionCount
            ii = ids(i);
            selPos(i,:) = position(ii,:);
            selVel(i,:) = velocity(ii,:);
        end
        
        mp = mean(selPos);
        %cp = cov(selPos) * 2;
        cp = std(selPos);
        
        mv = mean(selVel);
        %cv = cov(selVel) * 2;
        cv = std(selVel);
        
        ids = flip(ids);
        for i = 1:selectionCount
            ii = ids(i);
            %if rand() > 0.5 && mod(iterations,4) == 0
                %p = mvnrnd(mp, cp, 1);
                %v = mvnrnd(mv, cv, 1);
                p = normrnd(mp, cp);
                v = normrnd(mv, cv);
                position(ii,:) = p;
                velocity(ii,:) = v;
            %end
        end
        
        for i = 1:populationSize
            cost(i) = CostFunction(position(i,:));
        end
        
        
        %DE
        for i = 1:populationSize
            x = position(i,:);

            A = randperm(populationSize);
            A(A==i)=[];
            a=A(1);
            b=A(2);
            c=A(3);

            F = 1;
            pCR=0.5;        % Crossover Probability

            y = position(a,:) + F*(position(b,:) - position(c,:));

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

            if newSolutionCost < cost(i)
                position(i,:) = newSolutionPosition;
                cost(i) = newSolutionCost;
            end
        end
        %PSO
        %track(iterations+1) = globalBestValue;
        for i = 1:populationSize
            
            %cost = CostFunction(position(i,:));
            
            
            if cost(i) <= bestValue(i)
                best(i,:) = position(i,:);
                bestValue(i) = cost(i);
                if cost(i) <= globalBestValue
                    globalBest = best(i,:);
                    globalBestValue = bestValue(i);
                    %disp(globalBestValue);
                end
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
        %disp(globalBestValue);
        %track(iterations) = globalBestValue;
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

