function y = Rosenbrock(X)
%ROSENBROCK optimization test function
    sum = 0;
    n = length(X);

    for i = 1:n-1
        sum = sum + (100*(X(i+1)-X(i).^2).^2 + (1-X(i)).^2);
    end
    
    y = sum;
end

