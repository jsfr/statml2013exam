function y = polyPredict(x, degree, weights)
    bias   = ones(size(x, 1), 1);

    polyFun = @(r, ds) cell2mat(arrayfun(@(d) sum(r.^d), ...
                                         ds, 'UniformOutput', false));
    xs = mat2cell(x, ones(size(x, 1), 1), size(x, 2));

    polyX = cellfun(@(r) polyFun(r, 1:degree), xs, 'UniformOutput', false);
    polyX = cell2mat(polyX);

    Phi = [ bias polyX ];
    y = Phi * weights;
end