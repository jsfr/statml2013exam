function normData = fNorm(data, means, stds)
    means = vector(means, 'row');
    stds = vector(stds, 'row');
    normData = data - repmat(means, size(data, 1), 1);
    normData = normData ./ repmat(stds, size(data, 1), 1);
end