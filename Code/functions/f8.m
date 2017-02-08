%
%
%
%
%

function f = f8(x, o, A, M, a, alpha, b)

    [ps, D] = size(x);
    if length(o) >= D
        o = o(1 : D);
    else
        o = -30 + 60 * rand(1, D);
    end
    o(2 .* [1 : floor(D / 2)] - 1) = -32;
    x = x - repmat(o, ps, 1);
    x = x * M;
    f = sum(x .^ 2, 2);
    f = 20 - 20.* exp(-0.2 .* sqrt(f ./ D)) - exp(sum(cos(2 .* pi .* x), 2) ./ D) + exp(1);

end