format shortG

trainData = importdata('../data/VSTrain2014.dt');
testData = importdata('../data/VSTest2014.dt');

% Linear classification
fprintf('## Linear classification ##\n');
predictLDA = utils.trainLDA(trainData(:, 1:end-1), trainData(:, end));

C1 = predictLDA(trainData(:, 1:end-1));
C2 = predictLDA(testData(:, 1:end-1));

trainError1 = sum(trainData(:, end) ~= C1) / length(C1)
testError1 = sum(testData(:, end) ~= C2) / length(C2)

% Nonlinear classification
fprintf('## Nonlinear classification ##\n');
knnClassify = @(param, tData, hData) utils.kNN(tData, hData(:, 1:end-1), param);

[bestK, minError] = utils.crossValidation(trainData, 5, (1:25)', knnClassify)

C3 = utils.kNN(trainData, trainData(:, 1:end-1), bestK);
C4 = utils.kNN(trainData, testData(:, 1:end-1), bestK);

trainError2 = sum(trainData(:, end) ~= C3) / length(C3)
testError2 = sum(testData(:, end) ~= C4) / length(C4)