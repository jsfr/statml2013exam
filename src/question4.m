addpath('functions');
format shortG

data = importdata('../data/SGTrain2014.dt');

coeff = pca(data)