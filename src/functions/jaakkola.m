function [gamma, sigma] = jaakkola(data)
    G = [];
    
    % Compute the set G of minimum distances to a point with a different label
    for i = 1:size(data, 1)
        filtData = data(data(:, end) ~= data(i, end), :);
        repPoint = repmat(data(i, :), size(filtData, 1), 1);
        
        diffs = filtData(:, 1:end-1) - repPoint(:, 1:end-1);
        sqSums = sum(diffs.^2, 2);
        distances = sqrt(sqSums);

        G(end+1, :) = min(distances);
    end

    sigma = median(G);
    gamma = 1/(2*sigma^2);
end