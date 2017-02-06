X = [100;1000;1100;900;1900];
pd = fitdist(X, 'Normal');
random(pd)