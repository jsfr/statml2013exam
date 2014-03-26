function [bestParams, minError] = crossValidation(data, folds, params, fun)

    data = sortrows(data, size(data, 2));
    K = cell(folds, 1);

    for i=1:size(data, 1)
        idx = mod(i, folds) + 1;
        K{idx} = [ K{idx} ; data(i, :) ];
    end

    Sums = zeros(size(params, 1), 1);

    for i=1:length(K)
        heldOut = K{i};
        trainData = cell2mat({K{[1:i-1 i+1:end]}}');

        for r = 1:size(params, 1)
            C = fun(params(r, :), trainData, heldOut);
            Sums(r) = Sums(r) + sum(heldOut(:, end) ~= C) / length(C);
        end
    end

    [minError, idx] = min(Sums);
    minError = minError / folds;
    bestParams = params(idx, :);
end