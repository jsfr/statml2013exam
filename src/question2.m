format shortG

trainData = importdata('../data/SSFRTrain2014.dt');
testData = importdata('../data/SSFRTest2014.dt');


% Polynomial regression, maximum likelihood
fprintf('## Polynomial regression, maximum likelihood ##\n'); 
trainBias = ones(size(trainData, 1), 1);
testBias = ones(size(testData, 1), 1);

n = 15;

mseTrain = zeros(n, 1);
mseTest  = zeros(n, 1);

for i = 1:n
    wML = utils.polyRegression(trainData, i);

    yTrain = utils.polyPredict(trainData(:,1:end-1), i, wML);
    yTest  = utils.polyPredict(testData(:,1:end-1), i, wML);
    
    mseTrain(i) = utils.meanSquaredError(yTrain, trainData(:, end));
    mseTest(i)  = utils.meanSquaredError(yTest, testData(:, end));
end

[minTrain1, trainIdx1] = min(mseTrain)
minTest1 = mseTest(trainIdx1)

handle = figure(1);
semilogy(mseTrain, 'r-', 'LineWidth', 1.5);
hold on;
semilogy(mseTest, 'b-', 'LineWidth', 1.5);
xlabel('degree of polynomium');
ylabel('MSE')
legend('Training data', 'Test data');
set(gca,'XTick', 1:1:n);
xlim([1 n]);
utils.betterPlots(handle);
print(handle, '-depsc2', '../figures/question2_1.eps');
hold off;


% Neural network
fprintf('## Neural network ##\n'); 
rng(43786953); % Sets the random seed to ensure consistent results on reruns
n = 100;
mseTrain = zeros(n, 1);
mseTest  = zeros(n, 1);

for i = 1:n
    % Create a Fitting Network
    hiddenLayerSize = i;
    net = fitnet(hiddenLayerSize, 'trainrp');

    % Set up Division of Data for Training, Validation, Testing
    net.divideParam.trainRatio = 70/100;
    net.divideParam.valRatio = 15/100;
    net.divideParam.testRatio = 15/100;
     
    % Train the Network
    net.trainFcn = 'trainrp';
    net.trainParam.showWindow = 0;
    net = train(net, trainData(:, 1:end-1)', trainData(:, end)');
     
    % Test the Network
    yTrain = net(trainData(:, 1:end-1)')';
    mseTrain(i) = utils.meanSquaredError(yTrain, trainData(:, end));

    yTest = net(testData(:, 1:end-1)')';
    mseTest(i) = utils.meanSquaredError(yTest, testData(:, end));
end

[minTrain2, trainIdx2] = min(mseTrain)
minTest2 = mseTest(trainIdx2)

handle = figure(1);
plot(mseTrain, 'b-', 'LineWidth', 1.5);
hold on;
plot(mseTest, 'r-', 'LineWidth', 1.5);
xlabel('# of hidden neurons');
ylabel('MSE')
legend('Training data', 'Test data');
xlim([1 n]);
utils.betterPlots(handle);
print(handle, '-depsc2', '../figures/question2_2.eps');
hold off;