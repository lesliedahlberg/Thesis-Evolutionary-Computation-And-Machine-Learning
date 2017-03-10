function fit = ann_dataset_sse(weights, layers, train_input, train_output)
    
testCases = size(train_input,2);
for i=1:size(train_input,2)
    o = NeuralNetworkOpenEnd(train_input(:,i)', weights, layers);
    e = train_output(:,i)' - o;
    sses(i) = sum(e.^2);
end
sse = sum(sses) / (2*testCases);

fit = sse;
end
