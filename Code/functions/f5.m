%
%
%
% No confiar en esta funcion
%

function f = f5(x, o, A, M, a, alpha, b)

    [ps, D] = size(x);
    if length(o) >= D
        A = A(1 : D, 1 : D); o = o(1 : D);
    else
        o = -100 + 200 * rand(1, D);
        A = round(-100 + 2 * 100 .* rand(D, D));
        while det(A) == 0
            A = round(-100 + 2 * 100 .* rand(D, D));
        end
    end
    o(1 : ceil(D / 4)) = -100; o(max(floor(0.75 * D), 1) : D) = 100;
    B = A * o';
    for i = 1 : ps
        f(i, 1) = max(abs(A * (x(i, :)') - B));
    end
    
end