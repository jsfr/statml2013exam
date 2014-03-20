addpath('functions');
format shortG

trainData = importdata('../data/SSFRTrain2014.dt');
testData = importdata('../data/SSFRTest2014.dt');

trainBias = ones(size(trainData, 1), 1);
testBias = ones(size(testData, 1), 1);

wML = polyRegression(trainData)

% yTrain   = [ trainBias trainData(:, 1:end-1) ] * wML;
% mseTrain = meanSquaredError(yTrain, trainData(:, end))

% yTest   = [ testBias testData(:, 1:end-1) ] * wML;
% mseTest = meanSquaredError(yTest, testData(:, end))