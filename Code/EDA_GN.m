function [ success, iterations, minimum, value ] = EDA_GN( CostFunction, dimension, lowerBound, upperBound, maxIterations, populationSize, objectiveValue )
    selectionThreshold = 0.5;
    selectionCount = floor(selectionThreshold * populationSize);
    population = lowerBound + (upperBound - lowerBound) * rand(populationSize, dimension);
    value = inf;
    bestIndividualIndex = -1;
    sort_list = zeros(populationSize);
    population2 = zeros(selectionCount, dimension);
    
    MaxParent = populationSize;
    
    size = populationSize-selectionCount;
    
    for i=1:dimension 
        nodetype{i} = 'gaussian';
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
        
        
        
        selPop = population2'+1;
        
        root = fix(rand*dimension)+1;
        dag = full(learn_struct_mwst(selPop,[],ones(dimension,1),nodetype,'bic',root));
        
        %root = fix(rand*dimension)+1;
        %order = randperm(dimension);
        %dag =  learn_struct_K2(selPop,ones(1,dimension),order,'type',nodetype,'max_fan_in',MaxParent,'discrete',[],'scoring_fn',scoring_fn,'params',[]); 

        %root = fix(rand*dimension)+1;
        %dag = full(learn_struct_mwst(selPop,[],ones(dimension,1),nodetype,'bic',root));
        %order = topological_sort(dag);
        %dag =  learn_struct_K2(selPop,ones(dimension,1),order,'type',nodetype,'max_fan_in',MaxParent,'discrete',[],'scoring_fn',scoring_fn,'params',[]);   
        
        
        bnet = mk_bnet(dag,ones(dimension,1),'discrete',[]);

        for i=1:dimension 
            bnet.CPD{i} = gaussian_CPD(bnet,i);
        end
        bnet = learn_params(bnet,selPop);
        
        
        
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

