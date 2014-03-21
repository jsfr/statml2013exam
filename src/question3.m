format shortG
libsvmpath = 'libsvm-3.17/matlab'; % If libsvm lies somewhere else change this

trainData = importdata('../data/SGTrain2014.dt');
testData = importdata('../data/SGTest2014.dt');

[gamma, sigma] = utils.jaakkola(trainData)

n = 3;
k = 2;
bases = [2, exp(1), 10];

c = arrayfun(@(x) [x.^[-k:n]'], bases, 'UniformOutput', false);
g = arrayfun(@(x) gamma*[x.^[-n:n]'], bases, 'UniformOutput', false);

params = cellfun(@(y, z) cell2mat(arrayfun(@(x) [ y repmat(x, ...
                 size(y, 1), 1) ], z, 'UniformOutput', false)), ...
                 c, g, 'UniformOutput', false);
params = cell2mat(params');

% first column of bestParams = cost, second column of bestParams = gamma
[bestParams, minError] = utils.crossValidation(trainData, 5, params, libsvmpath);

addpath(libsvmpath);
flags = ['-c ' num2str(bestParams(1)) ' -g ' num2str(bestParams(2)) ' -q'];
model = svmtrain(trainData(:,end), trainData(:,1:end-1), flags);

C1 = svmpredict(trainData(:, end), trainData(:, 1:end-1), model);
C2 = svmpredict(testData(:, end), testData(:, 1:end-1), model);

trainError = sum(testData(:, end) ~= C1) / length(C1)
testError = sum(testData(:, end) ~= C2) / length(C2)