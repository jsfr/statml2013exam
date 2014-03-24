format shortG

trainData = importdata('../data/SSFRTrain2014.dt');
testData = importdata('../data/SSFRTest2014.dt');

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

mseTrain
mseTest

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
print(handle, '-depsc2', '../figures/question2.eps');
hold off;

