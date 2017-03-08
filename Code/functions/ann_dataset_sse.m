function fit = ann_dataset_see(weights, layers, train_input, train_output)
    c = 0;
    it = size(train_input,2);
    sse = 0;
    trainSize =floor(it/2);
    train = randperm(it,trainSize);
    %for i=1:it
    for i=train
        output = NeuralNetwork(train_input(:,i)', weights, layers);
        c=c+size(output,2);
        
        sse = sse + sum((train_output(:,i)' - output).^2);
    end
    
    fit = sse/c/2;
end
