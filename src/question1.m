format shortG

trainData = importdata('../data/SSFRTrain2014.dt');
testData = importdata('../data/SSFRTest2014.dt');

trainBias = ones(size(trainData, 1), 1);
testBias = ones(size(testData, 1), 1);

wML = utils.linearRegression(trainData)

yTrain   = [ trainBias trainData(:, 1:end-1) ] * wML;
mseTrain = utils.meanSquaredError(yTrain, trainData(:, end))

yTest   = [ testBias testData(:, 1:end-1) ] * wML;
mseTest = utils.meanSquaredError(yTest, testData(:, end))