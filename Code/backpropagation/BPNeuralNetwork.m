function [output, outputs] = BPNeuralNetwork(input, weights, layers)
    
    numLayers = size(layers,2);
    net = cell(numLayers,1);
    outputs = cell(numLayers,1);
    net{1} = input;
    outputs{1} = net{1};
    
    %% Process Layers
    for l=2:numLayers
        net{l} = [outputs{l-1} -1] * weights{l-1};
        outputs{l} = sigmoid(net{l});
    end
    
    output = outputs(numLayers);
end

