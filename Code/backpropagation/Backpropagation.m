function [weights] = Backpropagation(inputs, outputs, layers, learningRate, threshold)
    %% Init ANN
    weights = InitNeuralNetworkWeights(layers);
    
    %% Run BP
    testCases = size(inputs,1);
    numLayers = size(layers,2);
    
    iterations = 0;
    foundSolution = false;
    sses = zeros(1, testCases);
    
    while foundSolution == false
        iterations = iterations + 1;
        for i=1:testCases
            %% Forward
            [nn_output, nn_outputs] = BPNeuralNetwork(inputs(i,:), weights, layers);
            
            %% Output layer - BP
            o = nn_outputs{numLayers};
            
            m1 = outputs(i) == 1;
            m0 = outputs(i) == -1;
            t = m1*0.75 + m0*0.25;
            
            e = t - o;
            d{numLayers} = e.*o.*(1-o);
            dw = (learningRate * d{numLayers}' * [nn_outputs{numLayers-1} -1])';
            weights{numLayers-1} = weights{numLayers-1} + dw;
            
            
            %% Hidden Layers - BP
            for l=numLayers-1:2
                o = nn_outputs{l};
                s = d{l+1} * (weights{l}(1:end-1,:))';
                d{l} = (1-o).*o.*(s);
                dw = (learningRate * d{l}' * [nn_outputs{l-1} -1])';
                weights{l-1} = weights{l-1} + dw;
            end
            
            sses(i) = sum(e.^2);
        end
        
        %% Stop condition
        sse = sum(sses) / (2*testCases);
        disp(strcat(num2str(iterations),'->',num2str(sse)));
        sses
        if sse < threshold
            foundSolution = true;
            sse
            iterations
        end
    end
end






