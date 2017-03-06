function [ success, iterations, minimum, value ] = EDA_BN( CostFunction, dimension, lowerBound, upperBound, maxIterations, populationSize, objectiveValue )
    selectionThreshold = 0.5;
    selectionCount = floor(selectionThreshold * populationSize);
    population = lowerBound + (upperBound - lowerBound) * rand(populationSize, dimension);
    value = inf;
    bestIndividualIndex = -1;
    sort_list = zeros(populationSize);
    population2 = zeros(selectionCount, dimension);
    
    MaxParent = populationSize;
    alpha = 0.05;
    type_indeptest = {'pearson', 'LRT'};
    size = populationSize-selectionCount;
    
    for i=1:dimension 
        nodetype{1,i} = 'tabular';
    end
    
    NG = zeros(size,dimension);
        
    
    scoring_fn = 'bic';
    
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
        
        Card = ones(1,dimension) * size;
        
        selPop = population2'+1;
        
        % MWST based tree algorithm
        root = fix(rand*dimension)+1;
        dag = full(learn_struct_mwst(selPop,[],ones(1,dimension),nodetype,'mutual_info',root));
        
        
        init_bnet = mk_bnet(dag,Card);
        % All nodes are set to be discrete
        for i=1:dimension 
         init_bnet.CPD{i} = tabular_CPD(init_bnet,i);
        end,

        bnet = learn_params(init_bnet,selPop);
        
        
        
        for i=1:size
            NG(i,:) = cell2num(sample_bnet(bnet))-1;
        end
        
        population = [population2; NG];
        
        iterations = iterations + 1;
        
        for i = 1:populationSize
            cost = CostFunction(population(i,:));
            if cost < value
                bestIndividualIndex = i;
                value = cost;
            end
        end
        
        graph_x(iterations) = iterations;
        graph_y(iterations) = value;
        
    end
    
    %plot(graph_x, graph_y);
    
    success = false;
    if value <= objectiveValue
        success = true;
    end
    
    minimum = population(bestIndividualIndex,:);
    
end

