function predictLDA = trainLDA(data, labels)
    C = unique(labels);
    n = size(data, 1);

    mu = arrayfun(@(c) mean(data(labels == c, :), 1)', C', 'UniformOutput', false);
    Pr = arrayfun(@(c) length(labels(labels == c))/n, C);

    datak = arrayfun(@(c) data(labels == c, :)', C', 'UniformOutput', false);
    datak = arrayfun(@(k) datak{k} - repmat(mu{k}, 1, size(datak{k}, 2)), ...
                     (1:length(C)), 'UniformOutput', false);
    datak = cell2mat(datak);
    datak = mat2cell(datak, size(datak, 1), ones(size(datak, 2), 1));
    datak = cellfun(@(x) x * x', datak, 'UniformOutput', false);

    Sigma = 1/(n - length(C)) * sum(cat(3, datak{:}), 3);

    delta = @(x, k) x' * Sigma^-1 * mu{k} - 1/2 * mu{k}' * ...
                    Sigma^-1 * mu{k} + log(Pr(k));

    cellX = @(X) mat2cell(X, ones(size(X, 1), 1), size(X, 2));
    predictLDA = @(X) cellfun(@(x) ...
                               classifyPoint(x, delta, C), cellX(X));
end

function label = classifyPoint(x, delta, C)
    deltas = arrayfun(@(k) delta(x', k), 1:length(C));
    [~, idx] = max(deltas);
    label = C(idx);
end