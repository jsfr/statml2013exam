function wML = polyRegression(data, degree)
    x      = data(:, 1:end-1);
    t      = data(:, end);
    bias   = ones(size(x, 1), 1);

    polyFun = @(r, ds) cell2mat(arrayfun(@(d) sum(r.^d), ...
                                         ds, 'UniformOutput', false));
    xs = mat2cell(x, ones(size(x, 1), 1), size(x, 2));

    polyX = cellfun(@(r) polyFun(r, 1:degree), xs, 'UniformOutput', false);
    polyX = cell2mat(polyX);

    Phi = [ bias polyX ];
    wML = pinv(Phi) * t;
end