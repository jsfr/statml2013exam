function resClasses = kNN(trainData, points, k)
    C = trainData(:, end);
    X = trainData(:, 1:end-1);

    cellPoints = mat2cell(points, ones(size(points, 1), 1), size(points, 2));
    resClasses = cellfun(@(x) kNNPoint(X, x, C, k), cellPoints);
end

function resClass = kNNPoint(X, x, C, k)
    D = sum((X - repmat(x, size(X, 1), 1)).^2, 2);
    DC = sortrows([D C], 1);
    DC = DC(1:k, 2);

    % Finds the most frequent class.
    % Ties are broken by choosing the smallest
    resClass = mode(DC);
end