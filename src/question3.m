addpath('functions');
addpath('libsvm-3.17/matlab');
format shortG


trainData = importdata('../data/SGTrain2014.dt');
testData = importdata('../data/SGTest2014.dt');

[gamma, sigma] = jaakkola(trainData)

n = 3;
k = 2;
bases = [2, exp(1), 10];

c = arrayfun(@(x) [x.^[-k:n]'], bases, 'UniformOutput', false);
g = arrayfun(@(x) gamma*[x.^[-n:n]'], bases, 'UniformOutput', false);

params = cellfun(@(y, z) cell2mat(arrayfun(@(x) [ y repmat(x, size(y, 1), 1) ], z, ...
            'UniformOutput', false)), c, g, 'UniformOutput', false);
params = cell2mat(params');

% first column of bestParams = cost, second column of bestParams = gamma
[bestParams, minError] = crossValidation(trainData, 5, params, 'libsvm-3.17/matlab')

flags = ['-c ' num2str(bestParams(1)) ' -g ' num2str(bestParams(2)) ' -q'];
model = svmtrain(trainData(:,end), trainData(:,1:end-1), flags);
C = svmpredict(testData(:, end), testData(:, 1:end-1), model);
testError = sum(testData(:, end) ~= C) / length(C)

% means = mean(trainData(:, 1:end-1), 1);
% vars = var(trainData(:, 1:end-1), 0, 1);
% stds = std(trainData(:, 1:end-1), 0, 1);

% normTrainData = [ fNorm(trainData(:, 1:end-1), means, stds) trainData(:, end) ];
% normTestData = [ fNorm(testData(:, 1:end-1), means, stds) testData(:, end) ];

% normTrainMeans =  mean(normTrainData(:, 1:end-1), 1);
% normTainVars = var(normTrainData(:, 1:end-1), 0, 1);

% normTestMeans =  mean(normTestData(:, 1:end-1), 1);
% normTestVars = var(normTestData(:, 1:end-1), 0, 1);

% % first column of normBestParams = cost, second column of bestParams = gamma
% [normBestParams, normMinError] = crossValidation(normTrainData, 5, params, 'libsvm-3.17/matlab')

% normflags = ['-c ' num2str(normBestParams(1)) ' -g ' num2str(normBestParams(2)) ' -q'];
% normModel = svmtrain(normTrainData(:,end), normTrainData(:,1:end-1), normflags);
% normC = svmpredict(normTestData(:, end), normTestData(:, 1:end-1), normModel);
% normTestError = sum(normTestData(:, end) ~= normC) / length(normC)