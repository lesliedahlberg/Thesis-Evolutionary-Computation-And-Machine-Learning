function y = Ackley(X)
%GRIEWANK optimization test function
    sum1 = 0;
    sum2 = 0;
    n = length(X);

    for i = 1:n
        sum1 = sum1 + X(i).^2;
        sum2 = sum2 + cos(2 * pi * X(i));
    end
    
    y = -20 * exp(-0.2 * sqrt((1/n) * sum1)) - exp((1/n) * sum2) + 20 + exp(1);
end

