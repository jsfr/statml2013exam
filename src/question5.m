format shortG

% NB question 4 is expected to be run before question 5, as we need the data

data = importdata('../data/SGTrain2014.dt');
data = data(:, 1:end-1);

[idx, centres] = kmeans(data, 2);

centres % Report the centres, but NOT the idx vector

projCentres = centres * prinComps;

handle = figure(1);
plot(projData(idx == 1,1), projData(idx == 1,2), 'b.');
hold on;
plot(projData(idx == 2,1), projData(idx == 2,2), 'g.');
plot(projCentres(:,1), projCentres(:,2), 'r.', 'Marker', '.', 'MarkerSize', 20);
xlabel('pc_1');
ylabel('pc_2');
legend('class 1', 'class 2', 'centres');
utils.betterPlots(handle);
print(handle, '-depsc2', '../figures/question5_1.eps');
hold off;