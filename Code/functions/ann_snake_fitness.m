function fit = ann_snake_fitness(weights, dimension, verbose)
    fitness = SnakeTest(weights, dimension, verbose);
    fit = -fitness;
end
