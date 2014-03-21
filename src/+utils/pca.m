function [prinComps, V] = pca(data)
    S = cov(data, 1);

    [prinComps, eigValMatrix] = eig(S);
    V = diag(eigValMatrix);

    % sort the variances in decreasing order
    [V, idxs] = sort(V, 'descend');
    prinComps = prinComps(:, idxs);
end