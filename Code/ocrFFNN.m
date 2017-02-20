function fit = simpleFFNN(weights, layers, train_input, train_output)
    c = 0;
    it = size(train_input,1);
    sse = 0;
    for i=1:it
        output = NeuralNetwork(train_input(i,:), weights, layers);
        c=c+size(output,2);
        
        diff = (train_output(:,1) - output).^2;
        sse = sse + sum(diff);
    end
    
    fit = sse/c/2;
end
