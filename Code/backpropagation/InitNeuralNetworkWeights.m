function [weights] = InitNeuralNetworkWeights(layers)
    
    numLayers = size(layers,2);
    weights = cell(numLayers-1);
    
    %% Init Layer Weights
    for l=1:numLayers-1
        dim = [layers(l)+1, layers(l+1)];
        weights{l} = rand(dim) - 0.5;
    end
    
end

