function [output] = NeuralNetwork(input, weights, layers)
    input_neurons = layers(1);
    hidden_neurons = layers(2);
    output_neurons = layers(3);
    
    input_weights = zeros(input_neurons+1, hidden_neurons);
    output_weights = zeros(hidden_neurons+1, output_neurons);
    
    k = 1;
    
    for i=1:input_neurons+1
        for j=1:hidden_neurons
            input_weights(i,j) = weights(k);
            k = k + 1;
        end
    end

    for i=1:hidden_neurons+1
        for j=1:output_neurons
            output_weights(i,j) = weights(k);
            k = k + 1;
        end
    end
    
    
    input = [input -1];
    
    
    
    hidden = [input*input_weights -1];
    output = hidden*output_weights;
end

