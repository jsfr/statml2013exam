function wML = linearRegression(data)
    x      = data(:, 1:end-1);
    t      = data(:, end);
    bias   = ones(size(x, 1), 1);

    Phi = [ bias x ];
    wML = pinv(Phi) * t;
end