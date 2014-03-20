function [bestparams, minError] = crossValidation(data, folds, params, libsvmpath)
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
        Traindata = [];
        for j=1:length(K)
            if j == i
                HeldOut = K{j};
            else
                Traindata = [Traindata ; K{j}];
            end
        end

        for r = 1:size(params, 1)
            flags = ['-c ' num2str(params(r, 1)) ' -g ' num2str(params(r, 2)) ' -q'];
            model = svmtrain(Traindata(:,end), Traindata(:,1:end-1), flags);
            C = svmpredict(HeldOut(:, end), HeldOut(:, 1:end-1), model, '-q');
            Sums(r) = Sums(r) + sum(HeldOut(:, end) ~= C) / length(C);
        end
    end

    [minError, idx] = min(Sums);
    minError = minError / folds;
    bestparams = params(idx, :);
end