function outVector = vector(inVector, dim)
    if isvector(inVector)
        if dim == 'row' | dim == 1 % make a row
            outVector = reshape(inVector, [1 numel(inVector)]);
        elseif dim == 'col' | dim == 2 % make a column
            outVector = reshape(inVector, [numel(inVector) 1]);
        else
            error('Dimension not valid');
        end
    else
        error('Input was not a vector');
    end
end