%
%
%
%
%

function fit = f3(x, o, A, M, a, alpha, b)

    [ps, D] = size(x);
    if length(o) >= D
        o = o(1 : D);
    else
        o = -100 + 200 * rand(1, D);
    end
    x = x - repmat(o, ps, 1);
    x = x * M;
    a = 1e+6;
    fit = 0;
    for i = 1 : D
        fit = fit + a .^ ((i - 1) / (D - 1)) .* x(:, i).^2;
    end

end