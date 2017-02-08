%
%
%
%
%

function populationFitness = calculatePopulationFitness(func, population, o, A, M, a, alpha, b)
                                                                                
    populationSize = size(population,1);
    dimension = size(population,2);
    populationFitness = zeros(1,populationSize);

    i = 1;
    
    while i <= populationSize
        
        if func == 1

            populationFitness(i) = f1_2005(population(i,:), o, A, M, a, alpha, b);

        end

        if func == 2

            populationFitness(i) = f2_2005(population(i,:), o, A, M, a, alpha, b);

        end

        if func == 3

            populationFitness(i) = f3_2005(population(i,:), o, A, M, a, alpha, b);

        end

        if func == 4

            populationFitness(i) = f4_2005(population(i,:), o, A, M, a, alpha, b);

        end

        if func == 5

            populationFitness(i) = f5_2005(population(i,:), o, A, M, a, alpha, b);

        end

        if func == 6

            populationFitness(i) = f6_2005(population(i,:), o, A, M, a, alpha, b);

        end

        if func == 7

            populationFitness(i) = f7_2005(population(i,:), o, A, M, a, alpha, b);

        end

        if func == 8

            populationFitness(i) = f8_2005(population(i,:), o, A, M, a, alpha, b);

        end

        if func == 9

            populationFitness(i) = f9_2005(population(i,:), o, A, M, a, alpha, b);

        end

        if func == 10

            populationFitness(i) = f10_2005(population(i,:), o, A, M, a, alpha, b);

        end

        if func == 11

            populationFitness(i) = f11_2005(population(i,:), o, A, M, a, alpha, b);

        end

        if func == 12

            populationFitness(i) = f12_2005(population(i,:), o, A, M, a, alpha, b);

        end

        if func == 13

            populationFitness(i) = f13_2005(population(i,:), o, A, M, a, alpha, b);

        end
        
        i = i + 1;
        
    end

end