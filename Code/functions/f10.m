%
%
%
%
%

function f = f10(x, o, A, M, a, alpha, b)

    [ps, D] = size(x);
    if length(o) >= D
        o = o(1 : D);
    else
        o = -5 + 10 * rand(1, D);
    end
    x = x - repmat(o, ps, 1);
    x = x * M;
    f = sum(x .^ 2 - 10 .* cos(2 .* pi .* x) + 10, 2);
    
end