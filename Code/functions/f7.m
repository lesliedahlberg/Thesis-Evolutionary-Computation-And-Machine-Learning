%
%
%
%
%

function f = f7(x, o, A, M, a, alpha, b)

    [ps, D] = size(x);
    if length(o) >= D
        o = o(1 : D);
    else
        o = -600 + 0 * rand(1, D);
    end
    o = o(1 : D);
    x = x - repmat(o, ps, 1);
    x = x * M;
    f = 1;
    for i = 1 : D
        f = f .* cos(x(:, i) ./ sqrt(i));
    end
    f = sum(x .^ 2, 2) ./ 4000 - f + 1;

end