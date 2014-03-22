format shortG;

data = importdata('../data/SGTrain2014.dt');
data = data(:, 1:end-1);

[prinComps, V] = utils.pca(data);

projData = data * prinComps;

handle = figure(1);
plot(1:length(V), V);
xlim([1,11]);
xlabel('i');
ylabel('\lambda_i');
utils.betterPlots(handle);
print(handle, '-depsc2', '../figures/question4_1.eps');

plot(projData(:,1), projData(:,2), '.');
xlabel('pc_1');
ylabel('pc_2');
utils.betterPlots(handle);
print(handle, '-depsc2', '../figures/question4_2.eps');