function err = meanSquaredError(y, t)
    err = sum((y - t).^2) / length(t);
end