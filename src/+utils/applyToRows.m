function outMatrix = applyToRows(inFunc, inMatrix)
    applyToGivenRow = @(func, matrix) @(row) func(matrix(row, :));
    newApplyToRows = @(func, matrix) arrayfun(applyToGivenRow(func, matrix), 1:size(matrix,1), 'UniformOutput', false)';
    takeAll = @(x) reshape([x{:}], size(x{1},2), size(x,1))';
    genericApplyToRows = @(func, matrix) takeAll(newApplyToRows(func, matrix));

    outMatrix = genericApplyToRows(inFunc, inMatrix);
end