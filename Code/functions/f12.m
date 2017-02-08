%
%
% No confiar en esta funcion
%
%

function f = f12(x, o, A, M, a, alpha, b)

    [ps, D] = size(x);
    if length(alpha) >= D
        alpha = alpha(1 : D);
        b = b(1 : D, 1 : D);
        a = a(1 : D, 1 : D);
        
    else
        alpha = -3 + 6 * rand(1, D);
        a = round(-100 + 200 .* rand(D, D));
        b = round(-100 + 200 .* rand(D, D));
    end
    alpha = repmat(alpha, D, 1);
    A = sum(a .* sin(alpha) + b .* cos(alpha), 2);
    for i = 1 : ps
        xx = repmat(x(i, :), D, 1);
        B = sum(a .* sin(xx) + b .* cos(xx), 2);
        f(i, 1) = sum((A - B) .^ 2, 1);
    end
    
end