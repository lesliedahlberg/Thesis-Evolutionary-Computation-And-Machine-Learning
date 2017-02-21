function fit = ann_snake_fitness(weights, dimension, layers, verbose)
    for i=1:2
        fitness(i) = SnakeTest(weights, dimension, layers, verbose);
    end
    f = mean(fitness);
    fit = -f;
end
