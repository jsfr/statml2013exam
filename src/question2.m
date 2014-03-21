format shortG

trainData = importdata('../data/SSFRTrain2014.dt');
testData = importdata('../data/SSFRTest2014.dt');

trainBias = ones(size(trainData, 1), 1);
testBias = ones(size(testData, 1), 1);

%NOT DONE!