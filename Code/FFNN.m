layers = [4,2,1]
dimension = NeuralNetworkSize(layers)
input = randperm(layers(1))
weights = randperm(dimension)
output = NeuralNetwork(input, weights, layers)