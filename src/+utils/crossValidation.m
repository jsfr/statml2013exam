function [bestParams, minError] = crossValidation(data, folds, params, libsvmpath)
    % addpath to the libsvm toolbox
    addpath(libsvmpath);

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
            flags = ['-c ' num2str(params(r, 1)) ' -g ' num2str(params(r, 2)) ' -q'];
            model = svmtrain(trainData(:,end), trainData(:,1:end-1), flags);
            C = svmpredict(heldOut(:, end), heldOut(:, 1:end-1), model, '-q');
            Sums(r) = Sums(r) + sum(heldOut(:, end) ~= C) / length(C);
        end
    end

    [minError, idx] = min(Sums);
    minError = minError / folds;
    bestParams = params(idx, :);
end