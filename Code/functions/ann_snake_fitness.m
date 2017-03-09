function fit = ann_snake_fitness(weights, dimension, layers, verbose)
    for i=1:5
        fitness(i) = SnakeTest(weights, dimension, layers, verbose, 0);
    end
    f = mean(fitness);
    fit = -f;

    
    
end

