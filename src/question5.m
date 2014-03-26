format shortG

% NB question 4 is expected to be run before question 5, as we need the data

data = importdata('../data/SGTrain2014.dt');
labels = data(:, end);
data = data(:, 1:end-1);

rng(43786953); % Sets the random seed to ensure consistent results on reruns
[idx, centres] = kmeans(data, 2, 'replicates', 100);

% Report the centres, but NOT the idx vector
c1 = centres(1, :)'
c2 = centres(2, :)'

projCentres = centres * prinComps;

handle = figure(1);

% The assumed classes by k-means
plot(projData(idx == 1,1), projData(idx == 1,2), 'b.');
hold on;
plot(projData(idx == 2,1), projData(idx == 2,2), 'g.');
plot(projCentres(:,1), projCentres(:,2), 'r.', 'Marker', '.', 'MarkerSize', 20);
xlabel('pc_1');
ylabel('pc_2');
legend('class 1', 'class 1', 'centres');
utils.betterPlots(handle);
print(handle, '-depsc2', '../figures/question5_1.eps');
hold off;

% The actual classes
plot(projData(labels == 0, 1), projData(labels == 0, 2), 'b.');
hold on;
plot(projData(labels == 1, 1), projData(labels == 1, 2), 'g.');
plot(projCentres(:,1), projCentres(:,2), 'r.', 'Marker', '.', 'MarkerSize', 20);
xlabel('pc_1');
ylabel('pc_2');
legend('galaxy', 'star', 'centres');
utils.betterPlots(handle);
print(handle, '-depsc2', '../figures/question5_2.eps');
hold off;