function y = Rastrigin(X)
%RASTRIGIN optimization test function
    sum = 0;
    n = length(X);

    for i = 1:n
        sum = sum + (X(i).^2 - 10*cos(2 * pi * X(i)) + 10);
    end
    
    y = sum;
end

