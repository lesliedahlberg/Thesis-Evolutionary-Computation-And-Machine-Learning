function [dimension] = BPNeuralNetworkSize(layers)
    input_neurons = layers(1);
    hidden_neurons = layers(2);
    output_neurons = layers(3);
    dimension = (input_neurons+1) * hidden_neurons + (hidden_neurons+1) * output_neurons;
end

