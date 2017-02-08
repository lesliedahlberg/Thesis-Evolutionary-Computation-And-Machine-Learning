%
%
%
%
%

function f = f6(x, o, A, M, a, alpha, b)

    [ps, D] = size(x);
    if length(o) >= D
        o = o(1 : D);
    else
        o = -90 + 180 * rand(1, D);
    end
    x = x - repmat(o, ps, 1) + 1;
    f = sum(100 .* (x(:, 1 : D - 1) .^ 2 - x(:, 2 : D)) .^ 2 + (x(:, 1 : D - 1) - 1) .^ 2, 2);


end