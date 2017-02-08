%
%
%
%
%

function f = f11(x, o, A, M, a, alpha, b)

    [ps, D] = size(x);
    if length(o) >= D
        o = o(1 : D);
    else
        o = -0.5 + 0.5 * rand(1, D);
    end
    x = x - repmat(o, ps, 1);
    x = x * M;
    x = x + 0.5;
    a = 0.5;%0<a<1
    b = 3;
    kmax = 20;
    [ps, D] = size(x);
    c1(1 : kmax + 1) = a .^ (0 : kmax);
    c2(1 : kmax + 1) = 2 * pi * b .^ (0 : kmax);
    c = -w(0.5, c1, c2);
    f = 0;
    for i = 1 : D
        f = f + w(x(:, i)', c1, c2);
    end
    f = f + repmat(c * D, ps, 1);
    
end

function y = w(x, c1, c2)
    y = zeros(length(x), 1);
    for k = 1 : length(x)
        y(k) = sum(c1 .* cos(c2 .* x(:, k)));
    end
end
