format shortG
libsvmpath = 'libsvm-3.17/matlab'; % If libsvm lies somewhere else change this

trainData = importdata('../data/SGTrain2014.dt');
testData = importdata('../data/SGTest2014.dt');

[gamma, sigma] = utils.jaakkola(trainData)

n = 3;
k = 2;
bases = {2, exp(1), 10};

c = cellfun(@(x) x.^(-k:n)', bases, 'UniformOutput', false);
g = cellfun(@(x) gamma*x.^(-n:n)', bases, 'UniformOutput', false);

params = cellfun(@(y, z, b) cell2mat(arrayfun(@(x) [y repmat([x b], ...
                 size(y, 1), 1) y ], z, 'UniformOutput', false)), ...
                 c, g, bases, 'UniformOutput', false);
params = cell2mat(params');

% first column of bestParams = cost, second = gamma and third = base
[bestParams, minError] = utils.crossValidation(trainData, 5, params, libsvmpath)

addpath(libsvmpath);
flags = ['-c ' num2str(bestParams(1)) ' -g ' num2str(bestParams(2)) ' -q'];
model = svmtrain(trainData(:,end), trainData(:,1:end-1), flags);

C1 = svmpredict(trainData(:, end), trainData(:, 1:end-1), model);
C2 = svmpredict(testData(:, end), testData(:, 1:end-1), model);

trainError = sum(trainData(:, end) ~= C1) / length(C1)
testError = sum(testData(:, end) ~= C2) / length(C2)