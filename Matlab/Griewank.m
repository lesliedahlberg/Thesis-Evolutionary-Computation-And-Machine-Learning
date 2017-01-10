function y = Griewank(X)
%GRIEWANK optimization test function
    sum = 0;
    product = 1;
    n = length(X);

    for i = 1:n
        product = product * cos(X(i)/sqrt(i));
        sum = sum + X(i).^2;
    end
    
    y = (1/4000) * sum - product + 1;
end

