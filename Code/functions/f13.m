%
%
%
%
%

function fit = f13(x, o, A, M, a, alpha, b)

    [ps, D] = size(x);
    if length(o) >= D
        o = o(1 : D);
    else
        o = -1 + 1 * rand(1, D);
    end
    x = x - repmat(o, ps, 1) + 1;
    fit = 0;
    for i = 1 : (D - 1)
        fit = fit + F8F2(x(:, [i, i + 1]));
    end
    fit = fit + F8F2(x(:, [D, 1]));
    
end

function f = F8F2(x)
f2 = 100 .* (x(:, 1).^2 - x(:, 2)).^2 + (1 - x(:, 1)).^2;
f = 1 + f2 .^ 2 ./ 4000 - cos(f2);
end