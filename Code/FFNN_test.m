ALG = {@ALG_DE @ParticleSwarmOptimization @EDA_FullGaus};
algorithms = 3;

hiddenSize = 2;
[xx,t] = engine_dataset;
net = feedforwardnet(hiddenSize);
net = configure(net,xx,t);
wbSize = size(getwb(net));
dim = wbSize(1)

objectiveValue = 0;
individuals = 25;
generations = 10;
lower = -1;
upper = 1;

x = rand(dim,1);
tic
for i=1:100
    simpleFFNN(x, net, xx, t);
end
toc
